//
//  WishListViewModelType.swift
//  BetterBuy
//
//  Created by user222682 on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

protocol WishListViewModelType : AnyObject {
    var coordinator: Coordinator! {get}
    var orders : [Order] {get}

}
