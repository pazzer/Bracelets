//
//  PathLayout.swift
//  Bracelets
//
//  Created by Paul Patterson on 16/07/2024.
//

import Foundation


class PathLayout {
    
    static let kArcLengthDivisions = 1000
    
    struct Item {
        
        let diameter: CGFloat
        let position: CGPoint
        let rotation: Measurement<UnitAngle>
        
    }
    
    private(set) var path: CubicBezier
    
    private let arcLengths: [Double]
    
    private var arcLength: CGFloat {
        arcLengths.last!
    }
    
    init(path: CubicBezier) {
        self.path = path
        self.arcLengths = Array(0...Self.kArcLengthDivisions).map { t in
            return path.arcLength(to: Double(t) / Double(Self.kArcLengthDivisions))
        }
    }

    typealias Percent = CGFloat
    
    func layout(forScale scale: Int, itemCount: Int, padding: Percent) -> [Item] {
        let available = arcLength * (1 - padding)
        let interval = available / Double(itemCount - 1)
        let start = arcLength * (padding / 2)
        let diameter = ((available * CGFloat(scale)) / Double(itemCount))
        let divisions = Double(Self.kArcLengthDivisions)
        
        return Array(0..<itemCount).compactMap { ii in
            let distance = start + Double(ii) * interval
            return arcLengths.indexOfNearestMatch(distance, matchRule: .closest)
        }.map { t in
            Item(
                diameter: diameter,
                position: path.point(at: Double(t) / divisions).scaled(by: CGFloat(scale)),
                rotation: path.xAngle(at: Double(t) / divisions, in: .degrees))
        }
    }
    
    
    

    
}
