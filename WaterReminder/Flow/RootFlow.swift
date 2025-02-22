//
//  RootFlow.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import UIKit
import RxFlow
import RxSwift
import Swinject
import Core
import FirstAccess
import WaterManagementDomain

public class RootFlow: Flow {

    public var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()

    private let container: Container

    let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase!

    init(container: Container) {
        self.container = container
        getDailyWaterConsumptionUseCase = container.resolve(GetDailyWaterConsumptionUseCase.self)
    }

    public func navigate(to step: Step) -> FlowContributors {

        guard let step = step as? FirstAccessFlowSteps else { return .none }

        switch step {

        case .firstAccessUserInformationIsRequired:
            return navigateToFirstAccessTutorial()

        case .firstAccessUserInformationAlreadyProvided:
            return navigateToHome()

        case .entryPoint:
            return .none
        }
    }

    public func adapt(step: any Step) -> Single<any Step> {
        guard let step = step as? FirstAccessFlowSteps else { return .just(step) }

        switch step {
        case .entryPoint:
            return Single.create {
                let lastDailyWaterConsumption = try? await self.getDailyWaterConsumptionUseCase?.lastDailyWaterConsumption().awaitFirst()
                return lastDailyWaterConsumption == nil ? FirstAccessFlowSteps.firstAccessUserInformationIsRequired : FirstAccessFlowSteps.firstAccessUserInformationAlreadyProvided
            }
        default:
            return Single.just(step)
        }
    }

    private func navigateToFirstAccessTutorial() -> FlowContributors {
        let viewController = container.resolve(FirstAccessPageVC.self)!
        self.rootViewController.pushViewController(viewController, animated: false)

        return .one(flowContributor: .contribute(
            withNextPresentable: viewController,
            withNextStepper: container.resolve(FirstAccessInformationStepper.self)!
        ))
    }

    private func navigateToHome() -> FlowContributors {
        let mainAppFlow = MainAppFlow(container: self.container)

        Flows.use(mainAppFlow, when: .created) { [unowned self] rootVC in
            self.rootViewController.pushViewController(rootVC, animated: false)
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: mainAppFlow,
            withNextStepper: OneStepper(withSingleStep: MainAppFlowSteps.mainApp)
        ))
    }
}
