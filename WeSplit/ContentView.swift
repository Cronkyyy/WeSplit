//
//  ContentView.swift
//  WeSplit
//
//  Created by Dylan Cronk on 2/12/21.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = ""
  @State private var numOfPeople = ""
  @State private var tipPercentage = 2
  let tipPercentages  = [10,15,20,25,0]
  
  var grandTotal: Double {
    let tipSelection = Double(tipPercentages[tipPercentage])
    let orderAmount = Double(checkAmount) ?? 0
    let tipValue = orderAmount * tipSelection / 100
    
    return  orderAmount + tipValue
  }
  
  var totalPerPerson: Double {
    let peopleCount = Double(Int(numOfPeople) ?? 1)
    
    return grandTotal / peopleCount
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Check amount", text: $checkAmount)
            .keyboardType(.decimalPad)
          
          // Needs additional validation for number input.
          TextField("Number of people", text: $numOfPeople)
            .keyboardType(.decimalPad)
        }
        
        Section(header: Text("How much of a tip would you like to leave?")) {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0..<tipPercentages.count) {
              Text("\(tipPercentages[$0])%")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        
        Section(header: Text("Amount per person:")) {
          Text("$\(totalPerPerson, specifier: "%.2f")")
        }
        
        Section(header: Text("Total amount:")) {
          Text("$\(grandTotal, specifier: "%.2f")")
            .foregroundColor(tipPercentage == 4 ? .red : .black)
        }
      }
      .navigationBarTitle("WeSplit")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
