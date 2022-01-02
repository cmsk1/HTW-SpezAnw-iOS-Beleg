//
//  CalculationError.swift.swift
//  HTW-SpezAnw-Beleg
//
//  Created by Constantin Schulte-Kersmecke on 30.11.21.
//

import Foundation

enum CalculationError: Error {
    case badInput(original: String)
}
