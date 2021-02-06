//
//  InfoBadgeBar.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 14.10.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit

class InfoBadgeBar: UIView {

    var view: UIView!

    @IBOutlet weak var firstIcon: UIImageView!
    @IBOutlet weak var secondIcon: UIImageView!
    @IBOutlet weak var thirdIcon: UIImageView!
    @IBOutlet weak var forthIcon: UIImageView!
    @IBOutlet weak var fifthIcon: UIImageView!
    @IBOutlet weak var sixthIcon: UIImageView!
    @IBOutlet weak var seventhIcon: UIImageView!

    var hunt: Hunt? {
        didSet {
            drawHunt()
        }
    }

    func xibSetup() {
        view = loadViewFromNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }

    //swiftlint:disable force_cast
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: "InfoBadgeBar", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    private func drawHunt() {
        let iconList = [seventhIcon, sixthIcon, fifthIcon, forthIcon, thirdIcon, secondIcon, firstIcon]

        let huntIcons = convertHuntToIcons()
        for (index, iconView) in iconList.enumerated() {
            let isValidIndex = index < huntIcons.count
            iconView?.image = isValidIndex ? huntIcons[index] : nil
            iconView?.isHidden = !isValidIndex
        }
    }

    private func convertHuntToIcons() -> [UIImage] {
        guard let hunt = self.hunt else { return [] }
        var icons: [UIImage] = []

        icons.append(getLanguageIcon(hunt.localeCode ?? "en"))
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
        case 16, 17:
            return "Age16Icon"
        default:
            return age < 0 ?  "AgeAllIcon" : "Age18Icon"
        }
    }

    func getFitnessIconName(_ level: Int) -> String {
        switch level {
        case 0:
            return "FitnessEasyIcon"
        case 1:
            return "FitnessMediumIcon"
        default:
            return level < 0 ? "FitnessEasyIcon" : "FitnessHardIcon"
        }
    }

    func getLanguageIcon(_ lang: String) -> UIImage {
        return flag(country: lang).toImage() ?? UIImage()
    }

    private func getIconByName(_ name: String) -> UIImage {
        return UIImage(named: name) ?? UIImage()
    }

    func flag(country: String) -> String {
        var country = country.lowercased()
        if !["gb", "us", "es", "fi"].contains(country) {
            country = "gb"
        }
        let base: UInt32 = 127397
        var str = ""
        for vaar in country.uppercased().unicodeScalars {
            str.unicodeScalars.append(UnicodeScalar(base + vaar.value)!)
        }
        return String(str)
    }
}

extension String {
    func toImage() -> UIImage? {
            let size = CGSize(width: 40, height: 40)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            UIColor.white.set()
            let rect = CGRect(origin: .zero, size: size)
            UIRectFill(CGRect(origin: .zero, size: size))
            (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
}
