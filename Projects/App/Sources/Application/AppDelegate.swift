import UIKit
import EumKit
import EumUI

@main // 앱의 진입점을 지정함. 앱을 실행할 때 아래 클래스가 자동으로 진입점으로 설정됨.
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appDIContainer = AppDIContainer() // 앱의 DI 컨테이너 객체를 생성함. 이 컨테이너를 통해 앱의 다양한 모듈과 의존성을 관리할 수 있음.
    var appFlowCoordinator: AppFlowCoordinator? // 앱의 전체 플로우를 관리하는 AppFlowCoordinator 객체를 생성함. 화면 간의 전환과 네비게이션 흐름을 관리함.
    var window: UIWindow? // 앱의 UIWindow 객체를 생성하여 화면에 보이는 창을 관리함.
    
    // 앱이 처음 시작될 때 호출되는 메서드임. 초기화 설정을 수행하고, 앱의 화면 플로우를 설정하며, 창을 생성하고 보이도록 함.
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        AppAppearance.setupAppearance() // 앱의 외관 설정을 위한 메서드를 호출함. 앱의 테마와 스타일을 설정하는 등의 작업을 수행함.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        window?.rootViewController = navigationController
        appFlowCoordinator = AppFlowCoordinator(
            navigationController: navigationController,
            appDIContainer: appDIContainer
        ) // 앱의 전체 화면 흐름과 내비게이션을 관리함
        appFlowCoordinator?.start() // 앱의 화면 흐름을 시작함.
        window?.makeKeyAndVisible() // UIWindow 객체를 화면에 표시하도록 설정함.
    
        return true
    }
}
