//
//  BankDetailsTableViewCell.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 22/11/23.
//

import UIKit

protocol BankDetailsTableViewCellProtocol: AnyObject {
    func bankSelected(with id: Int)
}

class BankDetailsTableViewCell: UITableViewCell {

    // MARK: - Model
    struct Model {
        var bankId: Int
        var bankLogoImage: UIImage?
        var bankName: String
        var bankAccountNumber: Int
        var isSelected: Bool
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var bankImgView: UIImageView!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblBankAccNumber: UILabel!
    @IBOutlet weak var selectedImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(with model: BankDetailsTableViewCell.Model) {
        bankImgView.image = model.bankLogoImage
        lblBankName.text = model.bankName
        lblBankAccNumber.text = String(model.bankAccountNumber)
        selectedImgView.image = model.isSelected ? UIImage(named: "") : UIImage(named: "")
    }
}
