//
//  MapTab.swift
//  NPF-4
//
//  Created by Lowell Pence on 4/22/21.
//

import SwiftUI

// SwiftUI MapTab, holds that MapView
struct MapTab: View {
    
    @State private var showMapAlert = false
    @State private var showLoading: Bool = false
    @State private var mapType: MKMapType = .standard
    @State private var isZoomedToUser: Bool = false
    
    @EnvironmentObject var 
    
    let mapTypes: [String] = ["Standard", "Satelite", "Hybrid"]
    
    var body: some View {
        ZStack {
            MapView(locationManager: $locationManager,
                    showMapAlert: $showMapAlert,
                    parks: $parks,
                    mapType: $mapType,
                    showLoading: $showLoading,
                    isZoomedToUser: $isZoomedToUser)
                .alert(isPresented: $showMapAlert) {
                    Alert(title: Text("Location Access Denied"),
                          message: Text("Your location is needed"),
                          primaryButton: .cancel(),
                          secondaryButton: .default(Text("Settings"),
                                                    action: { self.goToDeviceSettings() }))
                }
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack(spacing: 30) {

                    Button(action: {
                        // Show loading progress, zoom in to user, start updating location
                        showLoading = true
                        isZoomedToUser ? locationManager.stopUpdatingLocation() : locationManager.startUpdatingLocation()
                        isZoomedToUser.toggle()
                    }, label: {
                        if showLoading {
                            ProgressView()
                                .frame(width: 60, height: 60)
                                .opacity(showLoading ? 1.0 : 0.0)
                                .foregroundColor(Color.black)
                                .background(Color.gray)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        } else {
                            Image(systemName: isZoomedToUser ? "minus.magnifyingglass" : "arrow.clockwise")
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                    }).disabled(showLoading)
                }
                
                MapTypePicker(mapType: $mapType)
            }
            .offset(y: -30)
        }
    }
}

struct MapTab_Previews: PreviewProvider {
    static var previews: some View {
        MapTab()
    }
}
