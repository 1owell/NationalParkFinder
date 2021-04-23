//
//  ContentView.swift
//  NPF-4
//
//  Created by Lowell Pence
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    
    @StateObject var locationManager    = LocationManager()
    @State private var selectedTab: Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MapTab()
                .tabItem { Label("Map", systemImage: "1.square.fill") }
                .tag(1)
            ParksListView()
                .tabItem { Label("Parks", systemImage: "1.square.fill") }
                .tag(2)
            Text("Favorite")
                .tabItem { Label("Favorites", systemImage: "1.square.fill") }
                .tag(3)
            AboutView()
                .tabItem { Label("About", systemImage: "1.square.fill") }
                .tag(4)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
