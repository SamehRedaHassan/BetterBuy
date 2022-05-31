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
    @IBOutlet private weak var adsCollectionView: UICollectionView!
    @IBOutlet private weak var brandsCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navBar: NavBar!
    
    // MARK: - Properties
    private let dp = DisposeBag()
    let photos = BehaviorSubject<[UIImage]>(value: [UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!])
    
    let ads = BehaviorSubject<[UIImage]>(value: [UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!])
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViews()
        getCustomers()
    }
    
    
    // MARK: - Functions



    func getCustomers() {
        getApi(apiRouter: .getAllCustomers)
      //      .trackActivity(isLoading)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(value: let response):
                        print(response)
                    default:
                        print("EROOOOR")
//                    case .internetFailure(let error):
//                        self.Internetmsg.accept(error.message)
//
//                    case .failure(let error):
//                        self.msg.accept(error.message)
                    }
                default:
                    break
                }
            }.disposed(by: dp)
    }
    private func configureCollectionViews(){
        
        brandsCollectionView.register(UINib(nibName: String(describing: advertiseCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: advertiseCollectionViewCell.self))
        adsCollectionView.register(UINib(nibName: String(describing: advertiseCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: advertiseCollectionViewCell.self))
        
        // brandsCollectionView.rx.didScroll.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: adsCollectionView.frame.width - 40, height: 200.0)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        adsCollectionView.collectionViewLayout = layout
        
        brandsCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        brandsCollectionView.collectionViewLayout = generateLayout()
        photos.asDriver(onErrorJustReturn: [])
            .drive( brandsCollectionView.rx.items(cellIdentifier: String(describing: advertiseCollectionViewCell.self)  ) ){( row, model, cell) in
                
            }.disposed(by: dp)
        
        adsCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        ads.asDriver(onErrorJustReturn: [])
            .drive( adsCollectionView.rx.items(cellIdentifier: String(describing: advertiseCollectionViewCell.self)  ) ){( row, model, cell) in
                
            }.disposed(by: dp)
        
        
        scrollView.rx.didScroll.asObservable().bind {[weak self] () in
            guard let self = self else {return}
            let yTranslation = self.scrollView.panGestureRecognizer.translation(in: self.scrollView.superview).y
            
            if yTranslation > 0 {
                print("down")
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.navBar.isHidden = false
                    self.view.layoutIfNeeded()
                })               } else if yTranslation < 0 {
                    print("up")
                    UIView.animate(withDuration: 0.2, animations: { () -> Void in
                        self.navBar.isHidden = true
                        self.view.layoutIfNeeded()
                    })                } else {
                    print("no scroll")
                }
        }.disposed(by: dp)
        
        
    }
    
    
    private func generateLayout() -> UICollectionViewLayout {
        // We have three row styles
        // Style 1: 'Full'
        // A full width photo
        // Style 2: 'Main with pair'
        // A 2/3 width photo with two 1/3 width photos stacked vertically
        // Style 3: 'Triplet'
        // Three 1/3 width photos stacked horizontally
        
        // Full
        let fullPhotoItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/3)),
            supplementaryItems: [])
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Main with pair
        let mainItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1.0)))
        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let pairItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)))
        pairItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)),
            subitem: pairItem,
            count: 2)
        
        let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
            subitems: [mainItem, trailingGroup])
        
        // Triplet
        let tripletItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)))
        tripletItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let tripletGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/9)),
            subitems: [tripletItem, tripletItem, tripletItem])
        
        // Reversed main with pair
        let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
            subitems: [trailingGroup, mainItem])
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(16/9)),
            subitems: [fullPhotoItem, mainWithPairGroup, tripletGroup, mainWithPairReversedGroup])
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}
