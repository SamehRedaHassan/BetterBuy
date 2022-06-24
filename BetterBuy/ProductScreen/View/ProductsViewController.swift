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

class ProductsViewController: BaseViewController{
    
    //MARK: -IBOutlet
    @IBOutlet private weak var productCollectionView: UICollectionView!
    @IBOutlet weak var navBar: NavBar!
    
    //MARK: -Properties
    private let disposeBag = DisposeBag()
    var productViewModel:ProductViewModelType?
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
        productCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productCollectionView.reloadData()
        navBar.updateNavButtonsState()
    }
    
    //MARK: - Functions
    private func setupNavBar(){
        navBar.coordinator = productViewModel?.coordinator
    }
    
    private func setUpCollectionView(){
        productCollectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: ProductCell.cellIdentifier)
        productCollectionView?.backgroundColor = .clear
        productCollectionView?.contentInset = UIEdgeInsets(top: 5, left:0, bottom: 5, right:0)
        productViewModel?.productsObservable.observeOn(MainScheduler.asyncInstance).subscribe(onNext: { (_) in
            self.productCollectionView.reloadData()
            }).disposed(by: disposeBag)
        productViewModel?.productsObservable.asDriver(onErrorJustReturn: [])
            .drive( productCollectionView.rx.items(cellIdentifier: String(describing: ProductCell.cellIdentifier)
                ,cellType: ProductCell.self ) ){( row, model, cell) in
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
                    
                    
        }.disposed(by: disposeBag)
        
        productCollectionView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.productViewModel?.navigateToProducts(index: indexPath.row)
        }).disposed(by: disposeBag)
        
        productViewModel?.isEmptyCollection.distinctUntilChanged().subscribe{ [weak self] isEmpty in
            guard let self = self else{return}
            DispatchQueue.main.async {
                if(isEmpty.element ?? false){
                    self.productCollectionView.addSubview(self.getNoDataViewWith(image: UIImage(named: "noData")!, head: "No items Yet :("))
                }else {
                    self.productCollectionView.removeAllSubviews()
                }
            }
        } .disposed(by: disposeBag)
        
    }
    
    @IBAction func didChangeCategory(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            selectedCategory = "all"
            self.productViewModel?.filterProductBySubCategory(subCategory: selectedCategory ?? "all")
        }
        else if sender.selectedSegmentIndex == 1{
            selectedCategory = "T-SHIRTS"
            self.productViewModel?.filterProductBySubCategory(subCategory: selectedCategory ?? "all")
        }
        else if sender.selectedSegmentIndex == 2{
            selectedCategory = "ACCESSORIES"
            self.productViewModel?.filterProductBySubCategory(subCategory: selectedCategory ?? "all")
        }
        else if sender.selectedSegmentIndex == 3{
            selectedCategory = "SHOES"
            self.productViewModel?.filterProductBySubCategory(subCategory: selectedCategory ?? "all")
        }
    }

    
}
extension ProductsViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (productCollectionView.frame.size.width - 10 ) / 2, height:  300.0)
    }
}


