//
//  DisappearanceAlert.swift
//  Lost_Pet_Alert_App_V2
//
//  Created by Erdem Inmez on 2022-12-09.
//

import Foundation
import Foundation
import FirebaseFirestoreSwift

struct DisappearanceAlert: Codable, Hashable, Identifiable {
    @DocumentID var id : String? = UUID().uuidString
    
    var petType : String
    var petKind : String
    var petColor : String
    var petDescription : String
    
    var dspTime : Date
    var dspStreet : String
    var dspCity : String
    var dspCountry : String
    
    var contactName : String
    var contactNumber : String
    
    init(petType: String, petKind: String, petColor: String, petDescription: String, dspTime: Date, dspStreet: String, dspCity: String, dspCountry: String, contactName: String, contactNumber: String){
        self.petType = petType
        self.petKind = petKind
        self.petColor = petColor
        self.petDescription = petDescription
        
        self.dspTime = dspTime
        self.dspStreet = dspStreet
        self.dspCity = dspCity
        self.dspCountry = dspCountry
        
        self.contactName = contactName
        self.contactNumber = contactNumber
    }
    
    init(){
        self.petType = ""
        self.petKind = ""
        self.petColor = ""
        self.petDescription = ""
        
        self.dspTime = Date.now
        self.dspStreet = ""
        self.dspCity = ""
        self.dspCountry = ""
        
        self.contactName = ""
        self.contactNumber = ""
    }
    
    //Failable initializer
    init?(dictionary: [String: Any]){
        
        guard let petTypeD = dictionary["petType"] as? String else{
            return nil
        }
        
        guard let petKindD = dictionary["petKind"] as? String else{
            return nil
        }
        
        guard let petColorD = dictionary["petColor"] as? String else{
            return nil
        }
        
        guard let petDescriptionD = dictionary["petDescription"] as? String else{
            return nil
        }
        
        guard let dspTimeD = dictionary["dspTime"] as? Date else{
            return nil
        }
        
        guard let dspStreetD = dictionary["dspStreet"] as? String else{
            return nil
        }
        
        guard let dspCityD = dictionary["dspCity"] as? String else{
            return nil
        }
        
        guard let dspCountryD = dictionary["dspCountry"] as? String else{
            return nil
        }
        
        guard let contactNameD = dictionary["contactName"] as? String else{
            return nil
        }
        
        guard let contactNumberD = dictionary["contactNumber"] as? String else{
            return nil
        }
        
        self.init(petType: petTypeD, petKind: petKindD, petColor: petColorD, petDescription: petDescriptionD, dspTime: dspTimeD, dspStreet: dspStreetD, dspCity: dspCityD, dspCountry: dspCountryD, contactName: contactNameD, contactNumber: contactNumberD)
        
    }
}
