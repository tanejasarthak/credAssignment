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
    private var emiSelectedModel: EMISelectionRepaymentTableViewCell.Model?
    
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
            let emiSelectedModel = getEMISelectionModel()
            return emiSelectedModel
        case .bankSelection:
            return getBankSelectionModel()
        }
    }
    
    func getNumberOfRowsInTableView() -> Int {
        dataSource.count
    }
    
    private func getAmountSelectionModel() -> GeneralTableViewModelProtocol {
        if currentSelectedRow != .amountSelection {
            let collapsedTableViewCellModel = CollpasedTableViewCell.Model(firstHeading: "first", firstSubHeading: "seonc", secondHeading: "second", secondSubHeading: "third", viewTag: 1)
            return collapsedTableViewCellModel
        }
        return AmountSelectionCircularProgressBarModel(selectedAmount: 1000, interestRate: 10, minPossibleAmount: 500, maxPossibleAmount: 100000, isCurrentlyActiveView: currentSelectedRow == .amountSelection)
    }
    
    private func getEMISelectionModel() -> GeneralTableViewModelProtocol {
        if currentSelectedRow == .bankSelection {
            let collapsedTableViewCellModel = CollpasedTableViewCell.Model(firstHeading: "first", firstSubHeading: "seonc", secondHeading: nil, secondSubHeading: nil, viewTag: 1)
            return collapsedTableViewCellModel
        }
        
        let subModelsArr: [EMISelectionCollectionViewCell.Model] = [
            EMISelectionCollectionViewCell.Model(uid: UUID(), backgroundColor: UIColor(red: 71/255, green: 51/255, blue: 63/255, alpha: 1.0), isSelected: false, emiAmount: 10000, emiDuration: 4, isRecommended: false),
            EMISelectionCollectionViewCell.Model(uid: UUID(), backgroundColor: UIColor(red: 126/255, green: 115/255, blue: 146/255, alpha: 1.0), isSelected: true, emiAmount: 25000, emiDuration: 6, isRecommended: false),
            EMISelectionCollectionViewCell.Model(uid: UUID(), backgroundColor: UIColor(red: 85/255, green: 106/255, blue: 142/255, alpha: 1.0), isSelected: false, emiAmount: 50000, emiDuration: 8, isRecommended: true)
        ]
        
        return EMISelectionRepaymentTableViewCell.Model(emiSelectionCollectionViewCellsArr: subModelsArr, isCurrentlyActiveView: currentSelectedRow == .emiSelection)
    }
    
    private func getBankSelectionModel() -> GeneralTableViewModelProtocol {
        let tblViewModelsArr: [BankDetailsTableViewCell.Model] = [
            BankDetailsTableViewCell.Model(bankId: 1, bankLogoImage: UIImage(named: "hdfcLogo"), bankName: "HDFC", bankAccountNumber: 102010332323, isSelected: false),
            BankDetailsTableViewCell.Model(bankId: 2, bankLogoImage: UIImage(named: "iciciLogo"), bankName: "ICICI", bankAccountNumber: 21000232332, isSelected: true)
        ]
        
        return SendMoneyToBankTableViewCellTableViewCell.Model(tblViewModel: tblViewModelsArr, isCurrentlyActiveView: currentSelectedRow == .bankSelection)
    }
    
    @discardableResult
    func bottomCTATapped(on viewType: RowsType) -> Bool {
        if viewType == .amountSelection {
            currentSelectedRow = .emiSelection
        } else if viewType == .emiSelection {
            currentSelectedRow = .bankSelection
        } else {
            return false
        }
        return true
    }
    
    func getCurrentlySelectedView() -> RowsType {
        currentSelectedRow
    }
    
    func getCurrentlySelectedRowIndex() -> Int {
        dataSource.firstIndex(of: currentSelectedRow)!
    }
    
    func modifyDataSource() {
        if currentSelectedRow == .emiSelection {
            dataSource = [.amountSelection, currentSelectedRow]
        } else if currentSelectedRow == .bankSelection {
            dataSource = [.amountSelection, .bankSelection,currentSelectedRow]
        }
    }
    
    func expandView(at index: Int) {
        currentSelectedRow = dataSource[index]
    }
    
    func selectEMIPlan(for selectedUID: UUID) {
        var retEmiSelectionCollectionViewCellsArr = [EMISelectionCollectionViewCell.Model]()
        if let emiSelectedModel {
            for data in emiSelectedModel.emiSelectionCollectionViewCellsArr {
                var newData = data
                newData.isSelected = newData.uid == selectedUID
                retEmiSelectionCollectionViewCellsArr.append(newData)
            }
            let retArr = EMISelectionRepaymentTableViewCell.Model(emiSelectionCollectionViewCellsArr: retEmiSelectionCollectionViewCellsArr, isCurrentlyActiveView: emiSelectedModel.isCurrentlyActiveView)
            self.emiSelectedModel = retArr
        }
    }
    
    func getPrimaryCTAStringBasedOnViewType() -> String {
        if currentSelectedRow == .amountSelection {
            return "Proceed to EMI selection"
        } else if currentSelectedRow == .emiSelection {
            return "Select your bank account"
        } else {
            return "Tap for 1-click KYC"
        }
    }
}
