//
//  BottomCTAView.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 21/11/23.
//

import UIKit

class BottomCTAView: UIView {
    
    // MARK: - Properties
    private var viewModel: BottomCTAViewModel
    let ctaBackgroundView = UIView()
    let ctaTextLabel = UILabel()
    
    // MARK: - Initializer
    init(viewModel: BottomCTAViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AutoLayoutSetup
    private func setupView() {
        /// Top Corners Rounded
        ctaBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        ctaBackgroundView.layer.cornerRadius = 16.0
        ctaBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ctaBackgroundView)
        
        /// CTA backgroundView Auto Layout Constraints
        ctaBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ctaBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ctaBackgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ctaBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        ctaTextLabel.translatesAutoresizingMaskIntoConstraints = false
        ctaBackgroundView.addSubview(ctaTextLabel)
        
        /// CTA Text Label Auto Layout Constraints
        ctaTextLabel.centerXAnchor.constraint(equalTo: ctaBackgroundView.centerXAnchor).isActive = true
        ctaTextLabel.topAnchor.constraint(equalTo: ctaBackgroundView.topAnchor, constant: 16).isActive = true
        ctaTextLabel.bottomAnchor.constraint(equalTo: ctaBackgroundView.bottomAnchor, constant: -16).isActive = true
        
        populateDynamicData(with: nil)
    }
    
    func populateDynamicData(with bottomCTAModel: BottomCTAModel?) {
        if let bottomCTAModel {
            viewModel = BottomCTAViewModel(model: bottomCTAModel)
        }
        let dataToPopulate = viewModel.getModelToPopulateUI()
        ctaBackgroundView.backgroundColor = dataToPopulate.ctaBackgroundColor
        ctaTextLabel.textColor = dataToPopulate.ctaTextColor
        ctaTextLabel.text = dataToPopulate.ctaTitleString
    }
}
