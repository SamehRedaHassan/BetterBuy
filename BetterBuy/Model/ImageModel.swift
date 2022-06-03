//
//  ImageModel.swift
//  BetterBuy
//
//  Created by user222682 on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

// MARK: - Image
struct ImageModel: Codable {
    let src: String

    enum CodingKeys: String, CodingKey {
        case  src
    }
}
