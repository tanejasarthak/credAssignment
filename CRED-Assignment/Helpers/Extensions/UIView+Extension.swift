//
//  UIView+Extension.swift
//  CRED-Assignment
//
//  Created by Sarthak Taneja on 22/11/23.
//

import Foundation
import UIKit

extension UIView {
    func makeRoundedView() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func convertUIViewToTableViewCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        self.frame = cell.contentView.bounds
        self.translatesAutoresizingMaskIntoConstraints = true
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if cell.contentView.subviews.contains(self){
            cell.reloadInputViews()
        }else{
            cell.contentView.addSubview(self)
        }
        
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        return cell
    }
}
