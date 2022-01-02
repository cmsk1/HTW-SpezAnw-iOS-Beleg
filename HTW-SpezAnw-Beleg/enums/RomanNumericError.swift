//
//  RomanNumericError.swift
//  HTW-SpezAnw-Beleg
//
//  Created by Constantin Schulte-Kersmecke on 30.11.21.
//

import Foundation

enum RomanNumericError: Error {
    case badInput(original: String)
}
