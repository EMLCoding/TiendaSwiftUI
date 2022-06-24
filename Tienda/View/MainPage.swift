//
//  MainPage.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 23/6/22.
//

import SwiftUI

struct MainPage: View {
    @StateObject var sharedDataVM = SharedDataVM()
    
    @State var currentTab: Tab = .Home
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                HomeView(animation: animation)
                    .environmentObject(sharedDataVM)
                    .tag(Tab.Home)
                
                LikedPage()
                    .environmentObject(sharedDataVM)
                    .tag(Tab.Liked)
                
                ProfilePage()
                    .tag(Tab.Profile)
                
                CartPage()
                    .environmentObject(sharedDataVM)
                    .tag(Tab.Cart)
            }
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        currentTab = tab
                    } label: {
                        Image(systemName: tab.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .background(
                                Color("Purple")
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("Purple") : .black.opacity(0.3))
                    }

                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
        .background(Color("HomeBG").ignoresSafeArea())
        .overlay(
            ZStack {
                if let product = sharedDataVM.detailProduct, sharedDataVM.showDetailProduct {
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedDataVM)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

enum Tab: String, CaseIterable {
    case Home = "house.fill"
    case Liked = "heart.fill"
    case Profile = "person.crop.circle.fill"
    case Cart = "cart.circle.fill"
    
}
