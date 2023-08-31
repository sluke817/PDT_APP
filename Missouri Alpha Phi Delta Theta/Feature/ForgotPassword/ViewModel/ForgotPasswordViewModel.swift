//
//  ForgotPasswordViewModel.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/3/22.
//
import Combine
import Foundation

enum ForgotPasswordState {
    case successful
    case failed(error: Error)
    case na
}


protocol ForgotPasswordViewModel {
    func sendPasswordReset()
    var service: ForgotPasswordService{ get }
    var state: ForgotPasswordState { get }
    var email: String { get }
    var hasError: Bool { get }
    init(service: ForgotPasswordService)
}

final class ForgotPasswordViewModelImpl: ObservableObject, ForgotPasswordViewModel {
    
    @Published var email: String = ""
    @Published var hasError: Bool = false
    @Published var state: ForgotPasswordState = .na
    
    let service: ForgotPasswordService
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: ForgotPasswordService) {
        self.service = service
    }
    
    func sendPasswordReset() {
        
        service
            .sendPasswordReset(to: email)
            .sink { res in
                switch res {
                case .failure(let err):
                    print("Failed: \(err)")
                default: break
                }
            } receiveValue: {
                print("Sent Password Reset Request")
            }
            .store(in: &subscriptions)
    }
}

private extension ForgotPasswordViewModelImpl {
    func setupErrorSubscriptions() {
        $state
            .map { state -> Bool in
                switch state {
                case .successful,
                        .na:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}
