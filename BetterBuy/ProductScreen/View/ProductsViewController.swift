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
    private let disposeBag = DisposeBag()
    var productViewModel:ProductViewModelType?
    /*
        case accessories = "ACCESSORIES"
        case shoes = "SHOES"
        case tShirts = "T-SHIRTS"
     */
    private var selectedCategory : String?
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
    override func viewWillAppear(_ animated: Bool) {
        productCollectionView.reloadData()
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
                
               // if(self.selectedCategory == model.productType){
                    cell.productImage = model.images?[0].src
                    cell.productTitle = model.title
                    cell.productDescription = model.description
                    cell.productPrice = model.variants?[0].price
                    //MARK:- setting user favourites product
                    if self.productViewModel?.favouriteCoreData.isInFavorites(id: String(describing: model.id!)) ?? false {
                        cell.isFavourite = true
                        self.productViewModel?.addProductToFav(index: row)
                    }
                    else{
                        cell.isFavourite = false
                        self.productViewModel?.removeProductFromFav(index: row)
                    }
                    
                    cell.addToFav = {
                        self.productViewModel?.favouriteCoreData.addFavProduct(product: model)
                        self.productViewModel?.addProductToFav(index: row)
                    }
                    cell.removeFav = {
                        self.productViewModel?.favouriteCoreData.removeFavProduct(product: model)
                        self.productViewModel?.removeProductFromFav(index: row)
                    }
             //   }
            
        }.disposed(by: disposeBag)
        
        productCollectionView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.productViewModel?.navigateToProducts(index: indexPath.row)
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func didChangeCategory(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            selectedCategory = "all"
        }
        else if sender.selectedSegmentIndex == 1{
            selectedCategory = "T-SHIRTS"
        }
        else if sender.selectedSegmentIndex == 2{
            selectedCategory = "ACCESSORIES"
        }
        else if sender.selectedSegmentIndex == 3{
            selectedCategory = "SHOES"
        }
    }
    
//    private func filterDataByCategory(products:[Product]){
//        products.filter { (product) -> Bool in
//            if(category == "men"){
//                category = " " + (category ?? "")
//            }
//            return (product.tags?.contains("\(category!)"))!
//        }
//
//    }
    
    
}
extension ProductsViewController: ProductsLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return 270
    }
}


