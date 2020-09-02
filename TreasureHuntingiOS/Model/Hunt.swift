//
//  Hunt.swift
//  TreasureHuntingiOS
//
//  Created by Xiaoxiao Wu on 22.8.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation

class Hunt {
    // must have
    var identifier: String
    var title: String
    var explanation: String
    var author: String
    var lang: String
    var stages: [Stage]

    // optional
    var isCompatitive: Bool = false
    var hasPrintableAttachments: Bool = false
    var location: Location?
    var ageRequired: Int = 0
    var timeLimitInMin: Int?
    var fitnessLevel: Int?
    var equipmentDescription: String?
    var requiredEquipment: [String]?

    init(identifier: String, title: String, explanation: String, author: String, lang: String, stages: [Stage]) {
        self.identifier = identifier
        self.title = title
        self.explanation = explanation
        self.author = author
        self.lang = lang
        self.stages = stages
    }
}
