//
//  AccredViewModel.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/10/22.
//

import Foundation
import Combine


enum AccredState {
    case successful
    case failed(error: Error)
    case na
}

protocol AccredViewModel {
    func reportAccred()
    var hasError: Bool { get }
    var service: AccredService { get }
    var state: AccredState { get }
    var accredDetails: AccredDetails { get }
    init(service: AccredService)
}

final class AccredViewModelImpl: ObservableObject, AccredViewModel {
    
    @Published var hasError: Bool = false
    @Published var state: AccredState = .na
    @Published var accredDetails: AccredDetails = AccredDetails.new
    
    let service: AccredService
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: AccredService) {
        self.service = service
        setupErrorSubscriptions()
    }
    
    func reportAccred() {
        service
            .reportAccred(with: accredDetails)
            .sink { [weak self] res in
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
                
            } receiveValue: { [weak self] in
                self?.state = .successful
            }
            .store(in: &subscriptions)
    }
}

private extension AccredViewModelImpl {
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
