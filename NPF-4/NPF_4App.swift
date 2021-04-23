//
//  NPF_4App.swift
//  NPF-4
//
//  Created by Lowell Pence on 4/21/21.
//

import SwiftUI

@main
struct NPF_4App: App {
    
    @StateObject var parksManager = ParksManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(parksManager)
        }
    }
}
