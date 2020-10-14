//
//  HuntTableViewCell.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 5.9.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit

class HuntTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var huntIcon: UIImageView!
    @IBOutlet weak var huntName: UILabel!
    @IBOutlet weak var huntIcons: InfoBadgeBar!
    override func awakeFromNib() {
        super.awakeFromNib()
        let tempImageView = UIImageView(image: UIImage(named: "HomeViewCellBackground"))
        tempImageView.frame = cellBackground.frame
//        self.backgroundView = tempImageView
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(_ hunt: Hunt) {
        huntName.text = hunt.title
        huntIcons.hunt = hunt
    }
}
