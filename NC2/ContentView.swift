//
//  ContentView.swift
//  NC2
//
//  Created by Belinda Angelica on 20/05/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    var body: some View {
            ZStack {
                MapView()
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
