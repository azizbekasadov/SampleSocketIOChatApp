//
//  BaseCell.swift
//  SampleSocketIOChatApp
//
//  Created by Azizbek Asadov on 14/06/23.
//

import UIKit

class BaseCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        separatorInset = .zero
        preservesSuperviewLayoutMargins = false
        layoutMargins = .zero
        layoutIfNeeded()
        
        // Set the selection style to None.
        selectionStyle = .none
    }
}
