//
//  NetworkAPIService.swift
//  EXAMENMOVILES
//
//  Created by Miguel Angel Uribe Esquivel on 25/11/24.
//

import Foundation
import Alamofire

class NetworkAPIService {
    static let shared = NetworkAPIService()
    
    func getData(url: URL) async -> [CovidModel]? {
        // Configura los headers
        let headers: HTTPHeaders = [
            "X-Api-Key": "wLVPN1zV08lJYF7uXqgyPw==zVwp6TlVcAO1NLUf"
        ]
        let taskRequest = AF.request(url, method: .get, headers: headers).validate()
        let response = await taskRequest.serializingData().response
        
        // Extrae el resultado
        switch response.result {
        case .success(let data):
            do{
                return try JSONDecoder().decode([CovidModel].self, from: data)
            }catch{
                print(error)
                return nil
            }
        case .failure(let error):
            print("Error al obtener los datos: \(error)")
            return nil
        }
        
    }
}
