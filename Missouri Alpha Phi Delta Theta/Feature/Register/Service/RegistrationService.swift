//
//  RegistrationService.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/3/22.
//

import Foundation
import Combine
import FirebaseDatabase
import Firebase

enum RegistrationKeys: String {
    case firstName
    case lastName
    case bondNumber
    case studentNumber
    case activeStatus
}

protocol RegistrationService {
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error>
}

final class RegistrationServiceImpl: RegistrationService {
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error> {
        
        Deferred {
            
            Future { promise in
                Auth.auth()
                    .createUser(withEmail: details.email,
                                password: details.password) { res, error in
                        if let err = error {
                            promise(.failure(err))
                        } else {
                            
                            if let uid = res?.user.uid {
                                
                                let values = [RegistrationKeys.firstName.rawValue: details.firstName,
                                              RegistrationKeys.lastName.rawValue: details.lastName,
                                              RegistrationKeys.activeStatus.rawValue: details.activeStatus,
                                              RegistrationKeys.studentNumber.rawValue: details.studentNumber]
                                as [String: Any]
                                
                                
                                
                                Database.database()
                                    .reference()
                                    .child("users")
                                    .child(uid)
                                    .updateChildValues(values) { error, ref in
                                        
                                        if let err = error {
                                            promise(.failure(err))
                                        } else {
                                            promise(.success(()))
                                        }
                                        
                                    }
                                
                            } else {
                                promise(.failure(NSError(domain: "Invalid User ID", code: 0, userInfo: nil)))
                            }
                        }
                    }
                
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
        
    }
}
