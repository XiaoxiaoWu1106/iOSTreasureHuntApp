//
//  File.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 9.9.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit

extension UITableView {
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
