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

    override func configure(_ genericRow: GenericRow) {
        self.attachments = genericRow.userInfo["attachments"] as? [Attachment] ?? []
        self.collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attachments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
