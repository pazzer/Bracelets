//
//  CGPoint+Scale.swift
//  Bracelets
//
//  Created by Paul Patterson on 16/07/2024.
//

import Foundation

extension CGPoint {
    
    func scaled(by scaleFactor: CGFloat) -> CGPoint {
        .init(x: x * scaleFactor, y: y * scaleFactor)
    }
    
}


