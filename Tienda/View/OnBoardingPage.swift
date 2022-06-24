//
//  OnBoardingPage.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 21/6/22.
//

import SwiftUI

struct OnBoardingPage: View {
    @State var showLoginPage = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Encuentra tu\nGadget")
                .font(.system(size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            Text("Insertar imagen aqui")
            Spacer()
            
            Button {
                withAnimation {
                    showLoginPage.toggle()
                }
            } label: {
                Text("Vamos a empezar")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("Purple"))
            }
            .padding(.horizontal, 30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("Purple")
        )
        .overlay(
            Group {
                if showLoginPage {
                    LoginView()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
