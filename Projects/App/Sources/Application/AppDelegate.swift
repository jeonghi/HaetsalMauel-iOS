
import UIKit

// MARK: - AppDelegate

final class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    
    AppAppearance.setupAppearance()
    return true
  }
}
