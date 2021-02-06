//
//  HuntManager.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 30.9.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation

class HuntManager {
// MARK: - variables
    static let shared = HuntManager()
    private var hunt: Hunt?
    private var summary: Summary?
    private var database: DBManager
    private var exporting: ExportManager
    init(dbManager: DBManager = DatabaseManager.shared, exportManager: ExportManager = ExportManager.shared) {
        database = dbManager
        self.exporting = exportManager
    }
    func doSomething(hunt: Hunt) {
        if hunt.id == "brook" {
            database.saveHunt(hunt: hunt)
        }
    }
    func exportHunt(_ hunt: Hunt) {
    }
}

class ExportManager {
    static let shared = ExportManager()
}
