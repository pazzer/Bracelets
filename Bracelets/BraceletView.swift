//
//  BraceletView.swift
//  Bracelets
//
//  Created by Paul Patterson on 14/07/2024.
//

import SwiftUI



struct BraceletView: View {
    
    let bracelet: Bracelet
    
    let pathLayout: PathLayout
    
    var body: some View {
        GeometryReader { gp in
            let rect = gp.frame(in: .local)
            let yOffset = (rect.width - rect.height) / 2
            
            let items = pathLayout.layout(
                forScale: Int(rect.width),
                itemCount: bracelet.beads.count,
                padding: 0.2)
            
            path(in: rect)
                .stroke(bracelet.strapColor, style: .init(lineWidth: 4.0, lineCap: .round))
            ForEach(Array(zip(items.indices, items)), id: \.0) { index, item in
                beadView(bracelet.beads[index])
                    .frame(width: item.diameter, height: item.diameter)
                    .rotationEffect(.init(degrees: item.rotation.value))
                    .position(x: item.position.x, y: item.position.y - yOffset)
            }
        }
        .aspectRatio(1.625, contentMode: .fill)
        .padding()
        
    }
    
    func path(in rect: CGRect) -> Path {
        let path = pathLayout.path.bezierPath()
        
        let scale = CGAffineTransform(scaleX: rect.width, y: rect.width)
        path.apply(scale)
        
        let translation = CGAffineTransform(translationX: 0, y:  -((rect.width - rect.height) / 2))
        path.apply(translation)
        
        return Path(path.cgPath)
    }
    
    
    func beadView(_ bead: Bracelet.Bead) -> some View {
        Image(systemName: bead.symbol.rawValue)
            .resizable()
            .foregroundStyle(bead.color.opacity(1))
            .fontWeight(.bold)
            .background(
                Circle()
                    .fill(.white)
            )
            
    }
}



#Preview("Bracelet View") {
    
    struct Preview: View {
        
        let snakePath = CubicBezier(
                start: .init(x: 0.024, y: 1 - 0.357),
                end: .init(x: 0.973, y: 1 - 0.63),
                controlPoint1: .init(x: 0.127, y: 1 - 0.824),
                controlPoint2: .init(x: 0.944, y: 1 - 0.05))
        
        let headUp = CubicBezier(
            start: CGPoint(x: 0.05, y: 1 - 0.46),
            end: CGPoint(x: 0.96, y: 1 - 0.548),
            controlPoint1: CGPoint(x: 0.593, y: 1 - 0.533),
            controlPoint2: CGPoint(x: 0.775, y: 1 - 0.31))
        
        let linePath = CubicBezier(
            start: CGPoint(x: 0.05, y: 1 - 0.5),
            end: CGPoint(x: 0.95, y: 1 - 0.5),
            controlPoint1: CGPoint(x: 0.05, y: 1 - 0.5),
            controlPoint2: CGPoint(x: 0.95, y: 1 - 0.5))
        
        let rightDip = CubicBezier(
            start: CGPoint(x: 0.057, y: 1 - 0.532),
            end: CGPoint(x: 0.95, y: 1 - 0.5),
            controlPoint1: CGPoint(x: 0.616, y: 1 - 0.516),
            controlPoint2: CGPoint(x: 0.838, y: 1 - 0.353))
        
        let leftDip = CubicBezier(
            start: CGPoint(x: 0.057, y: 1 - 0.51),
            end: CGPoint(x: 0.95, y: 1 - 0.5),
            controlPoint1: CGPoint(x: 0.264, y: 1 - 0.581),
            controlPoint2: CGPoint(x: 0.271, y: 1 - 0.466))
        
        let prima = Bracelet("Prima!", design: .singleColor(.brown))
        let trouble = Bracelet("trouble!", design: .singleColor(.black))
        let quitter = Bracelet("quitter", design: .singleColor(.blue))
        
        var body: some View {
            
            
            VStack {
                
                Group {
                    BraceletView(bracelet: .a, pathLayout: PathLayout(path: snakePath))
                    BraceletView(bracelet: .d, pathLayout: PathLayout(path: headUp))
                    BraceletView(bracelet: .n, pathLayout: PathLayout(path: CubicBezier.k))
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.yellow)
                )
                
                    
            }
            .padding()
            
            
        }
    }
    
    return Preview()
}



