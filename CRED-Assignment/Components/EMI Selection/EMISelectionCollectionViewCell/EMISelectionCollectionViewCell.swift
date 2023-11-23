//
//  EMISelectionCollectionViewCell.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 22/11/23.
//

import UIKit

class EMISelectionCollectionViewCell: UICollectionViewCell {

    // MARK: - Model
    struct Model {
        var backgroundColor: UIColor
        var isSelected: Bool
        var emiAmount: Int64
        var emiDuration: Int
        var isRecommended: Bool
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var tickImageView: UIImageView!
    @IBOutlet weak var lblEMIAmount: UILabel!
    @IBOutlet weak var lblEMIDuration: UILabel!
    @IBOutlet weak var recommendedView: UIView! {
        didSet {
            recommendedView.makeRoundedView()
        }
    }
    
    // MARK: - IBAction
    @IBAction func seeCalculationsTapped() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureView(with model: EMISelectionCollectionViewCell.Model) {
        parentView.backgroundColor = model.backgroundColor
        lblEMIAmount.text = UtilityFunctions.toCommaSeperatedAmount(value: Int(model.emiAmount), addRupeeSymbol: true) + " / mo"
        lblEMIDuration.text = "for " + String(model.emiDuration) + " months"
        recommendedView.isHidden = model.isRecommended
    }
}
