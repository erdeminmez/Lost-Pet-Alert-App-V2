//
//  DisappearanceListView.swift
//  Lost_Pet_Alert_App_V2
//
//  Created by Erdem Inmez on 2022-12-09.
//

import SwiftUI

struct DisappearanceListView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var locationHelper : LocationHelper
    @State private var selectedIndex : Int = -1
    
    let searchKeys : [String]
    
    var body: some View {
        ZStack {
            List{
                ForEach(self.fireDBHelper.disappearanceAlertList.enumerated().map({$0}), id: \.element.self){index, alert in
                    if (self.isValid(alert: alert)) {
                        NavigationLink(destination: MapView(selectedAlertIndex: index)) {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Text("Pet Info").fontWeight(.bold).font(.title2)
                                    Text(alert.petType.capitalized)
                                    Text(alert.petKind)
                                    Text(alert.petColor)
                                    Text(alert.petDescription)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.gray, lineWidth: 4)
                                )
                                VStack(alignment: .leading) {
                                    Text("Disappearance Info").fontWeight(.bold).font(.title2)
                                    Text(alert.dspTime.formatted())
                                    Text(alert.dspStreet)
                                    Text(alert.dspCity)
                                    Text(alert.dspCountry)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.gray, lineWidth: 4)
                                )
                                VStack(alignment: .leading) {
                                    Text("Contact Info").fontWeight(.bold).font(.title2)
                                    Text(alert.contactName)
                                    Text(alert.contactNumber)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.gray, lineWidth: 4)
                                )
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black, lineWidth: 4)
                            )
                            .onTapGesture {
                                self.selectedIndex = index
                            }
                        }
                        
                    }
                }
            }
        }
        .navigationTitle("Alert List")
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
    
    private func isValid(alert: DisappearanceAlert) -> Bool{
        return alert.petType.lowercased() == searchKeys[2].lowercased() && alert.dspCountry.lowercased() == searchKeys[1].lowercased() && alert.dspCity.lowercased() == searchKeys[0].lowercased()
    }
}

struct DisappearanceListView_Previews: PreviewProvider {
    static var previews: some View {
        DisappearanceListView(searchKeys: [])
    }
}
