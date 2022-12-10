//
//  FireDBHelper.swift
//  Lost_Pet_Alert_App_V2
//
//  Created by Erdem Inmez on 2022-12-09.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    private let store : Firestore
    @Published var disappearanceAlertList = [DisappearanceAlert]()
    private let COLLECTION_NAME : String = "DisappearanceAlerts"
    
    //singleton design pattern
    private static var shared : FireDBHelper?
    
    init(database : Firestore){
        self.store = database
    }
    
    static func getInstance() -> FireDBHelper{
        if (shared == nil){
            shared = FireDBHelper(database: Firestore.firestore())
        }
        
        return shared!
    }
    
    
    func insertAlert(newAlert : DisappearanceAlert){
        
        do{
            
            try self.store.collection(COLLECTION_NAME).addDocument(from: newAlert)
            
        }catch let error as NSError{
            print(#function, "Error while inserting document on firestore \(error)")
        }
    }
    
    func getAllAlerts(){
        
        self.store
            .collection(COLLECTION_NAME)
            .order(by: "dspTime", descending: true)
            .addSnapshotListener( { (querySnapshot, error)  in
                
                guard let snapshot = querySnapshot else{
                    print(#function, "Error while retrieving records \(error)")
                    return
                }
                
                snapshot.documentChanges.forEach{ (docChange) in
                    
                    do{
                        
                        var alert = DisappearanceAlert()
                        alert = try docChange.document.data(as: DisappearanceAlert.self)
                        
                        let docID = docChange.document.documentID
                        alert.id = docID
                        
                        let matchedIndex = self.disappearanceAlertList.firstIndex(where: { ($0.id?.elementsEqual(docID))! })
                        
                        if docChange.type == .added{
                            self.disappearanceAlertList.append(alert)
                            print(#function, "Document ADDED : \(alert)")
                        }
                        
                        if docChange.type == .modified{
                            //change or replace current object in List with updated values
                            
                            if(matchedIndex != nil){
                                self.disappearanceAlertList[matchedIndex!] = alert
                            }
                            
                        }

                        if docChange.type == .removed{
                            if(matchedIndex != nil){
                                self.disappearanceAlertList.remove(at: matchedIndex!)
                            }
                        }
                        
                    }catch let err as NSError{
                        print(#function, "unable to identify document change \(err)")
                    }
                    
                }
                
            })
    }
    
//    func filteredAlerts(petType: String, cityName: String, countryName: String) -> [DisappearanceAlert] {
//        var filteredAlertList = [DisappearanceAlert]()
//        for alert in self.disappearanceAlertList {
//            if(alert.petType == petType && alert.dspCity == cityName && alert.dspCountry == countryName) {
//                filteredAlertList.append(alert)
//            }
//        }
//        return filteredAlertList
//    }
}
