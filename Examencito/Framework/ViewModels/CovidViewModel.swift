//
//  CovidViewModel.swift
//  EXAMENMOVILES
//
//  Created by Miguel Angel Uribe Esquivel on 25/11/24.
//
import Foundation

class CovidViewModel: ObservableObject {
    @Published var CovidList = [Info]()
    @Published var error: Bool = false
    @Published var jsonString: String = "" // Variable para almacenar el JSON legible
    
    @MainActor
    func getCovidData() async {
        let CovidRepository = CovidRepository()
        let result = await CovidRepository.getData()
        
        // Manejo del JSON legible
        if let result = result {
            if let jsonData = try? JSONEncoder().encode(result), // Codificar el modelo a JSON
               let prettyJsonData = try? JSONSerialization.jsonObject(with: jsonData),
               let formattedData = try? JSONSerialization.data(withJSONObject: prettyJsonData, options: .prettyPrinted),
               let prettyJsonString = String(data: formattedData, encoding: .utf8) {
                // Guardar el JSON formateado en `jsonString`
                self.jsonString = prettyJsonString
            }
        } else {
            self.jsonString = "Error al obtener los datos del servidor."
        }
        
        print(jsonString) // Opcional: Para verificar el JSON en consola
        
        // Manejo del modelo y errores
        if result == nil {
            error = true
            return
        } else {
            for i in 0..<result!.count {
                let temp = CovidModel(country: result![i].country, region: result![i].region, cases: result![i].cases)
                let tempInfo = Info(id: i, covidModel: temp)
                CovidList.append(tempInfo)
            }
        }
    }
}
