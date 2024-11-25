//
//  RequirmentCovid.swift
//  Examencito
//
//  Created by Miguel Angel Uribe Esquivel on 25/11/24.
//

import Foundation

import Foundation

protocol CovidRequirementProtocol {
    func getData() async -> [CovidModel]?
}

class CovidRequirement: CovidRequirementProtocol {
    let dataRepository: CovidRepository

    init(dataRepository: CovidRepository = CovidRepository.shared) {
        self.dataRepository = dataRepository
    }
    
    func getData() async -> [CovidModel]? {
        return await dataRepository.getData()
    }
}
