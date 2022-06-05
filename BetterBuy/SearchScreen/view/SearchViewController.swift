//
//  SearchViewController.swift
//  BetterBuy
//
//  Created by user222682 on 6/5/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var navBar: NavBar!
    @IBOutlet private weak var productsCollectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!{
        didSet{
            searchBar.searchTextField.rx.text.orEmpty
                .bind(to: viewModel.filterWordSubject)
                    .disposed(by: disposeBag)
        }
    }
    
    //MARK: variables
    private var viewModel : SearchViewModelType!
    private let disposeBag = DisposeBag()
    var  noDataView : UIView!
    // MARK: - Life Cycle
    convenience init() {
        self.init(searchViewModel: nil)
    }

    init(searchViewModel: SearchViewModelType?) {
        self.viewModel = searchViewModel
        super.init(nibName: String(describing: SearchViewController.self), bundle: nil)
        noDataView = getNoDataViewWith(image: UIImage(named: "noData")!, head: "No Data Found")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configureCollectionViews()
        viewModel.getAllProducts()
    }

    // MARK: - Functions
    private func setupNavBar(){
        navBar.coordinator = viewModel.coordinator
    }
    
    private func configureCollectionViews(){
        productsCollectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: ProductCell.cellIdentifier)
       
        productsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    
        viewModel?.productsObservable.asDriver(onErrorJustReturn: [])
            .drive( productsCollectionView.rx.items(cellIdentifier: ProductCell.cellIdentifier ,cellType: ProductCell.self ) ){( row, model, cell) in
                cell.productImage = model.images?[0].src
                cell.productTitle = model.title
                cell.productDescription = model.description
                cell.productPrice = model.variants?[0].price
                cell.isFavouriteButtonHidden = true
            }.disposed(by: disposeBag)
       
        viewModel?.isLoading
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (isLoading) in
                guard let self = self else { return }
                self.killLoading()
                if isLoading {
                    self.loading()
                }
            }).disposed(by: disposeBag)
        
        productsCollectionView.rx.itemSelected
                .subscribe(onNext:{ [weak self] indexPath in
                    guard let self = self else {return}
                    self.viewModel.navigateToProductDetails(atIndex: indexPath.item)
        }).disposed(by: disposeBag)
        
        viewModel.isEmptyCollection.distinctUntilChanged().subscribe { [weak self] isEmpty in
            guard let self = self else{return}
            if(isEmpty.element ?? false){  self.productsCollectionView.addSubview(self.getNoDataViewWith(image: UIImage(named: "noData")!, head: "No Items Found :("))
            }else {
                self.productsCollectionView.removeAllSubviews()
            }
        } .disposed(by: disposeBag)

   

        
    }

}
//// MARK: - Extensions
extension SearchViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (productsCollectionView.frame.size.width - 10 ) / 2, height:  300.0)
    }
}
