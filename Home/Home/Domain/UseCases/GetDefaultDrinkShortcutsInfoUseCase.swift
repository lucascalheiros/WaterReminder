//
//  GetDefaultDrinkShortcutsInfoUseCase.swift
//  Home
//
//  Created by Lucas Calheiros on 12/02/25.
//

import WaterManagementDomain
import Common

class GetDefaultDrinkShortcutsInfoUseCase {

    private let getVolumeFormatUseCase: GetVolumeFormatUseCase

    init(getVolumeFormatUseCase: GetVolumeFormatUseCase) {
        self.getVolumeFormatUseCase = getVolumeFormatUseCase
    }

    func execute() async throws -> DrinkShortcutsInfo {
        let volumeFormat = try await getVolumeFormatUseCase.execute().awaitFirst()
        return switch volumeFormat {

        case .metric:
            DrinkShortcutsInfo(
                smallest: Volume(100, .milliliters),
                small: Volume(180, .milliliters),
                medium: Volume(250, .milliliters),
                large: Volume(500, .milliliters)
            )
        case .imperial_uk:
            DrinkShortcutsInfo(
                smallest: Volume(4, .oz_uk),
                small: Volume(6, .oz_uk),
                medium: Volume(8, .oz_uk),
                large: Volume(16, .oz_uk)
            )
        case .imperial_us:
            DrinkShortcutsInfo(
                smallest: Volume(4, .oz_us),
                small: Volume(6, .oz_us),
                medium: Volume(8, .oz_us),
                large: Volume(16, .oz_us)
            )
        }
    }

}
