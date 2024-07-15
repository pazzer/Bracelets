//
//  Bracelet.swift
//  Bracelets
//
//  Created by Paul Patterson on 14/07/2024.
//

import Foundation
import struct SwiftUI.Color

struct Bracelet: Identifiable, Hashable {
    
    struct Bead: Identifiable, Hashable {
        let id = UUID()
        
        let color: Color
        let symbol: SFSymbol
        
    }
    
    let id = UUID()
    var beads: [Bead]
    
    init(_ message: String, color: Color) {
        beads = SFSymbol
            .symbols(for: message)
            .map { Bead(color: color, symbol: $0) }
    }
}
