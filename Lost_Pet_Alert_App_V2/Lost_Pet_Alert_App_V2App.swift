//
//  Lost_Pet_Alert_App_V2App.swift
//  Lost_Pet_Alert_App_V2
//
//  Created by Erdem Inmez on 2022-12-09.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct Lost_Pet_Alert_App_V2App: App {
    
    let fireDBHelper : FireDBHelper
    let locationHelper : LocationHelper
    
    init() {
        FirebaseApp.configure()
        fireDBHelper = FireDBHelper(database: Firestore.firestore())
        locationHelper = LocationHelper()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(fireDBHelper)
                .environmentObject(locationHelper)
        }
    }
}
