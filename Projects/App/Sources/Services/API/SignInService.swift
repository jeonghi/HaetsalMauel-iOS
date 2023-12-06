//
//  SignInService.swift
//  App
//
//  Created by 쩡화니 on 12/5/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//
import Foundation
import Combine
import FirebaseAuth
import AuthenticationServices
import CryptoKit

protocol SignInServiceType {
  func loginWithAppleAccount(completition: @escaping (String?, Error?) -> Void)
  
}

final class SignInService: NSObject, SignInServiceType {
  
  fileprivate var currentNonce: String?
  static var shared = SignInService()
  
  var completitionHandler: ((String?, Error?) -> Void)?
  
  private override init(){
    super.init()
  }
  
  public func loginWithAppleAccount(completition: @escaping (String?, Error?) -> Void) {
    completitionHandler = completition
    let nonce = randomNonceString()
    currentNonce = nonce
    let provider = ASAuthorizationAppleIDProvider()
    let request = provider.createRequest()
    request.requestedScopes = [.email, .fullName]
    request.nonce = sha256(nonce)
    
    let authController = ASAuthorizationController(authorizationRequests: [request])
    authController.delegate = self
    authController.performRequests()
  }
}

extension SignInService: ASAuthorizationControllerDelegate {
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error signing in with Apple: \(error.localizedDescription)")
    }
  
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
      if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
        guard let nonce = currentNonce else {
          fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
          print("Unable to fetch identity token")
          return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
          print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
          return
        }
        
        // Initialize a Firebase credential.
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idTokenString,
                                                  rawNonce: nonce)
        
        Auth.auth().signIn(with: credential){ result, error in
          if let error = error {
            self.completitionHandler?(nil, error)
          } else if let result = result {
            result.user.getIDToken(completion: self.completitionHandler)
          }
        }
      }
  }
}

extension SignInService {
  
  private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
      let randoms: [UInt8] = (0 ..< 16).map { _ in
        var random: UInt8 = 0
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
        if errorCode != errSecSuccess {
          fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
        }
        return random
      }
      
      randoms.forEach { random in
        if length == 0 {
          return
        }
        
        if random < charset.count {
          result.append(charset[Int(random)])
          remainingLength -= 1
        }
      }
    }
    
    return result
  }
  
  private func sha256(_ input: String)-> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap{
      return String(format: "%02x",$0)
    }.joined()
    return hashString
  }
}
