//
//  MainControllerViewModel.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 23/11/23.
//

import Foundation
import UIKit

protocol CollapsibleTableViewCellsProtocol where Self: UITableViewCell {
    
}

class MainControllerViewModel {
    // MARK: - Enums
    enum RowsType {
        case amountSelection, emiSelection, bankSelection
    }
    
    // MARK: - AllTableViewModels
    struct AllTableViewCellModels {
        var amountSelectedModel: GeneralTableViewModelProtocol?
        var emiSelectedModel: GeneralTableViewModelProtocol?
        var bankSelectionModel: GeneralTableViewModelProtocol?
    }
    
    // MARK: - Properties
    private var dataSource: [RowsType]
    private var allTableViewCellModels: AllTableViewCellModels?
    private var currentSelectedRow: RowsType = .amountSelection
    
    // MARK: - Initialiser
    init(dataSource: [RowsType]) {
        self.dataSource = dataSource
        
        allTableViewCellModels = AllTableViewCellModels(amountSelectedModel: getAmountSelectionModel(), emiSelectedModel: getEMISelectionModel(), bankSelectionModel: getBankSelectionModel())
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
    
    private func getAmountSelectionModel() -> GeneralTableViewModelProtocol {
        if currentSelectedRow != .amountSelection {
            if let amountSelectedModel = allTableViewCellModels?.amountSelectedModel as? AmountSelectionCircularProgressBarModel {
                let collapsedTableViewCellModel = CollpasedTableViewCell.Model(firstHeading: "credit amount", firstSubHeading: UtilityFunctions.toCommaSeperatedAmount(value: (amountSelectedModel.selectedAmount), addRupeeSymbol: true) + " . mo", secondHeading: nil, secondSubHeading: nil, viewTag: 1)
                return collapsedTableViewCellModel
            }
        }
        
        if let amountAlreadySelectedModel = allTableViewCellModels?.amountSelectedModel as? AmountSelectionCircularProgressBarModel {
            return AmountSelectionCircularProgressBarModel(selectedAmount: amountAlreadySelectedModel.selectedAmount, interestRate: 10, minPossibleAmount: 500, maxPossibleAmount: 100000, isCurrentlyActiveView: currentSelectedRow == .amountSelection)
        }
        return AmountSelectionCircularProgressBarModel(selectedAmount: 1000, interestRate: 10, minPossibleAmount: 500, maxPossibleAmount: 100000, isCurrentlyActiveView: currentSelectedRow == .amountSelection)
    }
    
    private func getEMISelectionModel() -> GeneralTableViewModelProtocol {
        if currentSelectedRow == .bankSelection {
            if let emiSelectedModel = allTableViewCellModels?.emiSelectedModel as? EMISelectionRepaymentTableViewCell.Model {
                if let selectedEMIData = emiSelectedModel.emiSelectionCollectionViewCellsArr.filter({ $0.isSelected }).first {
                    let collapsedTableViewCellModel = CollpasedTableViewCell.Model(firstHeading: "EMI", firstSubHeading: String(selectedEMIData.emiAmount), secondHeading: "Duration", secondSubHeading: String(selectedEMIData.emiDuration), viewTag: 1)
                    return collapsedTableViewCellModel
                }
            }
        }
        
        if let subModelsArr = allTableViewCellModels?.emiSelectedModel as? EMISelectionRepaymentTableViewCell.Model {
            return EMISelectionRepaymentTableViewCell.Model(emiSelectionCollectionViewCellsArr: subModelsArr.emiSelectionCollectionViewCellsArr, isCurrentlyActiveView: currentSelectedRow == .emiSelection)
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
        if let emiSelectedModel = allTableViewCellModels?.emiSelectedModel as? EMISelectionRepaymentTableViewCell.Model {
            for data in emiSelectedModel.emiSelectionCollectionViewCellsArr {
                var newData = data
                newData.isSelected = newData.uid == selectedUID
                retEmiSelectionCollectionViewCellsArr.append(newData)
            }
            let retArr = EMISelectionRepaymentTableViewCell.Model(emiSelectionCollectionViewCellsArr: retEmiSelectionCollectionViewCellsArr, isCurrentlyActiveView: emiSelectedModel.isCurrentlyActiveView)
            self.allTableViewCellModels?.emiSelectedModel = retArr
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
    
    
    // MARK: - Get TableViewCells
    func getTableViewCell(_ tableView: UITableView, indexPath: IndexPath, vc: ViewController) -> CollapsibleTableViewCellsProtocol? {
        if let tableViewRowData = getDataForRow(at: indexPath.row) {
            if let amountSelectionData = tableViewRowData as? AmountSelectionCircularProgressBarModel {
                let amountSelectionTblViewCell: AmountSelectionCircularProgressBarTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AmountSelectionCircularProgressBarTableViewCell") as! AmountSelectionCircularProgressBarTableViewCell
                amountSelectionTblViewCell.delegate = self
                amountSelectionTblViewCell.configureView(vm: AmountSelectionCircularProgressBarViewModel(dataModel: amountSelectionData))
                return amountSelectionTblViewCell
            } else if let emiSelectionData = tableViewRowData as? EMISelectionRepaymentTableViewCell.Model {
                let emiSelectionTblViewCell: EMISelectionRepaymentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EMISelectionRepaymentTableViewCell") as! EMISelectionRepaymentTableViewCell
                emiSelectionTblViewCell.configureView(with: emiSelectionData)
                emiSelectionTblViewCell.delegate = self
                return emiSelectionTblViewCell
            } else if let bankSelectionData = tableViewRowData as? SendMoneyToBankTableViewCellTableViewCell.Model {
                let bankSelectionTblViewCell: SendMoneyToBankTableViewCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SendMoneyToBankTableViewCellTableViewCell") as! SendMoneyToBankTableViewCellTableViewCell
                bankSelectionTblViewCell.configureView(with: bankSelectionData)
                return bankSelectionTblViewCell
            } else if let collapsedTableViewCellData = tableViewRowData as? CollpasedTableViewCell.Model {
                let collapsedTableViewCell: CollpasedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CollpasedTableViewCell") as! CollpasedTableViewCell
                collapsedTableViewCell.tag = indexPath.row
                collapsedTableViewCell.delegate = vc
                collapsedTableViewCell.configureView(with: collapsedTableViewCellData)
                return collapsedTableViewCell
            }
        }
        return nil
    }
}

extension MainControllerViewModel: EMISelectionRepaymentTableViewCellProtocol {
    func viewSelected(at uid: UUID) {
        selectEMIPlan(for: uid)
    }
}

extension MainControllerViewModel: AmountSelectionCircularProgressBarTableViewCellProtocol {
    func updateAmountBasedOnSliderSelection(amount: Int) {
        if var amountSelectedModel = allTableViewCellModels?.amountSelectedModel as? AmountSelectionCircularProgressBarModel {
            amountSelectedModel.selectedAmount = amount
            allTableViewCellModels?.amountSelectedModel = amountSelectedModel
        }
    }
}
