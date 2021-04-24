//
//  ParksListView.swift
//  NPF-4
//
//  Created by Lowell Pence on 4/21/21.
//

import SwiftUI

struct ParksListView: View {
    
    @EnvironmentObject var parksManager: ParksManager
    
    @State private var sortAsc = true
    
    
    func sortAlphabetically(park1: Park, park2: Park) -> Bool {
        sortAsc ? park1.parkName < park2.parkName : park1.parkName > park2.parkName
    }
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(parksManager.parks.sorted(by: { sortAlphabetically(park1: $0, park2: $1) }), id: \.self) { park in
                    NavigationLink(destination: ParkDetail(park: park)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(park.parkName).font(.headline)
                            Text("Distance:").font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("National Parks")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Sort", selection: $sortAsc) {
                        Text("A-Z").tag(true)
                        Text("Z-A").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
        }
    }
}


struct ParksListView_Previews: PreviewProvider {
    static var previews: some View {
        ParksListView()
            .environmentObject(ParksManager())
    }
}
