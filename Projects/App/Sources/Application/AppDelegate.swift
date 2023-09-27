
import UIKit

@main // 앱의 진입점을 지정함. 앱을 실행할 때 아래 클래스가 자동으로 진입점으로 설정됨.
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    // 앱이 처음 시작될 때 호출되는 메서드임. 초기화 설정을 수행하고, 앱의 화면 플로우를 설정하며, 창을 생성하고 보이도록 함.
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        AppAppearance.setupAppearance() // 앱의 외관 설정을 위한 메서드를 호출함. 앱의 테마와 스타일을 설정하는 등의 작업을 수행함.
    
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
