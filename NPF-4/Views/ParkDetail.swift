//
//  ParkDetail.swift
//  NPF-4
//
//  Created by Lowell Pence on 4/23/21.
//

import SwiftUI

struct ParkDetail: View {
    
    let park: Park
    
    var body: some View {
        VStack {
            Text(park.parkLocation)
            Text(park.area)
            Text("Date Formed: \(park.dateFormed)")
            // load image lazily from network call. Use parkManager to get image. ParkManager will have to communicate with network manager
            //Image(park.image?.imageLink)
            Link("Wikipedia", destination: URL(string: park.link)!)
            
            Button("View on Map") {
                // switch to map tab
                // zoom in location
            }
            
            
        }
        .navigationTitle(park.parkName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                // add to favorites
            }) {
                // fill heart if favorite, otherwise heart outline
                Image(systemName: "heart")
            }
        }
    }
}

