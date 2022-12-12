//
//  HomeView.swift
//  Lost_Pet_Alert_App_V2
//
//  Created by Erdem Inmez on 2022-12-09.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var selection : Int? = nil
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                
                NavigationLink(destination: DisappearanceAlertView(), tag: 1, selection: self.$selection){}
                
                NavigationLink(destination: SearchView(), tag: 2, selection: self.$selection){}
                
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 200)
                    .cornerRadius(30)
                
                Button("Disappearance Alert", action: alertDisappearance)
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(width: 200)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding()
                Button("Show Disappearances", action: showDisappearanceList)
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(width: 200)
                    .background(Color.green)
                    .cornerRadius(10)
                    
                Spacer()
            }//VStack ends
            .padding()
            .navigationTitle("Lost Pet App")
            .navigationBarTitleDisplayMode(.inline)
        }//NavigationView ends
        .onAppear(){
            //get all alerts from DB
            self.fireDBHelper.getAllAlerts()
        }
        
    }//body ends
    
    
    // Alert a disappearance
    private func alertDisappearance() {
        self.selection = 1
    }
    
    // Show the list of disappearances
    private func showDisappearanceList() {
        self.selection = 2
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
