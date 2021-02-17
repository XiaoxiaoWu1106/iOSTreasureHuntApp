//
//  ContentfulManager.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 6.2.2021.
//  Copyright © 2021 Xiaoxiao Wu. All rights reserved.
//

import Foundation
import Contentful
class ContentfulManager {
    static let shared = ContentfulManager()

    private let client: Client

    init(contentfulClient: Client = Client.huntClient) {
        self.client = contentfulClient
    }

    func getHunts(completion: @escaping ([Hunt]?, Error?) -> Void) {
        let query = QueryOn<Hunt>.include(1)
    
        client.fetchArray(of: Hunt.self, matching: query) { result in
            switch result {
            case .success(let response):
                completion(response.items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getStages(completion: @escaping ([Stage]?, Error?) -> Void) {
//        let query = QueryOn<Hunt>.where(field: .title, .equals("Test"))

        client.fetchArray(of: Stage.self) { result in
            switch result {
            case .success(let response):
                completion(response.items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
