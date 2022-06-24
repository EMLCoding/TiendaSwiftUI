//
//  ProfilePage.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 23/6/22.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("Mi perfil")
                        .font(.system(size: 28))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15) {
                        Image("profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        Text("Stitch")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Dirección: Hawai")
                                .font(.system(size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        Color.white.cornerRadius(12)
                    )
                    .padding()
                    .padding(.top, 40)
                    
                    CustomNavigationLink(title: "Editar perfil") {
                        Text("Pantalla para editar el perfil")
                            .navigationTitle("Editar perfil")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("HomeBG")
                                    .ignoresSafeArea()
                            )
                    }
                    
                    CustomNavigationLink(title: "Dirección de envío") {
                        Text("Pantalla con la información de la dirección")
                            .navigationTitle("Dirección de envío")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("HomeBG")
                                    .ignoresSafeArea()
                            )
                    }
                    
                    CustomNavigationLink(title: "Histórico de pedidos") {
                        Text("Pantalla con todos los pedidos hechos")
                            .navigationTitle("Histórico de pedidos")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("HomeBG")
                                    .ignoresSafeArea()
                            )
                    }
                    
                    CustomNavigationLink(title: "Tarjetas") {
                        Text("Pantalla de tarjetas")
                            .navigationTitle("Tarjetas")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("HomeBG")
                                    .ignoresSafeArea()
                            )
                    }
                    
                    CustomNavigationLink(title: "Notificaciones") {
                        Text("Pantalla de notificaciones")
                            .navigationTitle("Notificaciones")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(
                                Color("HomeBG")
                                    .ignoresSafeArea()
                            )
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("HomeBG")
                    .ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping () -> Detail) -> some View {
        NavigationLink {
            content()
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white.cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }

    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
