//
//  CovidProtocol.swift
//  EXAMENMOVILES
//
//  Created by Miguel Angel Uribe Esquivel on 25/11/24.
//

import Foundation

protocol CovidProtocol {
    func getData() async -> [CovidModel]?
}
