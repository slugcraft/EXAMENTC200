//
//  CovidModel.swift
//  EXAMENMOVILES
//
//  Created by Miguel Angel Uribe Esquivel on 25/11/24.
//

import Foundation

struct CovidModel: Codable{
    var country: String
    var region: String
    var cases: [String: Cases]
}

struct Cases: Codable{
    var total: Int
    var new: Int
}

struct Info: Identifiable{
    var id: Int
    var covidModel: CovidModel
}
