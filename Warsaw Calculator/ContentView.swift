//
//  ContentView.swift
//  Warsaw Calculator
//
//  Created by Richard Austin on 2/2/26.
//  Ref: https://www.juiceboxpodcast.com/warcal
//

import SwiftUI

struct ContentView: View {
    
    @State private var fatGrams: Double = 0.0
    @State private var proteinGrams: Double = 0.0
    @State private var ICR: Double = 10.0
    
    @State private var calculationInfo: String = ""
    
    func calculateResults() -> String {
        var resultString = ""
        var digestionTime: Int = 0
        let kcal = fatGrams * 9.0 + proteinGrams * 4.0
        
        resultString.append("Total kcal: \(kcal.formatted(.number.precision(.fractionLength(1)))) \n")
        
        let fpus = kcal / 100.0
        let carbEquiv = fpus * 10.0
        let insulinNeeded = carbEquiv / ICR
        
        resultString.append("FPUs: \(fpus.formatted(.number.precision(.fractionLength(2)))) \n")
        resultString.append("Carb equivalent: \(carbEquiv.formatted(.number.precision(.fractionLength(1)))) g \n\n")
        resultString.append("Recommended Insulin: \(insulinNeeded.formatted(.number.precision(.fractionLength(2)))) units \n")
        
        switch fpus {
        case -1..<2:
            digestionTime = 3
        case 2..<3:
            digestionTime = 4
        case 3..<4:
            digestionTime = 5
        default:
            digestionTime = 8
        }
        
        resultString.append("Recommended bolus duration: \(digestionTime) hrs")
        
        return resultString
    }
    
    var body: some View {
        VStack {
            Text("Warsaw Bolus Calculator")
                .font(.title)
            HStack {
                Text("Fat (g):")
                TextField("", value: $fatGrams, format: .number)
                    .keyboardType(.decimalPad)
                Spacer()
            }.padding(.leading)
                .textFieldStyle(.roundedBorder)
            HStack {
                Text("Protein (g):")
                TextField("", value: $proteinGrams, format: .number)
                    .keyboardType(.decimalPad)
                Spacer()
            }.padding(.leading)
                .textFieldStyle(.roundedBorder)
            HStack {
                Text("Insulin to Carb Ratio:")
                TextField("", value: $ICR, format: .number)
                    .keyboardType(.decimalPad)
                Spacer()
            }.padding(.leading)
                .textFieldStyle(.roundedBorder)
                
            Button("Calculate") {
                calculationInfo = calculateResults()
            }
            .padding()
            
            Text(calculationInfo)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
