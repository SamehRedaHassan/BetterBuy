//
//  ProductsViewController.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: UIViewController{
    
    
    //MARK: -IBOutlet
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    //MARK: -Life Cycle
    
    convenience init() {
        self.init(productViewModel: nil)
    }
    
    init(productViewModel: ProductViewModelType?) {
        self.productViewModel = productViewModel
        super.init(nibName: "ProductView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let disposeBag = DisposeBag()
    var productViewModel:ProductViewModelType?
    var image: [UIImage] = [UIImage(imageLiteralResourceName: "img1"),UIImage(imageLiteralResourceName: "img2"),UIImage(imageLiteralResourceName: "img3"),UIImage(imageLiteralResourceName: "img4"),UIImage(imageLiteralResourceName: "img5"),
                            UIImage(imageLiteralResourceName: "img6")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        productViewModel?.getProducts()
        onClick()
    }
    
    private func setUpCollectionView(){
        productCollectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: ProductCell.cellIdentifier)
        
        productCollectionView?.backgroundColor = .clear
        productCollectionView?.contentInset = UIEdgeInsets(top: 5, left: 4, bottom: 5, right: 4)
        if (productCollectionView?.collectionViewLayout as? ProductsCollectionViewLayout) != nil {
//            layout.delegate = self
        }
        productViewModel?.productsObservable.asDriver(onErrorJustReturn: [])
            .drive( productCollectionView.rx.items(cellIdentifier: String(describing: ProductCell.cellIdentifier) ,cellType: ProductCell.self ) ){( row, model, cell) in
                
                cell.productImage = model.images?[0].src
                cell.productTitle = model.title
                cell.productDescription = model.description
                cell.productPrice = model.variants?[0].price
        }.disposed(by: disposeBag)
        
        
    }
    
    func onClick(){
        productCollectionView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.productViewModel?.goToProductDetailsScreen(product: indexPath.row)
        })
    }
    
}


extension ProductsViewController: ProductsLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return image[0].size.height
    }
    
    
}




//MARK: - collectionview extension delegate for view purpose only
//extension ProductsViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 6
//    }
//
//    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.cellIdentifier, for: indexPath as IndexPath) as! ProductCell
//        cell.productImg.image = image[indexPath.row]
//        cell.productTitleLB.text = "BackPack"
//        cell.productDesLB.text = "Nike backpack with many pockat plaplplaplpal papllpdflapflpap plapfldf"
//        cell.productPriceLB.text = "159EG"
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
//
//        return CGSize(width: itemSize, height: itemSize)
//    }
//
//
//}
