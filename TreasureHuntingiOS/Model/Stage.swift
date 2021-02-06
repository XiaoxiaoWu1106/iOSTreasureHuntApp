//
//  Stage.swift
//  TreasureHuntingiOS
//
//  Created by Xiaoxiao Wu on 22.8.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation
import Contentful

final class Stage: EntryDecodable, FieldKeysQueryable {
    static var contentTypeId: ContentTypeId {
        return "stage"
    }
    enum FieldKeys: String, CodingKey {
        case title, description, objective, validation
        case correctValidationValue, clues, timeLimit
    }

    // must have
    var id: String
    var updatedAt: Date?
    var createdAt: Date?
    var localeCode: String?
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

    public required init(from decoder: Decoder) throws {
        let sys         = try decoder.sys()
        id              = sys.id
        localeCode      = sys.locale
        updatedAt       = sys.updatedAt
        createdAt       = sys.createdAt

        let fields = try decoder.contentfulFieldsContainer(keyedBy: Stage.FieldKeys.self)

        self.title = try fields.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try fields.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.objective = try fields.decodeIfPresent(String.self, forKey: .objective) ?? ""
        self.validation = try fields.decodeIfPresent(String.self, forKey: .validation) ?? ""
        self.correctValidationValue = try fields.decodeIfPresent(String.self, forKey: .correctValidationValue) ?? ""
        self.clues = try fields.decodeIfPresent(Array<String>.self, forKey: .clues)
        self.timeLimitInMin = try fields.decodeIfPresent(Int.self, forKey: .timeLimit) ?? 0
    }
}
