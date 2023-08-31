//
//  ChapterCheckInViewModel.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/8/22.
//

import Foundation
import Combine

enum CheckInState {
    case successful
    case failed(error: Error)
    case na
}

protocol ChapterCheckInViewModel {
    func checkIn()
    var hasError: Bool { get }
    var service: CheckInService { get }
    var state: CheckInState { get }
    var submissionDetails: CheckInDetails { get }
    init(service: CheckInService)
}

final class ChapterCheckInViewModelImpl: ObservableObject, ChapterCheckInViewModel {
    
    
    @Published var hasError: Bool = false
    @Published var state: CheckInState = .na
    @Published var submissionDetails: CheckInDetails = CheckInDetails.new
    
    let service: CheckInService
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: CheckInService) {
        self.service = service
        setupErrorSubscriptions()
    }
    
    func checkIn() {
        service
            .checkIn(with: submissionDetails)
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

private extension ChapterCheckInViewModelImpl {
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


