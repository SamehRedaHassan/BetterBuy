//
//  APIResult.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/30/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

enum APIResult <Value> {
    
    case success(value: Value)
    
    case failure(error: APICallError)

    case internetFailure(error: APICallError)

    // Remove it if not needed.
    init(_ f: () throws -> Value) {
        do {
            let value = try f()
            self = .success(value: value)
        } catch let error as APICallError {
            self = .failure(error: error)
        } catch  {
            self = .failure(error: APICallError(status: .failed))
        }
    }
}
