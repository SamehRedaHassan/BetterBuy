//
//  DetailsViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/27/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailsViewController: UIViewController {
    //OutLets
    
    @IBOutlet weak var productImgsCollectionView: UICollectionView!
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var productVendor: UILabel!
    @IBOutlet weak var addToFavFavouriteBtn: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var productSizesCollectionView: UICollectionView!
    
    @IBOutlet weak var addToCartBtn: UIButton!
    //MARK: variables
    var viewModel : DetailsViewModel?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productImgsCollectionView.delegate = nil
        self.productSizesCollectionView.dataSource = nil
        self.productSizesCollectionView.delegate = nil
        self.productImgsCollectionView.dataSource = nil
        viewModel?.getProductsFromFavourite()
        setSize()
        setCollectionDelegates()
        setData()
        
    }
    
    func setCollectionDelegates(){
        self.productImgsCollectionView.register(UINib(nibName: String(describing: ImgsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ImgsCollectionViewCell.self))

        self.productSizesCollectionView.register(UINib(nibName: String(describing: SizeCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SizeCollectionViewCell.self))
        
        viewModel?.images.asDriver(onErrorJustReturn: []).drive( productImgsCollectionView.rx.items(cellIdentifier: String(describing: ImgsCollectionViewCell.self) ,cellType: ImgsCollectionViewCell.self ) ){( row, model, cell) in
            cell.imgValue = model.src
        }.disposed(by: disposeBag)
        
        viewModel?.sizes.asDriver(onErrorJustReturn: []).drive( productSizesCollectionView.rx.items(cellIdentifier: String(describing: SizeCollectionViewCell.self) ,cellType: SizeCollectionViewCell.self ) ){( row, model, cell) in
            cell.sizeTxt = model
            
        }.disposed(by: disposeBag)
    }
    
    func setData(){
        addToCartBtn.rx.tap.bind{
            
        }.disposed(by: disposeBag)
        addToFavFavouriteBtn.rx.tap.bind{
            self.viewModel?.addProductToFav(product: (self.viewModel?.product)!)
            let imageIcon = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            self.addToFavFavouriteBtn.imageView?.image = imageIcon
        }.disposed(by: disposeBag)
        
        //MARK: SET The Favourite Cell Data
        productImg.sd_setImage(with: URL(string : (viewModel?.product?.images?[0].src!)!), placeholderImage: #imageLiteral(resourceName: "placeHolder"))
        productName.text = viewModel?.product?.title
        productDesc.text = viewModel?.product?.description
        productPrice.text =  viewModel?.product?.variants?[0].price
        


    }
    
    func setSize(){
         let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 70.0)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        productImgsCollectionView.collectionViewLayout = layout

         let secLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         secLayout.itemSize = CGSize(width: 80, height: 60.0)
         secLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
         secLayout.minimumInteritemSpacing = 10
         secLayout.minimumLineSpacing = 10
         secLayout.scrollDirection = .horizontal
         productSizesCollectionView.collectionViewLayout = secLayout
         
    }
    
    
}

