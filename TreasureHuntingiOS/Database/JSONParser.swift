//
//  JSONParser.swift
//  TreasureHuntingiOS
//
//  Created by Xiaoxiao Wu on 22.8.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation
typealias JsonObject = [String: Any]

class JSONParser {
    func parseHunt(fileName: String) -> Hunt? {
        var hunt: Hunt?
        let path = Bundle.main.path(forResource: fileName, ofType: "json")

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return nil }
        guard let huntJson = json as? [String: Any] else { return nil }

        if let identifier = huntJson["id"] as? String,
            let title = huntJson["title"] as? String,
            let description = huntJson["description"] as? String,
            let objective = huntJson["objective"] as? String,
            let author = huntJson["author"] as? String,
            let lang = huntJson["lang"] as? String,
            let stageArray = huntJson["stages"] as? [[String: Any]] {
            let stages = parseStages(stages: stageArray)
//            hunt = Hunt(identifier: identifier, title: title, description: description,
//                        objective: objective, author: author, lang: lang, stages: stages)

            Logger.error("hunt created")
        }

        hunt?.isCompatitive = huntJson["is_competitive"] as? Bool ?? false
        hunt?.hasPrintableAttachments = huntJson["has_printing_attachments"] as? Bool ?? false
        hunt?.ageRequired = huntJson["required_age"] as? Int ?? 0
        hunt?.equipmentDescription = huntJson["equipment_description"] as? String

        if let location = huntJson["initial_location"] as? [String: Any] {
            hunt?.location = parseLocation(location: location)
        }
        if let timeLimitInMin = huntJson["time_limit_in_min"] as? Int {
            hunt?.timeLimitInMin = timeLimitInMin
        }
        if let fitnessLevel = huntJson["fitness_level"] as? Int {
            hunt?.fitnessLevel = fitnessLevel
        }
        if let requiredEquipment = huntJson["required_equipment"] as? [String] {
            hunt?.requiredEquipment = requiredEquipment
        }
        return hunt
    }

    func parseLocation(location: [String: Any]) -> Location? {
        guard let lon = location["lon"] as? Double,
            let lat = location["lat"] as? Double else {
                Logger.error("JsonParser.parseLocation -> wrong values for location")
                return nil
        }
        return Location(lon: lon, lat: lat)
    }

    func parseStages(stages: [[String: Any]]) -> [Stage] {
        return []
    }

    func parseAttachments(attachments: [[String: Any]]) -> [Attachment] {
        var attachmentArray: [Attachment] = []
        for attachment in attachments {
            if let name = attachment["name"] as? String,
                let path = attachment["path"] as? String,
                let mimeType = attachment["mime_type"] as? String,
                let isPrintable = attachment["is_printable"] as? Bool {
                let newAttachment = Attachment(name: name, path: path,
                                                    mimeType: mimeType, isPrintable: isPrintable)
                attachmentArray.append(newAttachment)
            }
        }
        return attachmentArray
    }

}
