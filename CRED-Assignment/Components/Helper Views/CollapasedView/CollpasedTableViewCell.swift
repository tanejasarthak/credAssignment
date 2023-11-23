//
//  CollpasedTableViewCell.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 22/11/23.
//

import UIKit

protocol CollpasedTableViewCellProtocol: AnyObject {
    func collapsedTableViewCellTapped(at tag: Int)
}

class CollpasedTableViewCell: UITableViewCell {
    // MARK: - Model
    struct Model: GeneralTableViewModelProtocol {
        var firstHeading: String?
        var firstSubHeading: String?
        var secondHeading: String?
        var secondSubHeading: String?
        var viewTag: Int
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var headingFirst: UILabel!
    @IBOutlet weak var subHeadingFirst: UILabel!
    @IBOutlet weak var headingSecond: UILabel!
    @IBOutlet weak var subHeadingSecond: UILabel!
    
    // MARK: - Properties
    weak var delegate: CollpasedTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(with model: CollpasedTableViewCell.Model) {
        headingFirst.text = model.firstHeading
        subHeadingFirst.text = model.firstSubHeading
        headingSecond.text = model.secondHeading
        subHeadingSecond.text = model.secondSubHeading
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped() {
        delegate?.collapsedTableViewCellTapped(at: self.tag)
    }
}
