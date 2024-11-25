//
//  CovidRepository.swift
//  EXAMENMOVILES
//
//  Created by Miguel Angel Uribe Esquivel on 25/11/24.
//

import Foundation

protocol CovidProtocol {
    func getData() async -> [CovidModel]?
}

class CovidRepository: CovidProtocol {
    static let shared = CovidRepository()
    
    let nservice: NetworkAPIService
    
    init (nservice: NetworkAPIService = NetworkAPIService.shared){
        self.nservice = nservice
    }
    
    func getData() async -> [CovidModel]? {
        return await nservice.getData(url: URL(string: "\(API.base)\(API.routes.mexico)")!)
    }
}

struct API{
    static let base = "https://api.api-ninjas.com/v1/covid19"
    
    struct routes {
        static let mexico = "?country=Mexico"
    }
}
