//
//  Hunt.swift
//  TreasureHuntingiOS
//
//  Created by Xiaoxiao Wu on 22.8.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation

class Hunt{
    // must have
    var id: String
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
    var timeLimitInMin: Int? = nil
    var fitnessLevel: Int? = nil
    var equipmentDescription: String? = nil
    var requiredEquipment: [String]?
    
    init(id: String, title: String, explanation: String, author: String, lang: String, stages: [Stage]) {
        self.id = id
        self.title = title
        self.explanation = explanation
        self.author = author
        self.lang = lang
        self.stages = stages
    }
}

