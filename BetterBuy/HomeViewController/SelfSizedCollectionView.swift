//
//  SelfSizedCollectionView.swift
//  BetterBuy
//
//  Created by user222682 on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
class SelfSizedCollectionView: UICollectionView {
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        let s = self.collectionViewLayout.collectionViewContentSize
        return CGSize(width: max(s.width, 1), height: max(s.height,1))
    }

}
