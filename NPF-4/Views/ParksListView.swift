//
//  ParksListView.swift
//  NPF-4
//
//  Created by Lowell Pence on 4/21/21.
//

import SwiftUI

struct ParksListView: View {
    
    @EnvironmentObject var parksManager: ParksManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach(parksManager.parks, id: \.self) { park in
                    NavigationLink(destination: ParkDetail(park: park)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(park.parkName).font(.headline)
                            Text("Distance xxx").font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("National Parks")
        }
    }
}


struct ParksListView_Previews: PreviewProvider {
    static var previews: some View {
        ParksListView()
            .environmentObject(ParksManager())
    }
}
