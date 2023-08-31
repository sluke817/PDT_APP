//
//  ContentView.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/2/22.
//

import SwiftUI
import FirebaseDatabase
import Firebase

struct HomeView: View {
    
    let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    
    let pages: [String] = ["Home", "Calendar", "AD"]
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    @EnvironmentObject var firebaseDBService: FirebaseDBServiceImpl
    
    @State private var selection = 2

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, skyBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            TabView(selection: $selection) {
                
                AccountDetailsPageView()
                    .environmentObject(sessionService)
                    .environmentObject(firebaseDBService)
                    .tag(1)
                MainPageView()
                    .environmentObject(sessionService)
                    .environmentObject(firebaseDBService)
                    .tag(2)
                CalendarPageView()
                    .environmentObject(firebaseDBService)
                    .tag(3)
                
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
                
        }
        .navigationBarHidden(true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(SessionServiceImpl())
                .environmentObject(FirebaseDBServiceImpl())
        }
    }
}

