//
//  UtilityFunctions.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 22/11/23.
//

import Foundation

struct UtilityFunctions {
    static func toCommaSeperatedAmount(value: Int, addRupeeSymbol: Bool = false, fractionDigitsCount: Int? = nil) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "en_IN")
        if let _fractionDigitsCount = fractionDigitsCount  {
            numberFormatter.minimumFractionDigits = _fractionDigitsCount
            numberFormatter.maximumFractionDigits = _fractionDigitsCount
        }
        let sign = (value < 0) ? "-" : ""
        if addRupeeSymbol {
            return "\(sign)₹\(numberFormatter.string(from: NSNumber(value:abs(value))) ?? String(abs(value)))"
        }else{
            return "\(sign)\(numberFormatter.string(from: NSNumber(value:abs(value))) ?? String(abs(value)))"
        }
    }
}
