//
//  PhotoCheckInView.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/8/22.
//

import SwiftUI



struct ChapterCheckInView: View {
    
    @State var changedImage = false
    @State var openCameraRoll = false
    @State var showSuccess = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var vm = ChapterCheckInViewModelImpl(service: CheckInServiceImpl())
    
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    var body: some View {
        
        
        NavigationView {
            
            VStack(spacing: 16) {
                VStack(spacing: 16) {
                    
                    ZStack(alignment: .bottomTrailing) {
                        
                        Button(action: {
                            
                            changedImage = true
                            openCameraRoll = true
                            
                        }, label: {
                            
                            if changedImage {
                                Image(uiImage: vm.submissionDetails.image)
                                    .resizable()
                                    .frame(width: 200, height: 200, alignment: .center)
                                    .cornerRadius(20)
                            } else {
                                Image("placeholder-image-icon-19")
                                    .resizable()
                                    .frame(width: 200, height: 200, alignment: .center)
                                    .cornerRadius(20)
                            }
                        })
                        Image(systemName: "plus")
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .clipShape(Circle())
                    }.sheet(isPresented: $openCameraRoll) {
                        ImagePickerService(selectedImage: $vm.submissionDetails.image, sourceType: .camera)
                        }
                    
//                    InputTextFieldView(text: $vm.submissionDetails.firstName,
//                                       placeholder: "First Name",
//                                       keyboardType: .namePhonePad,
//                                       sfSymbol: nil
//                    )
//                    InputTextFieldView(text: $vm.submissionDetails.lastName,
//                                       placeholder: "Last Name",
//                                       keyboardType: .namePhonePad,
//                                       sfSymbol: nil
//                    )

                        
                    ButtonView(title: "Upload") {
                        vm.submissionDetails.firstName = sessionService.userDetails?.firstName ?? "Ed"
                        vm.submissionDetails.lastName = sessionService.userDetails?.lastName ?? "Numbe"
                        
                        vm.checkIn()
                        
                        showSuccess.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }
                
                }
                if showSuccess {
                    if changedImage {
                        Text("Success! You can close this frame now.")
                            .foregroundColor(.green)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Chapter Check In")
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
    }
}

struct ChapterCheckInView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterCheckInView()
            .environmentObject(SessionServiceImpl())
    }
}

