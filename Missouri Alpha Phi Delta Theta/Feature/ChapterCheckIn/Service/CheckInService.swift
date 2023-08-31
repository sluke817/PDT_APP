//
//  CheckInService.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/8/22.
//

import Foundation
import Firebase
import Combine
import FirebaseStorage
import FirebaseDatabase

protocol CheckInService {
    func checkIn(with details: CheckInDetails) -> AnyPublisher<Void, Error>
}

final class CheckInServiceImpl: CheckInService {
    func checkIn(with details: CheckInDetails) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                
                let path = details.lastName + "_" + details.firstName
                guard let imageData = details.image.jpegData(compressionQuality: 0.5) else { return
                }
                
                Storage
                    .storage()
                    .reference()
                    .child(path)
                    .putData(imageData, metadata: nil) { metedata, error in
                        if let err = error {
                            promise(.failure(err))
                        } else {
                            promise(.success(()))
                        }
                        
                    }
                
//                let date = Date()
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "dd/MM/yyyy"
//                print(dateFormatter.string(from: date))
//
//                let name = "\(details.firstName) \(details.lastName)"
//
//                Database
//                    .database()
//                    .reference()
//                    .child("ChapterCheckIn")
//                    .child(dateFormatter.string(from: date))
//                    .child(details.studentNumber)
//                    .setValue(name) { (error: Error?, ref: DatabaseReference) in
//                        if let error = error {
//                            promise(.failure(error))
//                        } else {
//                            promise(.success(()))
//                        }
//                    }

                           
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
