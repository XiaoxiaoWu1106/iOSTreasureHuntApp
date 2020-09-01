//
//  Attachment.swift
//  TreasureHuntingiOS
//
//  Created by Xiaoxiao Wu on 22.8.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation

class Attachment {
    
    var name : String
    var path : String
    var mimeType : String
    var inPrintable: Bool
    
    init(name: String, path: String, mimeType: String, isPrintable: Bool) {
        self.name = name
        self.path = path
        self.mimeType = mimeType
        self.inPrintable = isPrintable;
    }
}
