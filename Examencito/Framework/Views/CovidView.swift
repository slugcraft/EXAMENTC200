//
//  ContentView.swift
//  EXAMENMOVILES
//
//  Created by Miguel Angel Uribe Esquivel on 25/11/24.
//

import SwiftUI

struct CovidView: View {
    @StateObject var covidViewModel = CovidViewModel()
    @State private var selectedDate: String? // Fecha seleccionada
    
    var body: some View {
        VStack{
            Image(systemName: "globe.americas")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 70, height: 70)
            Text("Casos de Covid")
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        List(covidViewModel.CovidList) { CovidModel in
            Text("Pais: \(CovidModel.covidModel.country)")
            Text("Region: \(CovidModel.covidModel.region)")
            
            // Picker para seleccionar una fecha
            Picker("Selecciona una fecha", selection: $selectedDate) {
                ForEach(CovidModel.covidModel.cases.keys.sorted(), id: \.self) { date in
                    Text(date).tag(date as String?)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            // Mostrar datos de la fecha seleccionada
            if let date = selectedDate,
               let caseData = CovidModel.covidModel.cases[date] {
                VStack(alignment: .leading) {
                    Text("Datos del \(date):")
                        .font(.headline)
                    Text("Total: \(caseData.total)")
                    Text("Nuevos casos: \(caseData.new)")
                }
                .padding(.top, 10)
            } else {
                Text("Selecciona una fecha para ver los datos.")
                    .foregroundColor(.gray)
                    .padding(.top, 10)
            }
            
        }
        .onAppear {
            Task{
                await covidViewModel.getCovidData()
            }
        }
    }
}

#Preview {
    CovidView()
}
