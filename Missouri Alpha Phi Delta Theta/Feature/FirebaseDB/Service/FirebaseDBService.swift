//
//  FirebaseDBService.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/7/22.
//

import Foundation
import FirebaseDatabase
import SwiftUI


protocol FirebaseDBService {
    var ref: DatabaseReference { get }
    var links: FirebaseDBLinks { get }
    var wUpdate: String { get }
    var accredEvents: Set<AccredEvent> { get }
}

final class FirebaseDBServiceImpl: ObservableObject, FirebaseDBService {
    
    @Published var ref: DatabaseReference
    @Published var links: FirebaseDBLinks
    @Published var wUpdate: String
    @Published var upcomingEvents: String
    @Published var accredEvents: Set<AccredEvent>
    
    
    init() {
        
        ref = Database.database().reference()
        
        let defaultLink = "https://phideltmizzou.com"
        
        links = FirebaseDBLinks(driveLink: defaultLink,
                                calLink: defaultLink,
                                jbLink: defaultLink,
                                excuseLink: defaultLink,
                                gradeLink: defaultLink,
                                privacyPolicy: defaultLink)
        
        wUpdate = "No new updates for this week."
        
        upcomingEvents = "No upcoming events for this week"
        
        accredEvents = Set<AccredEvent>()
        
        ref.child("links").child("GoogDrive").observe(.value) { snapshot in
            self.links.driveLink = snapshot.value as! String
        }
        
        ref.child("links").child("GoogCal").observe(.value) { snapshot in
            self.links.calLink = snapshot.value as! String
        }
        
        ref.child("links").child("JBoard").observe(.value) { snapshot in
            self.links.jbLink = snapshot.value as! String
        }
        
        ref.child("links").child("Excuse").observe(.value) { snapshot in
            self.links.excuseLink = snapshot.value as! String
        }
        
        ref.child("links").child("GradeChecks").observe(.value) { snapshot in
            self.links.gradeLink = snapshot.value as! String
        }
        
        ref.child("links").child("PrivacyPolicy").observe(.value) { snapshot in
            self.links.privacyPolicy = snapshot.value as! String
        }
        
        ref.child("updates").child("wUpdate").observe(.value) { snapshot in
            self.wUpdate = snapshot.value as! String
        }
        ref.child("updates").child("upcomingEvents").observe(.value) { snapshot in
            self.upcomingEvents = snapshot.value as! String
        }
        
        ref.child("accEvents").observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                let eventName = dataSnapshot.key
                if(eventName.prefix(1) == "_") {
                    self.accredEvents.insert(AccredEvent(id: UUID(), eventName: eventName))
                }
            }
        }
        
    }
    
}





