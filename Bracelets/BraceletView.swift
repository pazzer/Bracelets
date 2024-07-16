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
            let items = pathLayout.update(
                forScale: Int(rect.width),
                itemCount: bracelet.beads.count,
                padding: 0.2)
            path(in: rect)
                .stroke(style: .init(lineWidth: 4.0, lineCap: .round))
            ForEach(Array(zip(items.indices, items)), id: \.0) { index, item in
                beadView(bracelet.beads[index])
                    .frame(width: item.diameter, height: item.diameter)
                    .rotationEffect(.init(degrees: item.rotation.value))
                    .position(x: item.position.x, y: item.position.y - ((rect.width - rect.height) / 2))
            }
        }
        .padding()
        
    }
    
    func path(in rect: CGRect) -> Path {
        let path = pathLayout.path.bezierPath()
        
        let scale = CGAffineTransform(scaleX: rect.width, y: rect.width)
        path.apply(scale)
        
        let transform = CGAffineTransform(translationX: 0, y:  -((rect.width - rect.height) / 2))
        path.apply(transform)
        
        return Path(path.cgPath)
    }
    
    
    func beadView(_ bead: Bracelet.Bead) -> some View {
        Image(systemName: bead.symbol.rawValue)
            .resizable()
            .foregroundStyle(bead.color.opacity(1))
            .symbolRenderingMode(.multicolor)
            .fontWeight(.bold)
    }
}



#Preview("Bracelet View") {
    
    struct Preview: View {
        
        let cubicBezier = CubicBezier(
                start: .init(x: 0.024, y: 1 - 0.357),
                end: .init(x: 0.973, y: 1 - 0.63),
                controlPoint1: .init(x: 0.127, y: 1 - 0.824),
                controlPoint2: .init(x: 0.944, y: 1 - 0.05))
        
        
        let bracelet = Bracelet("Good Looking", color: .brown)
        
        var body: some View {
            
            
            VStack {
                BraceletView(bracelet: bracelet, pathLayout: PathLayout(path: cubicBezier))
                    .aspectRatio(1.5, contentMode: .fit)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.yellow)
                    )
                BraceletView(bracelet: bracelet, pathLayout: PathLayout(path: cubicBezier))
                    .aspectRatio(1.5, contentMode: .fit)
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


