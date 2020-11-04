//
//  HuntDetailViewController.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 4.10.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit

class HuntDetailViewController: UIViewController {

    @IBOutlet weak var tableView: GenericTableView!

    var huntItem: Hunt!

    override func viewDidLoad() {
        super.viewDidLoad()
        let header = GenericRow(rowType: .huntHeader, userInfo: ["hunt": huntItem])
        let huntTitle = GenericRow(rowType: .text, userInfo: ["text": huntItem.title, "font-size": CGFloat(20),
                                                              "font-weight": UIFont.Weight.bold])
        let descriptionRow = GenericRow(rowType: .text, userInfo: ["text": huntItem.description,
                                                                   "font-size": CGFloat(15)])
        let objectiveTitle = GenericRow(rowType: .text, userInfo: ["text": "Objective", "font-size": CGFloat(20),
                                                                   "font-weight": UIFont.Weight.bold])
        let objectiveRow = GenericRow(rowType: .text, userInfo: ["text": huntItem.objective, "font-size": CGFloat(15)])
        let totalStageRow = GenericRow(rowType: .text, userInfo: ["text": "Total Stage:     \(huntItem.stages.count)",
                                                                  "font-size": CGFloat(20),
                                                                  "font-weight": UIFont.Weight.bold])
        tableView.setData([header, huntTitle, descriptionRow, objectiveTitle, objectiveRow, totalStageRow])
        tableView.separatorStyle = .none
    }

}
