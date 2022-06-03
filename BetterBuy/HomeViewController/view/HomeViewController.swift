//
//  HomeViewController.swift
//  BetterBuy
//
//  Created by user222682 on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import Foundation

class HomeViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var rootView: UIView!
    @IBOutlet private weak var adsCollectionView: UICollectionView!
    @IBOutlet private weak var brandsCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var adsPageControl: UIPageControl!
    
    // MARK: - Properties
    private let dp = DisposeBag()
    private var homeViewModel : HomeViewModelType!
    
    // MARK: - Life Cycle
    convenience init() {
        self.init(homeViewModel: nil)
    }

    init(homeViewModel: HomeViewModelType?) {
        self.homeViewModel = homeViewModel
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViews()
        homeViewModel?.getCustomers()
    }
 
    // MARK: - Functions
    private func configureCollectionViews(){
        
        brandsCollectionView.register(UINib(nibName: String(describing: BrandCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BrandCollectionViewCell.self))
        adsCollectionView.register(UINib(nibName: String(describing: advertiseCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: advertiseCollectionViewCell.self))
        adsCollectionView.rx.setDelegate(self).disposed(by: dp)
        
        let brandsLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        brandsLayout.itemSize = CGSize(width: (brandsCollectionView.frame.width - 40) / 2, height: (brandsCollectionView.frame.width - 40) / 2)
        brandsLayout.minimumInteritemSpacing = 10
        brandsLayout.minimumLineSpacing = 10
        brandsLayout.scrollDirection = .vertical
        brandsLayout.footerReferenceSize = CGSize(width: brandsCollectionView.frame.width, height: 100)
        brandsCollectionView.collectionViewLayout = brandsLayout

        adsCollectionView.rx.didEndDecelerating
                .subscribe(onNext: { [weak self] in
                    let pageNumber = round((self?.adsCollectionView.contentOffset.x ?? 0) / (self?.adsCollectionView.frame.size.width ?? 0) )
                    self?.adsPageControl.currentPage = Int(pageNumber)
                }).disposed(by: dp)

        homeViewModel?.brandsObservable.asDriver(onErrorJustReturn: [])
            .drive( brandsCollectionView.rx.items(cellIdentifier: String(describing: BrandCollectionViewCell.self) ,cellType: BrandCollectionViewCell.self ) ){( row, model, cell) in
                cell.brandImageUrl = model.image?.src
                cell.brandName  = model.title
            }.disposed(by: dp)
        
        homeViewModel?.ads.asDriver(onErrorJustReturn: []).drive( adsCollectionView.rx.items(cellIdentifier: String(describing: advertiseCollectionViewCell.self)  ,cellType: advertiseCollectionViewCell.self) ){( row, model, cell) in
            cell.brandLitteralImage = model
        }.disposed(by: dp)
        
        homeViewModel?.isLoading
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (isLoading) in
                guard let self = self else { return }
                self.rootView.isHidden = false
                self.killLoading()
                if isLoading {
                    self.rootView.isHidden = true
                    self.loading()
                }
            })
            .disposed(by: dp)
    }
}
// MARK: - Extensions
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 16 , height: 200.0)
    }
}
