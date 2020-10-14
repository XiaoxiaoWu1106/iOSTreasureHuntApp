//
//  DatabaseManager.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 30.9.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation

protocol DBManager {
    func saveSummary(summary: Summary)
    func loadSummaries(hunt: Hunt) -> [Summary]
    func saveHunt(hunt: Hunt)
    func loadHunts() -> [Hunt]
    func deleteHunt(hunt: Hunt)
}

class DatabaseManager: DBManager {
    static let shared = DatabaseManager()
    func saveSummary(summary: Summary) {
    }

    func loadSummaries(hunt: Hunt) -> [Summary] {
        return []
    }
    func saveHunt(hunt: Hunt) {
    }
    func loadHunts() -> [Hunt] {
        return []
    }
    func deleteHunt(hunt: Hunt) {
    }
}
