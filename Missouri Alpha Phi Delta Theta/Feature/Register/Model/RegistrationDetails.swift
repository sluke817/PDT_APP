//
//  RegistrationDetails.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/3/22.
//

import Foundation

struct RegistrationDetails {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var studentNumber: String
    var activeStatus: String
}


extension RegistrationDetails {
    
    static var new: RegistrationDetails {
        RegistrationDetails(email: "",
                            password: "",
                            firstName: "",
                            lastName: "",
                            studentNumber: "",
                            activeStatus: "inactive")
    }
}
