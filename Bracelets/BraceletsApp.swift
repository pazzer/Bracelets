//
//  BraceletsApp.swift
//  Bracelets
//
//  Created by Paul Patterson on 14/07/2024.
//

import SwiftUI

@main
struct BraceletsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                BraceletGallery()
                    .navigationTitle("Bracelets")
                    .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}
