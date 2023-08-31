//
//  AccredDetails.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/10/22.
//

import Foundation


struct AccredDetails {
    var studentNumber: String
    var name: String
    var events: Set<AccredEvent>
}

extension AccredDetails {
    static var new: AccredDetails {
        AccredDetails(studentNumber: "", name: "", events: Set<AccredEvent>())
    }
}

struct AccredEvent: Identifiable, Hashable {
    let id: UUID
    let eventName: String
}
