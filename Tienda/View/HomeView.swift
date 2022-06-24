//
//  HomeView.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 23/6/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var sharedDataVM: SharedDataVM
    
    @StateObject var homeVM = HomeVM()
    
    var animation: Namespace.ID
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                ZStack {
                    if homeVM.searchActivated {
                        SearchBar()
                    } else {
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        homeVM.searchActivated = true
                    }
                }
                
                Text("Pedir online\nRecoger en tienda")
                    .font(.system(size: 28)).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(ProductType.allCases, id: \.self) { type in
                            ProductTypeView(type: type)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .padding(.top, 28)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 25) {
                        ForEach(homeVM.filteredProducts) { product in
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                .padding(.top, 30)
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            ZStack {
                if homeVM.searchActivated {
                    SearchView(animation: animation)
                        .environmentObject(homeVM)
                }
            }
        )
    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            ZStack {
                if sharedDataVM.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .scaledToFit()
                        .opacity(0)
                } else {
                    Image(product.productImage)
                        .resizable()
                        .scaledToFit()
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
                .offset(y: -80)
                .padding(.bottom, -80)
            
            Text(product.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.system(size: 14))
                .foregroundColor(.white)
            
            Text("\(product.price)€")
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("Purple"))
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .background(
            Color("Purple").opacity(0.3).cornerRadius(25)
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedDataVM.detailProduct = product
                sharedDataVM.showDetailProduct = true
            }
        }
    }
    
    @ViewBuilder
    func SearchBar() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            Capsule()
                .strokeBorder(.gray, lineWidth: 0.8)
        )
    }
    
    @ViewBuilder
    func ProductTypeView(type: ProductType) -> some View {
        Button {
            withAnimation {
                homeVM.changeProductType(type: type)
            }
        } label: {
            Text(type.rawValue)
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(homeVM.productType == type ? Color("Purple") : .gray)
                .padding(.bottom, 10)
                .overlay(
                    ZStack {
                        if homeVM.productType == type {
                            Capsule()
                                .fill(Color("Purple"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        } else {
                            // Aunque no se ve se hace para que se note el efecto de desplazamiento gracias al Namespace con ID Producttab
                            Capsule()
                                .fill(.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    , alignment: .bottom
                )
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
