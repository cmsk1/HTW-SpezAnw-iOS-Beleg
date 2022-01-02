//
//  RomanConverter.swift
//  HTW-SpezAnw-Beleg
//
//  Created by Constantin Schulte-Kersmecke on 30.11.21.
//

import Foundation

struct RomanService {
    
    static public let pattern = #"(?<=^)M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})(?=$)"#
    static private let dict: [(integer: Int, glyph: String)] = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
    
    
    static func romanToInt(_ roman: String) throws -> Int {
        var value = 0
        var pos = roman.startIndex
        while pos != roman.endIndex {
            let subString = roman[pos...]
            guard let (quantity, glyph) = dict.first(where: { subString.hasPrefix($0.glyph) }) else {
                throw RomanNumericError.badInput(original: roman)
            }
            value += quantity
            pos = roman.index(pos, offsetBy: glyph.count)
        }
        return value
    }
    
    
    static func checkRomanRegEx(roman: String) -> Bool {
        let result = roman.range(
            of: pattern,
            options: .regularExpression
        )
        return (result != nil)
    }

    
    static func intToRoman(number: Int) -> String {
        var numeralString = ""
        var integerValue = number
        for i in dict {
            while (integerValue >= i.0) {
                    integerValue -= i.0
                    numeralString += i.1
                }
        }
        return numeralString
    }

    
    static func calculateString(input: [String]) throws -> Int {
        
        var calculateAsString: String = ""
            
        for (index, item) in input.enumerated() {
            if index % 2 == 0 {
                let integer: Int = try! romanToInt(item)
                calculateAsString.append("\(integer)")
            } else {
                calculateAsString.append(item)
            }
        }
            
        let expr = NSExpression(format: calculateAsString)
        if let exresult = expr.expressionValue(with: nil, context: nil) as? NSNumber {
            return exresult.intValue
        } else {
            throw CalculationError.badInput(original: calculateAsString)
        }
    }
    
    static func validdateInput(roman: String) -> InputState{
        if (checkRomanRegEx(roman: roman.uppercased())){
            return InputState.valid
        } else {
            return InputState.invalid
        }
    }

    
}
