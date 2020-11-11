//
//  GenericTextCell.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 7.10.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit
class GenericRowCell: UITableViewCell {
    func configure(_ genericRow: GenericRow) {
        fatalError("configure is not implemented")
    }

    func configFont(for label: UILabel, dict: JsonObject) {
        let textSize = dict["font-size"] as? CGFloat ?? 17.0
        let textWeight = dict["font-weight"] as? UIFont.Weight ?? .regular
        label.font = UIFont.systemFont(ofSize: textSize, weight: textWeight)
    }
}

class GenericTextCell: GenericRowCell {
    @IBOutlet weak var rowCellLabel: UILabel!

    override func configure(_ genericRow: GenericRow) {
        self.rowCellLabel.text = genericRow.userInfo["text"] as? String ?? "..."
        configFont(for: self.rowCellLabel, dict: genericRow.userInfo)
    }

}
