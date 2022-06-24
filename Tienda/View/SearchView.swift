//
//  SearchView.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 23/6/22.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var sharedDataVM: SharedDataVM
    @EnvironmentObject var homeVM: HomeVM
    @FocusState var startTF: Bool
    
    var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                Button {
                    withAnimation {
                        homeVM.searchActivated = false
                    }
                    homeVM.searchText = ""
                    sharedDataVM.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.7))
                }
                
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $homeVM.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color("Purple"), lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 10)
            
            if let products = homeVM.searchedProducts {
                if products.isEmpty {
                    VStack {
                        Text("Elementos no encontrados")
                            .font(.title)
                            .bold()
                        
                        Text("Prueba a buscar un término más genérico o busca productos alternativos.")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            Text("Encontrados \(products.count) resultados")
                                .font(.system(size: 24))
                                .bold()
                                .padding(.vertical)
                            
                            StaggeredGrid(list: products, showIndicators: false, columns: 2) { product in
                                ProductCardView(product: product)
                            }
                        }
                        .padding()
                    }
                }
            } else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeVM.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("HomeBG").ignoresSafeArea()
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
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
                .offset(y: -50)
                .padding(.bottom, -50)
            
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
        .padding(.top, 50)
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedDataVM.fromSearchPage = true
                sharedDataVM.detailProduct = product
                sharedDataVM.showDetailProduct = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
