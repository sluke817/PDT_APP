//
//  InActiveView.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/10/22.
//

import SwiftUI

struct InActiveView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    

    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Please wait for the secretary to approve your account.")
                .font(.system(size: 20, weight: .bold))
            ButtonView(title: "Logout") {
                sessionService.logout()
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Awaiting Approval")
    }
    
}

struct InActiveView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InActiveView()
                .environmentObject(SessionServiceImpl())
        }
    }
}
