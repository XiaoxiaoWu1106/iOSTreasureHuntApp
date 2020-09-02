//
//  Stage.swift
//  TreasureHuntingiOS
//
//  Created by Xiaoxiao Wu on 22.8.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation

class Stage {

    // must have
    var title: String
    var description: String
    var objective: String
    var validation: String

    // optional
    var correctValidationValue: String?
    var attachments: [Attachment]?
    var timeLimitInMin: Int?
    var location: Location?
    var clues: [String]?

    // THIS FOLLOWING FIELDS ARE FOR COMPLETED ACTIVITY
    var completionState: String?  // completed/failed,
    var userTakenPhoto: String?   // “/Path/”
    var userTextNote: String?

    init(title: String, description: String, objective: String, validation: String) {
        self.title = title
        self.description = description
        self.objective = objective
        self.validation = validation
    }
}
