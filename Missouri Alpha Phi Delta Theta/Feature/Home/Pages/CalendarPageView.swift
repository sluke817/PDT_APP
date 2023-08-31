//
//  CalendarPageView.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/10/22.
//

import SwiftUI
import SwiftHtml
import Darwin
import WebKit


struct CalendarPageView: View {
    
    @EnvironmentObject var firebaseDBService: FirebaseDBServiceImpl
    
    
    var body: some View {
            
            
            VStack(spacing: 16) {
                
                VStack (alignment: .center) {
                    Text("Upcoming Events:")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold))
                
                    Text(firebaseDBService.upcomingEvents)
                        .foregroundColor(.white)
                        .font(.system(size: 16))

                }
                .frame(maxWidth: 300, maxHeight: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 2)
                )
                
                Spacer()
                
                WebView()
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(.white, lineWidth: 2)
                    )
                
                Spacer()
                
                
            }
            .padding(15)
    }
}

struct CalendarPageView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPageView()
    }
}


struct WebView: UIViewRepresentable {
    
    @EnvironmentObject var firebaseDBService: FirebaseDBServiceImpl

    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WebView.UIViewType {
            WKWebView(frame: .zero)
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        let request = URLRequest(url: URL(string: firebaseDBService.links.calLink)!)
        uiView.load(request)
    }
}
