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
    var isCurrentlyActiveView: Bool
    
    init(selectedAmount: Int, interestRate: Int, minPossibleAmount: Int = 0, maxPossibleAmount: Int = 1000000, isCurrentlyActiveView: Bool) {
        self.selectedAmount = selectedAmount
        self.interestRate = interestRate
        self.minPossibleAmount = minPossibleAmount
        self.maxPossibleAmount = maxPossibleAmount
        self.isCurrentlyActiveView = isCurrentlyActiveView
    }
}
