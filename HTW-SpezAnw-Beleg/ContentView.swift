//
//  ContentView.swift
//  HTW-SpezAnw-Beleg
//
//  Created by Constantin Schulte-Kersmecke on 26.10.21.
//

import SwiftUI


struct ContentView: View {
    @State private var inputString: String = ""
    @State private var showError: Bool = false
    @State private var showResult: Bool = false
    @State private var result: String = ""
    @State private var calculate: [String] = []
    @State private var log: String = ""
    @State private var inputState: InputState = InputState.none

    var body: some View {
        GeometryReader { metrics in
        VStack{
            Text("Römischer").font(.headline)
            Text("Taschenrechner").font(.headline)
            ScrollView {
                HStack {
                Text(log).multilineTextAlignment(.leading)
                Spacer()
                }.frame(maxHeight: .infinity, alignment: .topLeading).padding(.horizontal)
            }.frame(width: metrics.size.width * 0.9).background(Color(hue: 1.0, saturation: 0.0, brightness: 0.900)).cornerRadius(8).frame(height: metrics.size.height * 0.25, alignment: .top)
            
            if showResult {
                HStack{
                    Text("Ergebnis: ").font(.caption)
                    Text(result).font(.headline)
                }
            }
            
            TextField("Eingabe", text: $inputString).padding().disabled(true)
                .padding(.horizontal).textFieldStyle(.roundedBorder).onChange(of: inputString) {
                newValue in
                                           
                                         
                inputString = inputString.uppercased().trimmingCharacters(in: CharacterSet(charactersIn: "ICXMLVD").inverted)

                }
            if showError {
                Text("Die Eingabe ist keine gültige römische Zahl").font(.footnote)
                    .foregroundColor(Color.red).frame(width: UIScreen.main.bounds.width)
            }
                
            // Button
            HStack {
                Button(action: {handleButtonPress(modifier: "+")}) {Text("+")}.customButton().disabled(inputState == InputState.calculated || inputString.isEmpty)
                Button(action: {handleButtonPress(modifier: "-")}) {Text("-")}.customButton().disabled(inputState == InputState.calculated || inputString.isEmpty)
                Button(action: {handleButtonPress(modifier: "*")}) {Text("*")}.customButton().disabled(inputState == InputState.calculated || inputString.isEmpty)
                Button(action: {calcAll()}) {Text("=")}.customButton().disabled(inputState == InputState.calculated || inputString.isEmpty)
                Button(action: {resetAll()}) {Text("C")}.customButton()
            }.padding()
            
            HStack {
                Button(action: {inputRomanChar(char: "I")}) {Text("I")}.customButton().disabled(disable(str: "I"))
                Button(action: {inputRomanChar(char: "V")}) {Text("V")}.customButton().disabled(disable(str: "V"))
                Button(action: {inputRomanChar(char: "X")}) {Text("X")}.customButton().disabled(disable(str: "X"))
                Button(action: {inputRomanChar(char: "L")}) {Text("L")}.customButton().disabled(disable(str: "L"))
            }
            
            HStack {
                Button(action: {inputRomanChar(char: "C")}) {Text("C")}.customButton().disabled(disable(str: "C"))
                Button(action: {inputRomanChar(char: "D")}) {Text("D")}.customButton().disabled(disable(str: "D"))
                Button(action: {inputRomanChar(char: "M")}) {Text("M")}.customButton().disabled(disable(str: "M"))
                Button(action: {popChar()}) {Text("<")}.customButton().disabled(inputState == InputState.calculated || inputString.isEmpty)
            }
        
        }.frame( height: UIScreen.main.bounds.height-90, alignment: .top)
        
    }
    }

    func handleButtonPress(modifier: String) -> Void{
        inputState = RomanService.validdateInput(roman: inputString)
        if (inputState == InputState.valid && !inputString.isEmpty) {
            calculate.append(inputString)
            calculate.append(modifier)
            inputString = ""
            log = createLog(strings: calculate)
            showError = false
        } else {
            showError = true
        }
    }
    
    func resetAll() -> Void {
        inputString = ""
        showError = false
        showResult = false
        result = ""
        calculate = []
        log = ""
        inputState = InputState.none
    }
    
    func popChar() -> Void {
        let _ = inputString.popLast()
    }
    
    func disable(str: String) -> Bool{
        if (inputState == InputState.calculated) {
            return true
        }
        if RomanService.checkRomanRegEx(roman: "\(inputString)\(str)") {
            return false
        }
        return true
    }

    func calcAll() -> Void {
        inputState = RomanService.validdateInput(roman: inputString)
        if (inputState == InputState.valid && !inputString.isEmpty) {
            calculate.append(inputString)
            inputString = ""
            log = createLog(strings: calculate)
            showError = false
        } else {
            showError = true
        }
        
        if !showError {
            let intResult = try! RomanService.calculateString(input: calculate)
            let roman = RomanService.intToRoman(number: intResult)
            result = "\(roman) (\(intResult))"
            inputState = InputState.calculated
            showResult = true
        }
    }
    
    func inputRomanChar(char: String) -> Void {
        inputState = RomanService.validdateInput(roman: inputString)
        if textFieldValidatorRoman("\(inputString)\(char.uppercased())") {
            inputString.append(char.uppercased())
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



func createLog(strings: [String]) -> String{
    var tmp: String = ""
    strings.forEach {
        if ($0.contains("+") || $0.contains("-") || $0.contains("*")) {
            tmp.append("\($0) \n")
        } else {
            try! tmp.append("\($0.uppercased()) (\(RomanService.romanToInt($0.uppercased())))\n")
        }
    }
    return tmp;
}


