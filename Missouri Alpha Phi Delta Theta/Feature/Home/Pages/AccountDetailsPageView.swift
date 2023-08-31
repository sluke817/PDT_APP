//
//  AccountDetailsView.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/10/22.
//

import SwiftUI

struct AccountDetailsPageView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    @EnvironmentObject var firebaseDBService: FirebaseDBServiceImpl
    
    var body: some View {
        
        let firstName = sessionService.userDetails?.firstName ?? "Ed"
        let lastName = sessionService.userDetails?.lastName ?? "Numbe"
        let studentNumber = sessionService.userDetails?.studentNumber ?? "123456789"
                
        VStack {
            Spacer()
            Text("Account Details")
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .bold))
            VStack(alignment: .leading, spacing: 10){
                HStack(alignment: .top) {
                    Text("Name:")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                    Text("\(firstName) \(lastName)")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                HStack(alignment: .top) {
                    Text("Student Number:")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                    Text(studentNumber)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }
            .frame(minWidth: 320, maxHeight: 150)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 2)
            )
            
            SmallButtonView(title: "Privacy Policy", destination: URL(string: firebaseDBService.links.privacyPolicy)!)
            
            Spacer()
            
            ButtonView(title: "Logout",
                       background: .clear,
                       foreground: .white,
                       border: .white) {
                sessionService.logout()
            }
        }
        .padding(15)
        
    }
}

struct AccountDetailsPageView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailsPageView()
            .environmentObject(SessionServiceImpl())
            .environmentObject(FirebaseDBServiceImpl())
    }
}
