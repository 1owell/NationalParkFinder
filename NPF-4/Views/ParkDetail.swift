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
        Text(park.parkName)
            .navigationTitle(park.parkName)
            .navigationBarTitleDisplayMode(.inline)
    }
}

// wrap in navigation view
//struct ParkDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ParkDetail()
//    }
//}
