//
//  Attachment.swift
//  TreasureHuntingiOS
//
//  Created by Xiaoxiao Wu on 22.8.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation
import Contentful

final class Attachment: EntryDecodable, FieldKeysQueryable {
    static var contentTypeId: ContentTypeId {
        return "attachment"
    }
    enum FieldKeys: String, CodingKey {
        case name, path, mimeType, isPrintable
    }
    var id: String
    var updatedAt: Date?
    var createdAt: Date?
    var localeCode: String?
    var name: String
    var path: String
    var mimeType: String
    var isPrintable: Bool
    
    public required init(from decoder: Decoder) throws {
        let sys         = try decoder.sys()
        id              = sys.id
        localeCode      = sys.locale
        updatedAt       = sys.updatedAt
        createdAt       = sys.createdAt

        let fields = try decoder.contentfulFieldsContainer(keyedBy: Attachment.FieldKeys.self)

        self.name = try fields.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.path = try fields.decodeIfPresent(String.self, forKey: .path) ?? ""
        self.mimeType = try fields.decodeIfPresent(String.self, forKey: .mimeType) ?? ""
        self.isPrintable = try fields.decodeIfPresent(Bool.self, forKey: .isPrintable) ?? false
    }
}
