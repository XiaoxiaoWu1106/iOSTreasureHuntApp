//
//  ImageWithNameCell.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 11.11.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit

class ImageWithNameCell: UICollectionViewCell {

    @IBOutlet weak var attachmentImage: UIImageView!
    @IBOutlet weak var attachmentName: UILabel!

    func config(_ att: Attachment) {
        attachmentName.text = att.name
        loadImageToView(att.path)
    }

    private func loadImageToView(_ path: String) {
        if path.starts(with: "http"), let url = URL(string: path) {
            attachmentImage.loadFrom(url: url)
        } else {
            //TODO: Load from device path....
        }
    }
}

extension UIImageView {
    func loadFrom(url: URL) {
        self.image = UIImage(named: "ImagePlaceholder")
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
