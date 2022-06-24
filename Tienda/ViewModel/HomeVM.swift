//
//  HomeVM.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 23/6/22.
//

import SwiftUI
import Combine

final class HomeVM: ObservableObject {
    @Published var productType: ProductType = .Wearable
    
    @Published var products: [Product] = [
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: 359, productImage: "AppleWatch6"),
        Product(type: .Wearable, title: "Samsung Watch", subtitle: "Gear: Black", price: 180, productImage: "SamsungWatch"),
        Product(type: .Phones, title: "iPhone 13", subtitle: "A15", price: 700, productImage: "iPhone13"),
        Product(type: .Phones, title: "iPhone 12", subtitle: "A14 - Pink", price: 600, productImage: "iPhone12"),
        Product(type: .Laptops, title: "Macbook Air", subtitle: "M1", price: 1150, productImage: "MacbookAir"),
        Product(type: .Laptops, title: "Macbook Pro", subtitle: "M1", price: 1550, productImage: "MacbookPro"),
        Product(type: .Tablets, title: "iPad", subtitle: "A14", price: 350, productImage: "iPad"),
        Product(type: .Tablets, title: "iPad Pro", subtitle: "M1", price: 950, productImage: "iPadPro")
    ]
    
    @Published var filteredProducts: [Product] = []
    
    @Published var searchText = ""
    @Published var searchActivated = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    @MainActor
    init() {
        Task {
            await filterProductByType()
        }
        
        
        // Esto mismo lo tengo con Async-Await en PillApp
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                } else {
                    self.searchedProducts = nil
                }
            })
    }

    func filterProductByType() async {
            let results = self.products
                .filter { product in
                    return product.type == self.productType
                }
                .prefix(4) // Solo cogera los primeros 4 elementos
            
            self.filteredProducts = results.compactMap({ product in
                return product
            })
    }
    
    func filterProductBySearch(){
        Task {
            let results = self.products
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            self.searchedProducts = results.compactMap({ product in
                return product
            })
        }
    }
    
    @MainActor
    func changeProductType(type: ProductType) {
        self.productType = type
        Task {
            await filterProductByType()
        }
        
    }
}
