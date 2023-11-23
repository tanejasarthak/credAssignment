//
//  EMISelectionRepaymentTableViewCell.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 22/11/23.
//

import UIKit

protocol GeneralTableViewModelProtocol { }

class EMISelectionRepaymentTableViewCell: UITableViewCell {

    // MARK: - Model
    struct Model: GeneralTableViewModelProtocol {
        var emiSelectionCollectionViewCellsArr: [EMISelectionCollectionViewCell.Model]
        var isCurrentlyActiveView: Bool
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "EMISelectionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EMISelectionCollectionViewCell")
        }
    }
    @IBOutlet weak var createYourPlanCTA: UIButton! {
        didSet {
            createYourPlanCTA.makeRoundedView()
        }
    }
    @IBOutlet weak var parentView: UIView! {
        didSet {
            parentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            parentView.layer.cornerRadius = 8.0
        }
    }
    
    // MARK: - Properties
    private var collectionViewModels: EMISelectionRepaymentTableViewCell.Model?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(with model: EMISelectionRepaymentTableViewCell.Model) {
        self.collectionViewModels = model
        parentView.isHidden = !model.isCurrentlyActiveView
        self.isHidden = !model.isCurrentlyActiveView
    }
    
    @IBAction func createYourPlanCTATapped() {
        
    }
}

// MARK: - UICollectionViewDelegate and Datasource
extension EMISelectionRepaymentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (collectionViewModels?.emiSelectionCollectionViewCellsArr.count).unwrappedValue(or: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EMISelectionCollectionViewCell", for: indexPath) as! EMISelectionCollectionViewCell
        if let model = collectionViewModels?.emiSelectionCollectionViewCellsArr[indexPath.row] {
            cell.configureView(with: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: collectionView.frame.height)
    }
}
