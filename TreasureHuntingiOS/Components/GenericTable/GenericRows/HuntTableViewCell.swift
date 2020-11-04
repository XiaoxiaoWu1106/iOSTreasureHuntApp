//
//  HuntTableViewCell.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 5.9.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit

class HuntTableViewCell: GenericRowCell {
    
    @IBOutlet weak var huntIcon: UIImageView!
    @IBOutlet weak var huntName: UILabel!
    @IBOutlet weak var huntIcons: InfoBadgeBar!
    
    override func configure(_ genericRow: GenericRow) {
        if let hunt = genericRow.userInfo["hunt"] as? Hunt {
            huntName.text = hunt.title
            huntIcons.hunt = hunt
        }
        
    }
}
