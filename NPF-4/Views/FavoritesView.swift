//
//  FavoritesView.swift
//  NPF-4
//
//  Created by Lowell Pence on 4/23/21.
//

import SwiftUI

struct FavoritesView: View {
    
    
    @EnvironmentObject var parksManager: ParksManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach(parksManager.parks, id: \.self) { park in
                    NavigationLink(destination: ParkDetail(park: park)) {
                        Text(park.parkName).font(.headline)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
