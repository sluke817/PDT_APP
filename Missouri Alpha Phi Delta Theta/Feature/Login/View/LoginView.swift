//
//  LoginView.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/2/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    
    @StateObject private var vm = LoginViewModelImpl(service: LoginServiceImpl())
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 16) {
            if colorScheme == .light {
                Image("logo-8")
                    .resizable()
                    .scaledToFit()
            } else {
                Image("pdt logo")
                    .resizable()
                    .scaledToFit()
            }
            
            VStack(spacing: 16) {
                InputTextFieldView(text: $vm.credentials.email,
                                   placeholder: "Email",
                                   keyboardType: .emailAddress,
                                   sfSymbol: "person"
                )
                InputPasswordView(password: $vm.credentials.password,
                                  placeholder: "Password",
                                  sfSymbol: "lock"
                )
            }
            HStack {
                Spacer()
                Button(action: {
                    showForgotPassword.toggle()
                }, label: {
                    Text("Forgot Password?")
                       
                })
                .font(.system(size: 16, weight: .bold))
                .sheet(isPresented: $showForgotPassword, content: {
                    ForgotPasswordView()
                })
            }
            VStack(spacing: 16) {
                ButtonView(title: "Login") {
                    vm.login()
                }
                ButtonView(title: "Register",
                           background: .clear,
                           foreground: .blue,
                           border: .blue) {
                    showRegistration.toggle()
                }
               .sheet(isPresented: $showRegistration, content: {
                   RegisterView()
               })
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Login")
        .alert(isPresented: $vm.hasError, content: {
            
            if case .failed(let error) = vm.state {
                return Alert(
                    title: Text("Error"),
                    message: Text(error.localizedDescription)
                )
            } else {
                return Alert(
                    title: Text("Error"),
                    message: Text("Something went wrong")
                )
            }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}

