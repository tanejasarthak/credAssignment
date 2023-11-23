//
//  AmountSelectionCircularProgressBarTableViewCell.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 23/11/23.
//

import UIKit
import HGCircularSlider

class AmountSelectionCircularProgressBarTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var circularSlider: CircularSlider!
    @IBOutlet weak var lblAmountSelected: UILabel!
    @IBOutlet weak var lblInterestRateMonthly: UILabel!
    
    // MARK: - Properties
   private var viewModel: AmountSelectionCircularProgressBarViewModel?
    
    // MARK: - Initialiser
    
    func configureView(vm: AmountSelectionCircularProgressBarViewModel?) {
        self.viewModel = vm
        viewModel?.delegate = self
        setUpCircularView()
    }
    
    func setUpCircularView() {
        if let minMaxAmountValues = viewModel?.getMinAndMaxPossibleAmountValue() {
            circularSlider.minimumValue = CGFloat(minMaxAmountValues.min)
            circularSlider.maximumValue = CGFloat(minMaxAmountValues.max)
        }
        circularSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc func sliderValueChanged() {
        viewModel?.updateAmountBasedOnSliderSelection(amount: Int(circularSlider.endPointValue))
    }
}

// MARK: - ViewModel Delegate
extension AmountSelectionCircularProgressBarTableViewCell: AmountSelectionCircularProgressBarViewModelProtocol {
    func updateLabelsForAmountSelected() {
        lblAmountSelected.text = viewModel?.getSelectedAmountToPopulateUI()
    }
}
