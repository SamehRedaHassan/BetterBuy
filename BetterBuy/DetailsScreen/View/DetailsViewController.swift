//
//  DetailsViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/27/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //OutLets
    @IBOutlet weak var productImgsCollectionView: UICollectionView!
    
    @IBOutlet weak var productSizesCollectionView: UICollectionView!
    
    //MARK: variables
    var viewModel : DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel?.product.title ?? "product not found")
        

    }
    

    func setCollectionDelegates(){
        
    }



}

extension DetailsViewController{
    
}
