//
//  SmallButtonView.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/3/22.
//

import SwiftUI

struct SmallButtonView: View {
    
    let title: String
    let background: Color
    let foreground: Color
    let border: Color
    let destination: URL
    
    
    internal init(title: String,
                  background: Color = .white,
                  foreground: Color = .blue,
                  border: Color = .clear,
                  destination: URL) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.border = border
        self.destination = destination
    }
    
    private let cornerRadius: CGFloat = 10
    
    
    var body: some View {
        Link(destination: destination, label: {
            Text(title)
                .frame(maxWidth: 150, maxHeight: 40)
        })
        .background(background)
        .foregroundColor(foreground)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(border, lineWidth: 2)
        )
    }
}

struct SmallButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SmallButtonView(title: "Login", destination: URL(string:"https://apple.com")!)
            .preview(with: "button")
    }
}
