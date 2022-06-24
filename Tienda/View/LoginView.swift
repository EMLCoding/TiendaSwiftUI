//
//  LoginView.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 21/6/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginVM = LoginVM()
    var body: some View {
        VStack {
            Text("Welcome\nback")
                .font(.system(size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
                .background(
                    ZStack {
                        LinearGradient(colors: [
                            Color("LoginCircle"),
                            Color("LoginCircle")
                                .opacity(0.8),
                            Color("Purple")
                        ], startPoint: .top, endPoint: .bottom)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing)
                        .offset(y: -25)
                        .ignoresSafeArea()
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(30)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.leading, 30)
                    }
                )
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    Text(loginVM.registerUser ? "Register" : "Login")
                        .font(.system(size: 22))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTextField(icon: "mail", title: "Email", hint: "example@gmail.com", value: $loginVM.email, showPassword: .constant(false))
                        .padding(.top, 25)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "12345678", value: $loginVM.password, showPassword: $loginVM.showPassword)
                        .padding(.top, 10)
                    
                    if loginVM.registerUser {
                        CustomTextField(icon: "lock", title: "Re-Enter Password", hint: "12345678", value: $loginVM.reEnterPassword, showPassword: $loginVM.showReEnterPassword)
                            .padding(.top, 10)
                    }
                    
                    Button {
                        loginVM.forgotPassword()
                    } label: {
                        Text("¿Has olvidado la contraseña?")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        if loginVM.registerUser {
                            loginVM.register()
                        } else {
                            loginVM.login()
                        }
                    } label: {
                        Text("Iniciar sesión")
                            .font(.system(size: 17))
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Purple"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    Button {
                        withAnimation {
                            loginVM.registerUser.toggle()
                        }
                    } label: {
                        Text(loginVM.registerUser ? "Iniciar sesión" : "Crear cuenta")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Purple"))
        // Se limpian los campos al pasar de login a registro y viceversa
        .onChange(of: loginVM.registerUser) { newValue in
            loginVM.clearInputs()
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
                    .font(.system(size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        .overlay(
            Group {
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Ocultar" : "Mostrar")
                            .font(.system(size: 13))
                            .fontWeight(.bold)
                            .foregroundColor(Color("Purple"))
                    })
                    .offset(y: 8)
                }
            }
            , alignment: .trailing
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
