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
    @IBOutlet private weak var productCollectionView: UICollectionView!
    @IBOutlet weak var navBar: NavBar!
    
    //MARK: -Properties
    let disposeBag = DisposeBag()
    var productViewModel:ProductViewModelType?
    var image: [UIImage] = [UIImage(imageLiteralResourceName: "img1"),UIImage(imageLiteralResourceName: "img2"),UIImage(imageLiteralResourceName: "img3"),UIImage(imageLiteralResourceName: "img4"),UIImage(imageLiteralResourceName: "img5"),
                            UIImage(imageLiteralResourceName: "img6")]
    
    
    //MARK: - Life Cycle
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setUpCollectionView()
        productViewModel?.getProducts()
    }
    
    //MARK: - Functions
    private func setupNavBar(){
        navBar.coordinator = productViewModel?.coordinator
    }
    
    private func setUpCollectionView(){
        productCollectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: ProductCell.cellIdentifier)
        
        productCollectionView?.backgroundColor = .clear
        productCollectionView?.contentInset = UIEdgeInsets(top: 5, left:0, bottom: 5, right:0)
        if let layout = productCollectionView?.collectionViewLayout as? ProductsCollectionViewLayout {
            layout.delegate = self
        }
        productViewModel?.productsObservable.asDriver(onErrorJustReturn: [])
            .drive( productCollectionView.rx.items(cellIdentifier: String(describing: ProductCell.cellIdentifier) ,cellType: ProductCell.self ) ){( row, model, cell) in
                
                cell.productImage = model.images?[0].src
                cell.productTitle = model.title
                cell.productDescription = model.description
                cell.productPrice = model.variants?[0].price
                //MARK:- setting user favourites product
                if self.productViewModel?.favouriteCoreData.isInFavorites(id: String(describing: model.id)) ?? false {
                    cell.favouriteBtn.setBackgroundImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
                }
                
                cell.favouriteBtn.rx.tap.bind{
                    self.productViewModel?.favouriteCoreData.addFavProduct(product: model)
                }
        }.disposed(by: disposeBag)
        
        productCollectionView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.productViewModel?.navigateToProducts(index: indexPath.row)
        }).disposed(by: disposeBag)
        
    }
    
    
}


extension ProductsViewController: ProductsLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return 270
    }
}


