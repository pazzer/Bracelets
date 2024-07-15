//
//  ContentView.swift
//  Bracelets
//
//  Created by Paul Patterson on 14/07/2024.
//

import SwiftUI

//struct BraceletsView: View {
//    
//    /// a normalized cublic bezier path
//    let nCubicBezier: CubicBezier
//    
//
//    
//    var body: some View {
//        ScrollView {
//            LazyVStack(content: {
//                ForEach(1...100, id: \.self) { count in
//                    BraceletView(braceletPath: nCubicBezier)
//                        .aspectRatio(contentMode: .fit)
//                        .background(count.isMultiple(of: 2) ? .white : .orange)
//                }
//            })
//            
//        }
//        
//    }
//    
//    func path(in rect: CGRect) -> Path {
//        
//        let multiplier = min(rect.width, rect.height)
//        let scale = CGAffineTransform(scaleX: multiplier, y: multiplier)
//        
//        let path = nCubicBezier.bezierPath()
//        path.apply(scale)
//        
//        return Path(path.cgPath)
//        
//        
//    }
//}
//
//
//
//#Preview {
//    
//    struct Preview: View {
//        
//        let cubicBezier = CubicBezier(
//                start: .init(x: 0.024, y: 1 - 0.357),
//                end: .init(x: 0.973, y: 1 - 0.63),
//                controlPoint1: .init(x: 0.127, y: 1 - 0.824),
//                controlPoint2: .init(x: 0.944, y: 1 - 0.05))
//        
//        var bracelet = Bracelet("I love dogs!", color: .brown)
//        
//        
//        var body: some View {
//            BraceletsView
//        }
//    }
//    
//    return Preview()
//    
//    
//}
