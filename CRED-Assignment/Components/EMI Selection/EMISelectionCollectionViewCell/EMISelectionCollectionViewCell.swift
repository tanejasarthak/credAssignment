//
//  EMISelectionCollectionViewCell.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 22/11/23.
//

import UIKit

protocol EMISelectionCollectionViewCellProtocol: AnyObject {
    func tickMarkTapped(at uid: UUID)
}

class EMISelectionCollectionViewCell: UICollectionViewCell {

    // MARK: - Model
    struct Model {
        let uid: UUID
        let backgroundColor: UIColor
        var isSelected: Bool
        let emiAmount: Int64
        let emiDuration: Int
        let isRecommended: Bool
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var tickImageView: UIImageView! {
        didSet {
            tickImageView.makeRoundedView()
            tickImageView.layer.borderWidth = 1.0
            tickImageView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4).cgColor
           // tickImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tickMarkTapped)))
        }
    }
    @IBOutlet weak var lblEMIAmount: UILabel!
    @IBOutlet weak var lblEMIDuration: UILabel!
    @IBOutlet weak var recommendedView: UIView! {
        didSet {
            recommendedView.makeRoundedView()
        }
    }
    
    //  MARK: - Properties
    weak var delegate: EMISelectionCollectionViewCellProtocol?
    private var uid: UUID?
    
    // MARK: - IBAction
    @IBAction func seeCalculationsTapped() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tickImageView.makeRoundedView()
    }

    func configureView(with model: EMISelectionCollectionViewCell.Model) {
        self.uid = model.uid
        parentView.backgroundColor = model.backgroundColor
        lblEMIAmount.text = UtilityFunctions.toCommaSeperatedAmount(value: Int(model.emiAmount), addRupeeSymbol: true) + " / mo"
        lblEMIDuration.text = "for " + String(model.emiDuration) + " months"
        recommendedView.isHidden = !model.isRecommended
        
        if model.isSelected {
            tickImageView.image = UIImage(systemName: "checkmark")
            tickImageView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
        } else {
            tickImageView.image = nil
            tickImageView.backgroundColor = .clear
        }
    }
    
    @IBAction func tickMarkTapped() {
        if let uid {
            delegate?.tickMarkTapped(at: uid)
        }
    }
}
