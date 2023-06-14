//
//  ChatCell.swift
//  SampleSocketIOChatApp
//
//  Created by Azizbek Asadov on 14/06/23.
//

import UIKit

final class ChatCell: BaseCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    // MARK: - Private
    
    @IBOutlet private weak var lblChatMessage: UILabel!
    @IBOutlet private weak var lblMessageDetails: UILabel!
    
}
