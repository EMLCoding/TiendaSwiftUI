//
//  ContentView.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 21/6/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var log_Status: Bool = false
    var body: some View {
        if log_Status {
            MainPage()
        } else {
            OnBoardingPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
