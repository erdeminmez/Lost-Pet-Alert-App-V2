//
//  SearchView.swift
//  Lost_Pet_Alert_App_V2
//
//  Created by Erdem Inmez on 2022-12-09.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var selection : Int? = nil
    @State private var cityName : String = ""
    @State private var countryName : String = ""
    @State private var petType : PetType = PetType.dog
    @State private var searchKeys : [String] = ["","",""]
    
    enum PetType: String, CaseIterable, Identifiable {
        case dog, cat
        var id: Self { self }
    }
    
    var body: some View {
        NavigationLink(destination: DisappearanceListView(searchKeys: self.searchKeys), tag: 1, selection: self.$selection){}
        
        VStack(alignment: .center,spacing: 20) {
            Spacer()
            Picker("Type", selection: $petType) {
                Text("Dog").tag(PetType.dog)
                Text("Cat").tag(PetType.cat)
            }
            .font(.title2)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.green, lineWidth: 2)
            )
            
            TextField("City Name", text: self.$cityName)
                .disableAutocorrection(true)
                .font(.title2)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.green, lineWidth: 2)
                )
            TextField("Country Name", text: self.$countryName)
                .disableAutocorrection(true)
                .font(.title2)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.green, lineWidth: 2)
                )
            Button("Search", action: search)
                .font(.headline.bold())
                .foregroundColor(.white)
                .frame(height: 40)
                .frame(width: 100)
                .background(Color.green)
                .cornerRadius(10)
                
            Spacer()
        }
        .padding(10)
        .navigationBarTitle("Alert Search", displayMode: .inline)
    }
    
    private func search() {
        searchKeys[0] = cityName
        searchKeys[1] = countryName
        searchKeys[2] = petType.rawValue
        self.selection = 1
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
