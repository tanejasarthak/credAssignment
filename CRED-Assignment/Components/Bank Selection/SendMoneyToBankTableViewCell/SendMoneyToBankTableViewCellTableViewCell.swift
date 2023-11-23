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
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var tblView: ContentSizedTableView! {
        didSet {
            tblView.register(UINib(nibName: "BankDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "BankDetailsTableViewCell")
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
