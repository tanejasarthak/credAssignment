//
//  BottomCTAViewModel.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 21/11/23.
//

import Foundation

struct BottomCTAViewModel {
    // MARK: - Properties
    private var model: BottomCTAModel
    
    // MARK: - Initialiser
    init(model: BottomCTAModel) {
        self.model = model
    }
    
    // MARK: Populate UIView
    func getModelToPopulateUI() -> BottomCTAModel {
        return model
    }
}
