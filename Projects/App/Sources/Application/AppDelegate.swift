
import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import FirebaseCore

// MARK: - AppDelegate

final class AppDelegate: UIResponder, UIApplicationDelegate {
  
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if (AuthApi.isKakaoTalkLoginUrl(url)) {
      return AuthController.handleOpenUrl(url: url)
    }
    
    return false
  }
  
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.portrait
  }
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    
    /// 카카오 SDK 초기화
    KakaoSDK.initSDK(appKey: "ba30c405908be1afda46343b5b73b363")
    
    /// 파이어베이스 초기화
    FirebaseApp.configure()
    
    /// 앱 외관 설정
    AppAppearance.setupAppearance()
    
    return true
  }
  
}
