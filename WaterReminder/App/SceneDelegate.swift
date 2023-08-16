//
//  SceneDelegate.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit
import Swinject
import RxFlow
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

	lazy var container: Container = appContainer()
	lazy var coordinator = FlowCoordinator()
	let disposeBag = DisposeBag()

	var appFlow: FirstAccessFlow!

	func assembleModuleContainers(container: Container) {
		WaterReminderNotificationDomainAssembly().assemble(container: container)
		FirstAccessInformationAssembly().assemble(container: container)
		UserInformationDomainAssembly().assemble(container: container)
		WaterManagementDomainAssembly().assemble(container: container)
		HomeAssembly().assemble(container: container)
		SettingsAssembly().assemble(container: container)
		HistoryAssembly().assemble(container: container)
		LocalePreferencesDomainAssembly().assemble(container: container)
	}

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		// Use this method to optionally configure and attach the
		// UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically
		// be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session
		// are new (see `application:configurationForConnectingSceneSession` instead).
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)

		assembleModuleContainers(container: container)

		self.coordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
			print("will navigate to flow=\(flow) and step=\(step)")
		}).disposed(by: self.disposeBag)

		self.coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
			print("did navigate to flow=\(flow) and step=\(step)")
		}).disposed(by: self.disposeBag)

		appFlow = FirstAccessFlow(container: container)

		// TODO add splash and refactor to include this decision there.
		let getDailyWaterConsumptionUseCase = container.resolve(GetDailyWaterConsumptionUseCaseProtocol.self)
		getDailyWaterConsumptionUseCase?.lastDailyWaterConsumption().safeAsSingle().subscribe(onSuccess: {
			let step = $0 == nil ? FirstAccessFlowSteps.firstAccessUserInformationIsRequired : FirstAccessFlowSteps.firstAccessUserInformationAlreadyProvided
			self.coordinator.coordinate(flow: self.appFlow, with: OneStepper(withSingleStep: step))
		}).disposed(by: disposeBag)

		Flows.use(appFlow, when: .created) { root in
			window.rootViewController = root
			window.makeKeyAndVisible()
		}

		self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be
        // re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily
        // discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started)
        // when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources,
        // and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		completionHandler()
	}

}
