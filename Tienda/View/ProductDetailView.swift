//
//  ProductDetailView.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 24/6/22.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var sharedDataVM: SharedDataVM
    @EnvironmentObject var homeVM: HomeVM
    var product: Product
    var animation: Namespace.ID
    
    var body: some View {
        // Los zIndex para que la animacion de la imagen del producto quede del todo bien
        VStack {
            VStack {
                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            sharedDataVM.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red : Color.black.opacity(0.7))
                    }

                }
                .padding()
                
                Image(product.productImage)
                    .resizable()
                    .scaledToFit()
                    .matchedGeometryEffect(id: "\(product.id)\(sharedDataVM.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    Text(product.title)
                        .font(.system(size: 20))
                        .bold()
                    
                    Text(product.subtitle)
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Obtén un año de Apple TV+ Gratis")
                        .font(.system(size: 16))
                        .bold()
                        .padding(.top)
                    
                    Button {
                        
                    } label: {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Descripción")
                        }
                        .font(.system(size: 15).bold())
                        .foregroundColor(Color("Purple"))
                    }
                    
                    HStack {
                        Text("Total")
                            .font(.system(size: 17))
                        
                        Spacer()
                        
                        Text("\(product.price)€")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.vertical, 20)
                    
                    Button {
                        addToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "Añadido" : "Añadir") al carrito")
                            .font(.system(size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color("Purple")
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }

                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedDataVM.likedProducts)
        .animation(.easeInOut, value: sharedDataVM.cartProducts)
        .background(Color("HomeBG").ignoresSafeArea())
    }
    
    func addToLiked() {
        if let index = sharedDataVM.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }) {
            sharedDataVM.likedProducts.remove(at: index)
        } else {
            sharedDataVM.likedProducts.append(product)
        }
    }
    
    func addToCart() {
        if let index = sharedDataVM.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }) {
            sharedDataVM.cartProducts.remove(at: index)
        } else {
            sharedDataVM.cartProducts.append(product)
        }
    }
    
    func isLiked() -> Bool {
        return sharedDataVM.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart() -> Bool {
        return sharedDataVM.cartProducts.contains { product in
            return self.product.id == product.id
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ProductDetailView(product: HomeVM().products[0])
//            .environmentObject(SharedDataVM())
        MainPage()
    }
}
