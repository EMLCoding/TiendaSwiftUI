//
//  SharedDataVM.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 24/6/22.
//

import SwiftUI

final class SharedDataVM: ObservableObject {
    @Published var detailProduct: Product?
    @Published var showDetailProduct = false
    
    @Published var fromSearchPage = false
    
    @Published var likedProducts: [Product] = []
    @Published var cartProducts: [Product] = []
    
    func totalPrice() -> Int {
        var total = 0
        
        cartProducts.forEach { product in
            total += product.price
        }
        
        return total
    }
}
