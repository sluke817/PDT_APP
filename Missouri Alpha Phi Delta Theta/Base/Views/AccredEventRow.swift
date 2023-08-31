//
//  AccredEventRow.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/10/22.
//

import SwiftUI

struct AccredEventRow: View {
    
    var accredEvent: AccredEvent
    @Binding var selectedEvents: Set<AccredEvent>
    
    var isSelected: Bool {
        selectedEvents.contains(accredEvent)
    }
    
    var body: some View {
        HStack {
            Text(accredEvent.eventName.dropFirst())
            Spacer()
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.accentColor)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if isSelected {
                self.selectedEvents.remove(accredEvent)
            }
            else {
                self.selectedEvents.insert(accredEvent)
            }
        }
    }
}

struct AccredEventRow_Previews: PreviewProvider {
    static var previews: some View {
        let accredEvent = AccredEvent(id: UUID(), eventName: "test")
        AccredEventRow(accredEvent: accredEvent, selectedEvents: .constant([accredEvent]))
    }
}
