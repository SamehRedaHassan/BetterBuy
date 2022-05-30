//
//  HomeViewController.swift
//  BetterBuy
//
//  Created by user222682 on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var adsCollectionView: UICollectionView!
    @IBOutlet private weak var brandsCollectionView: UICollectionView!
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    let photos = BehaviorSubject<[UIImage]>(value: [UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!,UIImage(named: "adidas")!])
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViews()
    }

    // MARK: - Functions
    private func configureCollectionViews(){
        brandsCollectionView.register(UINib(nibName: String(describing: advertiseCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: advertiseCollectionViewCell.self))
       // brandsCollectionView.rx.didScroll.
        
        
        brandsCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        brandsCollectionView.collectionViewLayout = generateLayout()
        photos.subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background)).asDriver(onErrorJustReturn: [])
         .drive( brandsCollectionView.rx.items(cellIdentifier: String(describing: advertiseCollectionViewCell.self)  ) ){( row, model, cell) in

         }.disposed(by: disposeBag)
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
