//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Marcelo Rodrigues de Sousa on 29/09/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var rightMessageImage: UIImageView!
    @IBOutlet weak var leftMessageImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height/5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
