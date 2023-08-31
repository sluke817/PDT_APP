//
//  AccredView.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/10/22.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct AccredView: View {
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    @EnvironmentObject var firebaseDBService: FirebaseDBServiceImpl
    @StateObject private var vm = AccredViewModelImpl(service: AccredServiceImpl())
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        let name = "\(sessionService.userDetails?.firstName ?? "Ed") \(sessionService.userDetails?.lastName ?? "Numbe")"
        let sid = sessionService.userDetails?.studentNumber ?? "12345678"
        
        let array = Array(firebaseDBService.accredEvents)
        
        NavigationView {
            VStack(spacing: 20) {
                Text("Please select the events that you have attended this semester.")
                List(selection: $vm.accredDetails.events) {
                    ForEach(array) { accredEvent in
                        AccredEventRow(accredEvent: accredEvent, selectedEvents: $vm.accredDetails.events)
                    }
                }
                ButtonView(title: "Report Accreditation") {
                    vm.accredDetails.name = name
                    vm.accredDetails.studentNumber = sid
                    vm.reportAccred()
                    vm.accredDetails.events.removeAll()
                    presentationMode.wrappedValue.dismiss()
                }
                .navigationTitle("Selected \(vm.accredDetails.events.count) Events")
                .applyClose()
                .alert(isPresented: $vm.hasError, content: {

                    if case .failed(let error) = vm.state {
                        return Alert(
                            title: Text("Error"),
                            message: Text(error.localizedDescription)
                        )
                    } else {
                        return Alert(
                            title: Text("Error"),
                            message: Text("Something went wrong")
                        )
                    }
                })

            }
            .padding(15)
            .applyClose()
                        
        }
        
    }
}

struct AccredView_Previews: PreviewProvider {
    static var previews: some View {
        AccredView()
            .environmentObject(SessionServiceImpl())
            .environmentObject(FirebaseDBServiceImpl())
    }
}
