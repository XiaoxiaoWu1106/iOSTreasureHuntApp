//
//  ContentfulConfig.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 6.2.2021.
//  Copyright © 2021 Xiaoxiao Wu. All rights reserved.
//

import Foundation
import Contentful

class ContentfulConfig {

    static var spaceId: String {
        return "mwymzr5xbjhy"
    }

    static var accessToken: String {
        return Bundle.main.infoDictionary?["ContentfulToken"] as? String ?? ""
    }

    static var host: String {
        #if DEBUG
        return Host.preview
        #else
        return Host.delivery
        #endif
    }

    static var contentTypes: [EntryDecodable.Type] {
        return [Hunt.self, Stage.self]
    }
}

extension Client {
    static var huntClient: Client {
        return Client(spaceId: ContentfulConfig.spaceId,
                      environmentId: "master",
                      accessToken: ContentfulConfig.accessToken,
                      host: ContentfulConfig.host,
                      contentTypeClasses: ContentfulConfig.contentTypes)
    }
}
