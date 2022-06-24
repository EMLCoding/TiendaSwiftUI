//
//  LoginVM.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 21/6/22.
//

import SwiftUI

final class LoginVM: ObservableObject {
    @AppStorage("log_Status") var log_Status: Bool = false
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword = false
    
    @Published var registerUser = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword = false
    
    func clearInputs() {
        self.email = ""
        self.password = ""
        self.showPassword = false
        self.reEnterPassword = ""
        self.showReEnterPassword = false
    }
    
    func login() {
        withAnimation {
            log_Status = true
        }
    }
    
    func register() {
        withAnimation {
            log_Status = true
        }
    }
    
    func forgotPassword() {
        
    }
}
