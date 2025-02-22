//
//  DeleteWaterSourceUseCase.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 21/02/25.
//

public class DeleteWaterSourceUseCase {

    private let waterSourceRepository: WaterSourceRepository

    init(waterSourceRepository: WaterSourceRepository) {
        self.waterSourceRepository = waterSourceRepository
    }

    public func execute(_ waterSource: WaterSource) async throws {
        try await waterSourceRepository.deleteWaterSource(waterSource: waterSource)
    }

}
