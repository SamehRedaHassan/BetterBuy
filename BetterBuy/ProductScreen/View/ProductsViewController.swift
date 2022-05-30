//
//  ProductsViewController.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    var viewModel:ProductsViewModel?
    var image: [UIImage] = [UIImage(imageLiteralResourceName: "img1"),UIImage(imageLiteralResourceName: "img2"),UIImage(imageLiteralResourceName: "img3"),UIImage(imageLiteralResourceName: "img4"),UIImage(imageLiteralResourceName: "img5"),
    UIImage(imageLiteralResourceName: "img6")]
    override func viewDidLoad() {
        super.viewDidLoad()

        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: ProductCell.cellIdentifier)
        
        productCollectionView?.backgroundColor = .clear
        productCollectionView?.contentInset = UIEdgeInsets(top: 5, left: 4, bottom: 5, right: 4)
           if let layout = productCollectionView?.collectionViewLayout as? ProductsCollectionViewLayout {
             layout.delegate = self
           }
    }

}
extension ProductsViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.cellIdentifier, for: indexPath as IndexPath) as! ProductCell
        cell.productImg.image = image[indexPath.row]
        cell.productTitleLB.text = "BackPack"
        cell.productDesLB.text = "Nike backpack with many pockat plaplplaplpal papllpdflapflpap plapfldf"
        cell.productPriceLB.text = "159EG"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        
        return CGSize(width: itemSize, height: itemSize)
    }
    
    
}

extension ProductsViewController: ProductsLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return image[indexPath.row].size.height
    }
}
