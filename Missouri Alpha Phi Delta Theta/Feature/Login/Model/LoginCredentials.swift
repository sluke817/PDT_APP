//
//  LoginCredentials.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/3/22.
//

import Foundation

struct LoginCredentials {
    var email: String
    var password: String
}

extension LoginCredentials {
    
    static var new: LoginCredentials {
        LoginCredentials(email: "", password: "")
    }
}
