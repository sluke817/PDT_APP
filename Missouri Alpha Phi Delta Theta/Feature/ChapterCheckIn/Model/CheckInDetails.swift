//
//  SubmissionDetails.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/8/22.
//

import Foundation
import UIKit


struct CheckInDetails {
    var firstName: String
    var lastName: String
    var studentNumber: String
    var image: UIImage
}

extension CheckInDetails {
    
    static var new: CheckInDetails {
        CheckInDetails(firstName: "", lastName: "", studentNumber: "", image: UIImage())
    }
}
