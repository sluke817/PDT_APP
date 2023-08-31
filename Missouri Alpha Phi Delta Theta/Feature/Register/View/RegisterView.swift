//
//  RegisterView.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/2/22.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var vm = RegistrationViewModelImpl(service: RegistrationServiceImpl())
    
    var body: some View {
        
        
        NavigationView {
            
            VStack(spacing: 16) {
                VStack(spacing: 16) {
 
                    InputTextFieldView(text: $vm.userDetails.firstName,
                                       placeholder: "First Name",
                                       keyboardType: .default,
                                       sfSymbol: nil
                    )
                    InputTextFieldView(text: $vm.userDetails.lastName,
                                       placeholder: "Last Name",
                                       keyboardType: .default,
                                       sfSymbol: nil
                    )
                    InputTextFieldView(text: $vm.userDetails.studentNumber,
                                       placeholder: "Student Number",
                                       keyboardType: .phonePad,
                                       sfSymbol: nil
                    )
                    InputTextFieldView(text: $vm.userDetails.email,
                                       placeholder: "Email",
                                       keyboardType: .emailAddress,
                                       sfSymbol: "envelope"
                    )
                    InputPasswordView(password: $vm.userDetails.password,
                                      placeholder: "Password",
                                      sfSymbol: "lock"
                    )
                    
                    
                }
                ButtonView(title: "Register") {
                    vm.register()
                }
                
            }
            .padding(.horizontal, 15)
            .navigationTitle("Register")
            .applyClose()
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
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
