//
//  BraceletView.swift
//  Bracelets
//
//  Created by Paul Patterson on 14/07/2024.
//

import SwiftUI



struct BraceletView: View {
    
    let bracelet: Bracelet
    
    let layoutPath: PathLayout
    
    var body: some View {
        GeometryReader { gp in
            let rect = gp.frame(in: .local)
            let yOffset = (rect.width - rect.height) / 2
            
            let items = layoutPath.layout(
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
        .aspectRatio(1.625, contentMode: .fit)
        .padding()
        
    }
    
    func path(in rect: CGRect) -> Path {
        let path = layoutPath.path.bezierPath()
        let scale = CGAffineTransform(scaleX: rect.width, y: rect.width)
        path.apply(scale)
        
        let yOffset = -((rect.width - rect.height) / 2)
        let translation = CGAffineTransform(translationX: 0, y: yOffset)
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
        
        var body: some View {
            ScrollView(.vertical) {
                VStack {
                    Group {
                        BraceletView(bracelet: .a, layoutPath: PathLayout(path: CubicBezier.a))
                        BraceletView(bracelet: .g, layoutPath: PathLayout(path: CubicBezier.c))
                        BraceletView(bracelet: .n, layoutPath: PathLayout(path: CubicBezier.k))
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.yellow)
                    )
                    
                }
            }
            .padding()
            
            
        }
    }
    
    return Preview()
}



