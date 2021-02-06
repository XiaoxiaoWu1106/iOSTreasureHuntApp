//
//  Hunt.swift
//  TreasureHuntingiOS
//
//  Created by Xiaoxiao Wu on 22.8.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation
import Contentful

final class Hunt: EntryDecodable, FieldKeysQueryable {
    static var contentTypeId: ContentTypeId {
        return "hunt"
    }
    enum FieldKeys: String, CodingKey {
        case title, description, objective, author, stages
        case isCompetitive, initialLocation, requiredAge, timeLimitInMin
        case fitnessLevel, equipmentDescription, requiredEquipment
    }

    // must have
    var id: String
    var updatedAt: Date?
    var createdAt: Date?
    var localeCode: String?
    var title: String
    var description: String
    var objective: String
    var author: String
    var stages: [Stage] = []

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

    public required init(from decoder: Decoder) throws {
        let sys         = try decoder.sys()
        id              = sys.id
        localeCode      = sys.locale
        updatedAt       = sys.updatedAt
        createdAt       = sys.createdAt

        let fields = try decoder.contentfulFieldsContainer(keyedBy: Hunt.FieldKeys.self)

        self.title                 = try fields.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description           = try fields.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.objective             = try fields.decodeIfPresent(String.self, forKey: .objective) ?? ""
        self.author                = try fields.decodeIfPresent(String.self, forKey: .author) ?? ""
        self.isCompatitive         = try fields.decodeIfPresent(Bool.self, forKey: .isCompetitive) ?? false
        self.ageRequired           = try fields.decodeIfPresent(Int.self, forKey: .requiredAge) ?? 0
        self.timeLimitInMin        = try fields.decodeIfPresent(Int.self, forKey: .timeLimitInMin) ?? 0
        self.fitnessLevel          = try fields.decodeIfPresent(Int.self, forKey: .fitnessLevel) ?? 0
        self.equipmentDescription  = try fields.decodeIfPresent(String.self, forKey: .equipmentDescription) ?? ""
        self.requiredEquipment     = try fields.decodeIfPresent(Array<String>.self, forKey: .requiredEquipment) ?? []
        try fields.resolveLinksArray(forKey: .stages, decoder: decoder) { [weak self]
                stages in
            self?.stages = stages as? [Stage] ?? []
        }
    }

}
