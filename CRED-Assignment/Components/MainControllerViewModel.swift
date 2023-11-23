//
//  MainControllerViewModel.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 23/11/23.
//

import Foundation
import UIKit

class MainControllerViewModel {
    // MARK: - Enums
    enum RowsType {
        case amountSelection, emiSelection, bankSelection
    }
    
    // MARK: - Properties
    private var dataSource: [RowsType]
    private var currentSelectedRow: RowsType = .amountSelection
    
    // MARK: - Initialiser
    init(dataSource: [RowsType]) {
        self.dataSource = dataSource
    }
    
    // MARK: - TableViewHelper
    
    func getDataForRow(at index: Int) -> GeneralTableViewModelProtocol? {
        switch dataSource[index] {
        case .amountSelection:
            return getAmountSelectionModel()
        case .emiSelection:
            return getEMISelectionModel()
        case .bankSelection:
            return getBankSelectionModel()
        }
    }
    
    func getNumberOfRowsInTableView() -> Int {
        dataSource.count
    }
    
    private func getAmountSelectionModel() -> AmountSelectionCircularProgressBarModel {
        AmountSelectionCircularProgressBarModel(selectedAmount: 1000, interestRate: 10, minPossibleAmount: 500, maxPossibleAmount: 100000, isCurrentlyActiveView: currentSelectedRow == .amountSelection)
    }
    
    private func getEMISelectionModel() -> EMISelectionRepaymentTableViewCell.Model {
        let subModelsArr: [EMISelectionCollectionViewCell.Model] = [
            EMISelectionCollectionViewCell.Model(backgroundColor: UIColor.blue, isSelected: false, emiAmount: 10000, emiDuration: 4, isRecommended: false),
            EMISelectionCollectionViewCell.Model(backgroundColor: UIColor.green, isSelected: true, emiAmount: 25000, emiDuration: 6, isRecommended: false),
            EMISelectionCollectionViewCell.Model(backgroundColor: UIColor.red, isSelected: false, emiAmount: 50000, emiDuration: 8, isRecommended: true)
        ]
        
        return EMISelectionRepaymentTableViewCell.Model(emiSelectionCollectionViewCellsArr: subModelsArr, isCurrentlyActiveView: currentSelectedRow == .emiSelection)
    }
    
    private func getBankSelectionModel() -> SendMoneyToBankTableViewCellTableViewCell.Model {
        let tblViewModelsArr: [BankDetailsTableViewCell.Model] = [
            BankDetailsTableViewCell.Model(bankId: 1, bankLogoImage: UIImage(systemName: "chevron.right"), bankName: "HDFC", bankAccountNumber: 102010, isSelected: false),
            BankDetailsTableViewCell.Model(bankId: 2, bankLogoImage: UIImage(systemName: "chevron.left"), bankName: "ICICI", bankAccountNumber: 21000, isSelected: true)
        ]
        
        return SendMoneyToBankTableViewCellTableViewCell.Model(tblViewModel: tblViewModelsArr, isCurrentlyActiveView: currentSelectedRow == .bankSelection)
    }
    
    func bottomCTATapped(on viewType: RowsType) {
        if viewType == .amountSelection {
            currentSelectedRow = .emiSelection
        } else if viewType == .emiSelection {
            currentSelectedRow = .bankSelection
        } else if viewType == .bankSelection {
            currentSelectedRow = .amountSelection
        }
    }
    
    func getCurrentlySelectedView() -> RowsType {
        currentSelectedRow
    }
}
