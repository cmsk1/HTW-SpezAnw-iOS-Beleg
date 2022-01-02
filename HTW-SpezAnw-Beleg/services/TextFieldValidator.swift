//
//  RomanTextFieldValidator.swift
//  HTW-SpezAnw-Beleg
//
//  Created by Constantin Schulte-Kersmecke on 30.11.21.
//

import Foundation

func textFieldValidatorRoman(_ string: String) -> Bool {
    let romanPredicate = NSPredicate(format:"SELF MATCHES %@", RomanService.pattern)
    return romanPredicate.evaluate(with: string)
}
