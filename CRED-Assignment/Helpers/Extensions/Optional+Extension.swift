//
//  Optional+Extension.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 22/11/23.
//

import Foundation

public extension Optional {
   func unwrappedValue(or defaultValue: Wrapped) -> Wrapped {
        if self != nil{
            switch self {
            case .none:
                return defaultValue
            case .some(let wrapped):
                return wrapped
            }
        }
       
        return defaultValue
    }
}
