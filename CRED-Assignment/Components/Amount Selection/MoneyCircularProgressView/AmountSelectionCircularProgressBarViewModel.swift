//
//  AmountSelectionCircularProgressBarViewModel.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 22/11/23.
//

import Foundation

protocol AmountSelectionCircularProgressBarViewModelProtocol: AnyObject {
    func updateLabelsForAmountSelected()
}

class AmountSelectionCircularProgressBarViewModel {
    // MARK: - Properties
    private var dataModel: AmountSelectionCircularProgressBarModel
    weak var delegate: AmountSelectionCircularProgressBarViewModelProtocol?
    
    // MARK: - Intialiser
    init(dataModel: AmountSelectionCircularProgressBarModel) {
        self.dataModel = dataModel
    }
    
    func updateAmountBasedOnSliderSelection(amount: Int) {
        dataModel.selectedAmount = amount
        delegate?.updateLabelsForAmountSelected()
    }
    
    func getSelectedAmountToPopulateUI() -> String {
        UtilityFunctions.toCommaSeperatedAmount(value: dataModel.selectedAmount, addRupeeSymbol: true)
    }
    
    func getMinAndMaxPossibleAmountValue() -> (min: Int, max: Int) {
        (dataModel.minPossibleAmount, dataModel.maxPossibleAmount)
    }
    
    func isViewCurrentlySelected() -> Bool {
        dataModel.isCurrentlyActiveView
    }
}
