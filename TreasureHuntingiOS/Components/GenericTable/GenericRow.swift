//
//  GenericRow.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 7.10.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation
import UIKit

//GenericRowType expects the string to be the name of the Row UI xib file
enum GenericRowType: String {
    case text = "GenericTextCell"
}

class GenericRow {
    let rowType: GenericRowType
    let userInfo: JsonObject
    
    init(rowType: GenericRowType, userInfo: JsonObject = [:] ) {
        self.rowType = rowType
        self.userInfo = userInfo
    }
}

class GenericTableRowFactory {
    class func getRow(_ tableView: GenericTableView, genericRow: GenericRow) -> UITableViewCell {
        let identifier = genericRow.rowType.rawValue
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? GenericRowCell else {
            return UITableViewCell(frame: .zero)
        }
        cell.configure(genericRow)
        return cell
    }
}

class GenericTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    private var rowDataSet: [GenericRow] = []
    override func layoutSubviews() {
        super.layoutSubviews()
        self.dataSource = self
        self.delegate = self
        registerCells()
    }
    func registerCells() {
        self.register(UINib(nibName: GenericRowType.text.rawValue, bundle: nil),
                      forCellReuseIdentifier: GenericRowType.text.rawValue)
    }
    func setData(_ data: [GenericRow]) {
        DispatchQueue.main.async {
            self.estimatedRowHeight = 50
            self.rowHeight = UITableView.automaticDimension
            self.rowDataSet = data
            self.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowDataSet.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let genericRow = rowDataSet[indexPath.row]
        return GenericTableRowFactory.getRow(self, genericRow: genericRow)
    }
}
