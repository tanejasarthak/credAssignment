//
//  AmountSelectionCircularProgressBarModel.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 22/11/23.
//

import Foundation

struct AmountSelectionCircularProgressBarModel: GeneralTableViewModelProtocol {
    var selectedAmount: Int
    var interestRate: Int
    var minPossibleAmount: Int
    var maxPossibleAmount: Int
    
    init(selectedAmount: Int, interestRate: Int, minPossibleAmount: Int = 0, maxPossibleAmount: Int = 1000000) {
        self.selectedAmount = selectedAmount
        self.interestRate = interestRate
        self.minPossibleAmount = minPossibleAmount
        self.maxPossibleAmount = maxPossibleAmount
    }
}
