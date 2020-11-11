//
//  GenericAttachmentsCell.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 11.11.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import UIKit

class GenericAttachmentsCell: GenericRowCell, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    private var attachments: [Attachment] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView?.dataSource = self
        collectionView?.register(UINib(nibName: "ImageWithNameCell", bundle: nil),
                                 forCellWithReuseIdentifier: "ImageWithNameCell")
    }

    override func configure(_ genericRow: GenericRow) {
        self.attachments = genericRow.userInfo["attachments"] as? [Attachment] ?? []
        self.collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Logger.debug("Counting cells \(attachments.count)")
        return attachments.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageWithNameCell", for: indexPath)
        if let configCell = cell as? ImageWithNameCell {
            configCell.config(attachments[indexPath.row])
        }
        return cell
    }
}
