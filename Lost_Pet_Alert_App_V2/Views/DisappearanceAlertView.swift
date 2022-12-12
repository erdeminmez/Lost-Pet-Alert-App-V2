//
//  DisappearanceAlertView.swift
//  Lost_Pet_Alert_App_V2
//
//  Created by Erdem Inmez on 2022-12-09.
//

import SwiftUI

struct DisappearanceAlertView: View {
    
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @Environment(\.dismiss) private var dismiss

    
    enum PetType: String, CaseIterable, Identifiable {
        case dog, cat
        var id: Self { self }
    }
    
    @State private var petType : PetType = PetType.dog
    @State private var petKind : String = ""
    @State private var petColor : String = ""
    @State private var petDescription : String = ""
    
    @State private var dspTime : Date = Date.now
    @State private var dspStreet : String = ""
    @State private var dspCity : String = ""
    @State private var dspCountry : String = ""
    
    @State private var contactName : String = ""
    @State private var contactNumber : String = ""
    
    @State private var showAlert : Bool = false
    @State private var alertMessage : String = ""
    @State private var alertTitle : String = "Invalid Entry"
    @State private var validityKey : Bool = true
    
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2022, month: 1, day: 1)
        let endComponents = DateComponents(year: 2022, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    var body: some View {
        Form {
            Section (header: Text("Pet Info")) {
                Picker("Type", selection: $petType) {
                    Text("Dog").tag(PetType.dog)
                    Text("Cat").tag(PetType.cat)
                }
                
                TextField("Kind", text: self.$petKind)
                    .disableAutocorrection(true)
                TextField("Color", text: self.$petColor)
                    .disableAutocorrection(true)
                TextField("Description", text: self.$petDescription)
                    .disableAutocorrection(true)
            }
            
            Section (header: Text("Disappearance Info")) {
                DatePicker(
                        "Time",
                         selection: $dspTime,
                         in: dateRange,
                         displayedComponents: [.date, .hourAndMinute]
                )
                TextField("Street Number and Name", text: self.$dspStreet)
                    .disableAutocorrection(true)
                TextField("City Name", text: self.$dspCity)
                    .disableAutocorrection(true)
                TextField("Country Name", text: self.$dspCountry)
                    .disableAutocorrection(true)
            }
            
            Section (header: Text("Contact Info")) {
                TextField("Contact Name", text: self.$contactName)
                    .disableAutocorrection(true)
                TextField("Contact Number", text: self.$contactNumber)
                    .keyboardType(.phonePad)
                    .disableAutocorrection(true)
            }
            
            Button("Publish", action: publish)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage)
                    )
                }
        }
        .navigationTitle("Lost Pet Alert")
        .navigationBarTitleDisplayMode(.inline)
        
        
        
    }
    
    private func publish() {
        self.validateEntry()
        
        if (validityKey) {
            let disappearanceAlert = DisappearanceAlert(petType: petType.rawValue, petKind: petKind, petColor: petColor, petDescription: petDescription, dspTime: dspTime, dspStreet: dspStreet, dspCity: dspCity, dspCountry: dspCountry, contactName: contactName, contactNumber: contactNumber)
            
            self.fireDBHelper.insertAlert(newAlert: disappearanceAlert)
            
            dismiss()
            
        }
        
    }
    
    private func validateEntry() {
        if (petKind.count < 2) {
            showAlert = true
            alertTitle = "Invalid Entry"
            alertMessage = "You should enter a valid pet kind!"
            validityKey = false
        }
        if (petColor.count < 2) {
            showAlert = true
            alertTitle = "Invalid Entry"
            alertMessage = "You should enter a valid pet color!"
            validityKey = false
        }
        if (petDescription.count < 2) {
            showAlert = true
            alertTitle = "Invalid Entry"
            alertMessage = "You should enter a valid pet description!"
            validityKey = false
        }
        if (dspStreet.count < 2) {
            showAlert = true
            alertTitle = "Invalid Entry"
            alertMessage = "You should enter a valid street info!"
            validityKey = false
        }
        if (dspCity.count < 2) {
            showAlert = true
            alertTitle = "Invalid Entry"
            alertMessage = "You should enter a valid city info!"
            validityKey = false
        }
        if (dspStreet.count < 2) {
            showAlert = true
            alertTitle = "Invalid Entry"
            alertMessage = "You should enter a valid street info!"
            validityKey = false
        }
        if (dspCountry.count < 2) {
            showAlert = true
            alertTitle = "Invalid Entry"
            alertMessage = "You should enter a valid country info!"
            validityKey = false
        }
        if (contactName.count < 2) {
            showAlert = true
            alertTitle = "Invalid Entry"
            alertMessage = "You should enter a valid contact name!"
            validityKey = false
        }
        if (contactNumber.count < 2) {
            showAlert = true
            alertTitle = "Invalid Entry"
            alertMessage = "You should enter a valid contact number!"
            validityKey = false
        }
    }
}

struct DisappearanceAlertView_Previews: PreviewProvider {
    static var previews: some View {
        DisappearanceAlertView()
    }
}
