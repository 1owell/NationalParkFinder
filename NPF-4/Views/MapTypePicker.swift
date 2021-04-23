//
//  MapTypePicker.swift
//  NPF-4
//
//  Created by Lowell Pence on 4/22/21.
//

import SwiftUI
import MapKit

struct MapTypePicker: View {
    
    @Binding var mapType: MKMapType
    
    init(mapType: Binding<MKMapType>) {
        UISegmentedControl.appearance().selectedSegmentTintColor = .blue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
        UISegmentedControl.appearance().backgroundColor = UIColor.white
        
        self._mapType = mapType
    }
    
    var body: some View {
        Picker("Map type", selection: $mapType) {
            Text("Standard").tag(MKMapType.standard)
            Text("Satellite").tag(MKMapType.satellite)
            Text("Hybrid").tag(MKMapType.hybrid)
        }
        .opacity(0.8)
        .padding()
        .labelsHidden()
        .shadow(radius: 5)
        .pickerStyle(SegmentedPickerStyle())
    }
}
