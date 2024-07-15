//
//  BraceletView.swift
//  Bracelets
//
//  Created by Paul Patterson on 14/07/2024.
//

import SwiftUI



struct BraceletView: View {
    
    let bracelet: Bracelet
    
    /// a CublicBezier instance that represents a *normalized* cubic bezier path.
    let path: CubicBezier
    
    var body: some View {
        GeometryReader { gp in
            let rect = gp.frame(in: .local)
            path(in: rect)
                .stroke(style: .init(lineWidth: 4.0, lineCap: .round))
            ForEach([(0, 100), (1, 236), (2, 351), (3, 452), (4, 551), (5, 658), (6, 786), (7, 919)], id: \.self.0) { (ii, int) in
                let t = Double(int) / 1000.0
                let p = path.point(at: t)
                let x = p.x * rect.width
                let y = p.y * rect.width
                let xAngle = path.xAngle(at: t, in: .degrees)
                beadView(bracelet.beads[ii])
                    .frame(width: 36, height: 36)
                    .rotationEffect(.init(degrees: xAngle.value))
                    .position(x: x, y: y)
                    
                
            }
        }
        .padding()
    }
    
    func path(in rect: CGRect) -> Path {
        
        let multiplier = min(rect.width, rect.height)
        let scale = CGAffineTransform(scaleX: multiplier, y: multiplier)
        
        let path = path.bezierPath()
        path.apply(scale)
        
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
        
        
        let bracelet = Bracelet("I love dogs", color: .brown)
        
        var body: some View {
            
            VStack {
                BraceletView(bracelet: bracelet, path: cubicBezier)
                    .aspectRatio(1, contentMode: .fit)
                    .background(
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .fill(.yellow))
                BraceletView(bracelet: bracelet, path: cubicBezier)
                    .aspectRatio(1, contentMode: .fit)
                    .background(
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .fill(.yellow))
                
                
            }
            
        }
    }
    
    return Preview()
}
