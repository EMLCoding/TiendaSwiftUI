//
//  Product.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 23/6/22.
//

import SwiftUI

enum ProductType: String, CaseIterable {
case Wearable = "Wearable"
    case Laptops = "Laptops"
    case Phones = "Phones"
    case Tablets = "Tablets"
}

struct Product: Identifiable, Hashable {
    let id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var price: Int
    var productImage: String
}
