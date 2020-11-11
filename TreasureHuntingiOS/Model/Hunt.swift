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
    var description: String
    var objective: String
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

    var attachments: [Attachment] {
        var atts = [Attachment]()
        for stage in stages {
            if let stageAtts = stage.attachments {
                atts.append(contentsOf: stageAtts)
            }
        }
        return atts
    }

    init(identifier: String, title: String, description: String, objective: String, author: String,
         lang: String, stages: [Stage]) {
        self.identifier = identifier
        self.title = title
        self.description = description
        self.objective = objective
        self.author = author
        self.lang = lang
        self.stages = stages
    }

}
