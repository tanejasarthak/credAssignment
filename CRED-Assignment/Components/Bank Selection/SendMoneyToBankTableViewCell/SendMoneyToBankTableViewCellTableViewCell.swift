//
//  SendMoneyToBankTableViewCellTableViewCell.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 22/11/23.
//

import UIKit

class SendMoneyToBankTableViewCellTableViewCell: UITableViewCell {

    // MARK: - Model
    struct Model: GeneralTableViewModelProtocol {
        var tblViewModel: [BankDetailsTableViewCell.Model]
        var isCurrentlyActiveView: Bool
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var tblView: ContentSizedTableView! {
        didSet {
            tblView.register(UINib(nibName: "BankDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "BankDetailsTableViewCell")
        }
    }
    @IBOutlet weak var parentView: UIView! {
        didSet {
            parentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            parentView.layer.cornerRadius = 32.0
        }
    }
    @IBOutlet weak var changeAccountView: UIView! {
        didSet {
            changeAccountView.makeRoundedView()
            changeAccountView.layer.borderWidth = 1.0
            changeAccountView.layer.borderColor = UIColor(red: 180, green: 190, blue: 210, alpha: 1.0).cgColor
        }
    }
    
    // MARK: - Properties
    private var tblViewModel: [BankDetailsTableViewCell.Model]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(with bankDetailsModel: SendMoneyToBankTableViewCellTableViewCell.Model) {
        self.tblViewModel = bankDetailsModel.tblViewModel
        parentView.isHidden = !bankDetailsModel.isCurrentlyActiveView
        self.isHidden = !bankDetailsModel.isCurrentlyActiveView
    }
}

// MARK: - UITableViewDelegate and DataSource
extension SendMoneyToBankTableViewCellTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (tblViewModel?.count).unwrappedValue(or: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BankDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BankDetailsTableViewCell", for: indexPath) as! BankDetailsTableViewCell
        if let model = tblViewModel?[indexPath.row] {
            cell.configureView(with: model)
        }
        return cell
    }
}
