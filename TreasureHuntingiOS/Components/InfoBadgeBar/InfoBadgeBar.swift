//
//  InfoBadgeBar.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 14.10.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit

class InfoBadgeBar: UIView {
    @IBOutlet weak var firstIcon: UIImageView!
    @IBOutlet weak var secondIcon: UIImageView!
    @IBOutlet weak var thirdIcon: UIImageView!
    @IBOutlet weak var forthIcon: UIImageView!
    @IBOutlet weak var fifthIcon: UIImageView!
    @IBOutlet weak var sixthIcon: UIImageView!
    @IBOutlet weak var seventhIcon: UIImageView!
    
    var hunt: Hunt? {
        didSet{
            drawHunt()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func drawHunt() {
        let iconList = [seventhIcon, sixthIcon, fifthIcon, forthIcon, thirdIcon, secondIcon, firstIcon]
        
        let huntIcons = convertHuntToIcons()
        for (index,iconView) in iconList.enumerated() {
            let isValidIndex = index < huntIcons.count
            iconView?.image = isValidIndex ? huntIcons[index] : nil
            //iconView?.isHidden = !isValidIndex
        }
    }
    
    private func convertHuntToIcons() -> [UIImage] {
        guard let hunt = self.hunt else { return [] }
        var icons: [UIImage] = []
        
        icons.append(getLanguageIcon(hunt.lang))
        icons.append(getIconByName(getAgeRequirementIconName(hunt.ageRequired)))
        icons.append(getIconByName(getFitnessIconName(hunt.fitnessLevel ?? 0)))
        
        if hunt.location != nil, let icon = UIImage(named: "LocationIcon") {
            icons.append(icon)
        }
        if let limit = hunt.timeLimitInMin, limit > 0, let icon = UIImage(named: "TimeLimitIcon") {
            icons.append(icon)
        }
        if hunt.hasPrintableAttachments, let icon = UIImage(named: "PrintIcon") {
            icons.append(icon)
        }
        if !(hunt.requiredEquipment?.isEmpty ?? true), let icon = UIImage(named: "EquipmentIcon") {
            icons.append(icon)
        }
        return icons
    }
    
    func getAgeRequirementIconName(_ age: Int) -> String {
        switch age {
        case 0...2:
            return "AgeAllIcon"
        case 3...6:
            return "Age3Icon"
        case 7...11:
            return "Age7Icon"
        case 12...15:
            return "Age12Icon"
        case 16,17:
            return "Age16Icon"
        default:
            return "Age18Icon"
        }
    }
    
    func getFitnessIconName(_ level: Int) -> String {
        switch level {
        case 2:
            return "FitnessHardIcon"
        case 1:
            return "FitnessMediumIcon"
        default:
            return "FitnessEasyIcon"
        }
    }
    
    func getLanguageIcon(_ lang: String) -> UIImage {
        return UIImage()
    }
    
    private func getIconByName(_ name: String) -> UIImage {
        return UIImage(named: name) ?? UIImage()
    }
    
    /*func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }*/
}
