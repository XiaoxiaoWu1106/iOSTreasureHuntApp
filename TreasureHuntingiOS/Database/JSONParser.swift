//
//  JSONParser.swift
//  TreasureHuntingiOS
//
//  Created by Xiaoxiao Wu on 22.8.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation

class JSONParser {
    
    func parseHunt(fileName: String) -> Hunt{
        var hunt: Hunt?
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let huntJson = json as? [String: Any] {
                if let id = huntJson["id"] as? String,
                    let title = huntJson["title"] as? String,
                    let explanation = huntJson["explanation"] as? String,
                    let author = huntJson["author"] as? String,
                    let lang = huntJson["lang"] as? String,
                    let stageArray = huntJson["stages"] as? [[String: Any]] {
                        
                    let stages = parseStages(stages: stageArray)
                    hunt = Hunt.init(id: id, title: title, explanation: explanation, author: author, lang: lang, stages: stages)
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
            }
        } catch {
            print(error)
        }
        return hunt!
    }
    
    func parseLocation(location: [String: Any]) -> Location {
        var initialLocation: Location?
        if let lon = location["lon"] as? Double,
            let lat = location["lat"] as? Double {
            initialLocation = Location.init(lon: lon, lat: lat)
        }
        return initialLocation!
    }
    
    func parseStages(stages: [[String: Any]]) -> [Stage]{
        var stageArray: [Stage] = []
        for stage in stages {
            if let title = stage["title"] as? String,
            let description = stage["description"] as? String,
            let objective = stage["objective"] as? String,
                let validation = stage["validation"] as? String {
                let newStage = Stage.init(title: title, description: description, objective: objective, validation: validation)
                
                if let correctValidationValue = stage["correct_validation_value"] as? String {
                    newStage.correctValidationValue = correctValidationValue
                }
                if let attachmentArray = stage["attachments"] as? [[String: Any]] {
                    let attachments = parseAttachments(attachments: attachmentArray)
                    newStage.attachments = attachments
                }
                if let timeLimitInMin = stage["time_limit_in_min"] as? Int {
                    newStage.timeLimitInMin = timeLimitInMin
                }
                if let clues = stage["clues"] as? [String] {
                    newStage.clues = clues
                }
                stageArray.append(newStage)
            }
        }
        return stageArray
    }
    
    func parseAttachments(attachments: [[String: Any]]) -> [Attachment]{
        var attachmentArray: [Attachment] = []
        for attachment in attachments {
            if let name = attachment["name"] as? String,
            let path = attachment["path"] as? String,
            let mimeType = attachment["mime_type"] as? String,
                let isPrintable = attachment["is_printable"] as? Bool {
                let newAttachment = Attachment.init(name: name, path: path, mimeType: mimeType, isPrintable: isPrintable)
                attachmentArray.append(newAttachment)
            }
        }
        return attachmentArray
    }
    
}
