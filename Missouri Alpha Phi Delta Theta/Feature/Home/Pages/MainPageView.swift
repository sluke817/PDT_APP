//
//  MainPage.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/10/22.
//

import SwiftUI

struct MainPageView: View {
    
    
    @State private var showCheckIn = false
    @State private var showAccred = false
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    @EnvironmentObject var firebaseDBService: FirebaseDBServiceImpl
    
    
    var body: some View {
        
//        let firstName = sessionService.userDetails?.firstName ?? "Ed Numbe"
        
        VStack(spacing: 10) {
            
            Image("pdt logo")
                .resizable()
                .scaledToFit()
                .border(.clear)
            
            Spacer()
            
//            Text("Welcome, \(firstName)")
//                .font(.system(size: 24, weight: .bold))
//
//            Spacer()
            
            VStack (alignment: .center) {
                Text("Announcements:")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .bold))
            
                Text(firebaseDBService.wUpdate)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                    .padding(5)

            }
            .frame(maxWidth: 300, maxHeight: 150)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 2)
            )

            Spacer()
            HStack {
                SmallButtonView(title: "Google Drive", destination: URL(string: firebaseDBService.links.driveLink)!)
                SmallButtonView(title: "J-Board Form", destination: URL(string: firebaseDBService.links.jbLink )!)
                
            }
            HStack {
                
                SmallButtonView(title: "Excuse Form", destination: URL(string: firebaseDBService.links.excuseLink )!)
                SmallButtonView(title: "Grade Checks", destination: URL(string: firebaseDBService.links.gradeLink )!)
            }
            VStack {
                
//                Button(
//                    action: {
//                        showAccred.toggle()
//                    }, label: {
//                    Text("Accreditation")
//                        .frame(maxWidth: 250, maxHeight: 50)
//                })
//                .background(Color.white)
//                .foregroundColor(Color.blue)
//                .font(.system(size: 16, weight: .bold))
//                .cornerRadius(10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(.white, lineWidth: 2)
//                )
//                .sheet(isPresented: $showAccred, content: {
//                    AccredView()
//                        .environmentObject(sessionService)
//                        .environmentObject(firebaseDBService)
//                })
                
                
                Button(
                    action: {
                        showCheckIn.toggle()
                    }, label: {
                    Text("Chapter Check In")
                        .frame(maxWidth: 250, maxHeight: 50)
                })
                .background(Color.white)
                .foregroundColor(Color.blue)
                .font(.system(size: 16, weight: .bold))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 2)
                )
                .sheet(isPresented: $showCheckIn, content: {
                    ChapterCheckInView()
                        .environmentObject(sessionService)
                })
                
                
            }
            
            Spacer()
            
        }
        .padding(15)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
            .environmentObject(SessionServiceImpl())
            .environmentObject(FirebaseDBServiceImpl())
    }
}
