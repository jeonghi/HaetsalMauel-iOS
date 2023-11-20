
import UIKit
import KakaoSDKAuth
import KakaoSDKCommon

// MARK: - AppDelegate

final class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if (AuthApi.isKakaoTalkLoginUrl(url)) {
      return AuthController.handleOpenUrl(url: url)
    }
    
    return false
  }
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    KakaoSDK.initSDK(appKey: "ba30c405908be1afda46343b5b73b363")
    AppAppearance.setupAppearance()
    return true
  }
}
