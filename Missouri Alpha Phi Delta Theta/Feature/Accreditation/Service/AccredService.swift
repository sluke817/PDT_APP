//
//  AccredService.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/10/22.
//

import Foundation
import Firebase
import FirebaseDatabase
import Combine


protocol AccredService {
    func reportAccred(with details: AccredDetails) -> AnyPublisher<Void, Error>
}

final class AccredServiceImpl: AccredService {
    
    func reportAccred(with details: AccredDetails) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                
                for event in details.events {
                    
                    Database
                        .database()
                        .reference()
                        .child("accEvents")
                        .child(event.eventName)
                        .child(details.studentNumber)
                        .setValue(details.name) { (error: Error?, ref: DatabaseReference) in
                            if let error = error {
                                promise(.failure(error))
                            } else {
                                promise(.success(()))
                            }
                        }
                }
                
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}

