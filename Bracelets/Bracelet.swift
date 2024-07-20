//
//  Bracelet.swift
//  Bracelets
//
//  Created by Paul Patterson on 14/07/2024.
//

import Foundation
import struct SwiftUI.Color
import class UIKit.UIColor

struct Bracelet: Identifiable {
    
    static func == (lhs: Bracelet, rhs: Bracelet) -> Bool {
        lhs.id == rhs.id
    }
    
    
    enum Design {
        case singleColor(_: Color)
        case dualColor(color1: Color, color2: Color, interval: Int)
    }
    
    struct Bead: Identifiable, Hashable {
        let id = UUID()
        
        let color: Color
        let symbol: SFSymbol
        
    }
    
    let id = UUID()
    var beads: [Bead]
    
    var strapColor: Color
    
    init(_ message: String, design: Design) {
        
        let symbols = SFSymbol.symbols(for: message)
        switch design {
        case .singleColor(let color):
            beads = zip(symbols, Self.singleColors(color, itemCount: message.count)).map { (sfsymbol, color) in
                Bead(color: color, symbol: sfsymbol)
            }
            strapColor = color.opacity(0.45)
        case .dualColor(let color1, let color2, let interval):
            beads = zip(symbols, Self.alternatingColor(color1, color2: color2, itemCount: symbols.count, run: interval)).map { (sfsymbol, color) in
                Bead(color: color, symbol: sfsymbol)
            }
            strapColor = color1.opacity(0.45)
        }
    }
    
    
    static func alternatingColor(_ color1: Color, color2: Color, itemCount: Int, run: Int) -> [Color] {
        let first = Bool.random() ? 0 : run
        return Array(0..<itemCount).map { ii in
            if Array(0..<run).contains((ii - first) % (run * 2)) {
                return color2
            } else {
                return color1
            }
        }
    }
    
    
    
    static func singleColors(_ color: Color, itemCount: Int) -> [Color] {
        var colors = [Color](repeating: color, count: itemCount)
        
        let indicies = Array(0..<itemCount)
        let shuffled = indicies.shuffled()
        let numToAdjust = Int(Double(itemCount) * CGFloat.random(in: 0.3...0.5))
        
        shuffled.prefix(through: numToAdjust).forEach { index in
            colors[index] = color.withSaturation(0.5)
        }
        return colors
    }
    
}


extension Color {
    
    func withSaturation(_ saturation: CGFloat) -> Color {
        var uiColor = UIColor(self)
        let comps = uiColor.hsba
        uiColor = UIColor(hue: comps.hue, saturation: saturation, brightness: comps.brightness, alpha: comps.alpha)
        return Color(uiColor: uiColor)
        
    }
    
}

extension UIColor {
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h, s, b, a)
    }
    
    
}

extension Bracelet {
    
    // i love fish and chips
    static let a = Bracelet("i❤️f+c+g", design: .singleColor(.red))
    
    // you and me forever and ever
    static let b = Bracelet("y+mfae", design: .singleColor(.teal))
    
    // i got hammered last night
    static let c = Bracelet("ig🔨ln!", design: .dualColor(color1: .appleGreen, color2: .darkPink, interval: 1))
    
    // i love dogs and cats
    static let d = Bracelet("I ❤️ 🦮 + 🐈‍⬛", design: .singleColor(.orange))
    
    // plenty of fish in the sea
    static let e = Bracelet("po🐟its", design: .singleColor(.purple))
    
    // gonna be clouds in the sky tonight
    static let f = Bracelet("gb☁️its🌙", design: .singleColor(.mint))
    
    // keep some space in your heart for me
    static let g = Bracelet("ks iy❤️fm", design: .dualColor(color1: .darkPurple, color2: .lavender, interval: 1))
    
    // gonna hit a home-run today
    static let h = Bracelet("gha⚾️t!", design: .singleColor(.indigo))
    
    // the smell of money is what i want
    static let i = Bracelet("tso£iwiw", design: .singleColor(.green))
    
    // we all live in a yellow submarine
    static let j = Bracelet("waliays", design: .singleColor(.pink))
    
    // all i want for chrismas is a hammer
    static let k = Bracelet("aiwfxia🔨", design: .dualColor(color1: .green, color2: .blue, interval: 1))
    
    // in bed all day long thanks
    static let l = Bracelet("i🛏️adlt", design: .singleColor(.brown))
    
    // running and jumping is for wimps
    static let m = Bracelet("r+jifw", design: .singleColor(.cyan))
    
    // don't let the dog on the bed
    static let n = Bracelet("dl🦮ot🛏️", design: .dualColor(color1: .turquoise, color2: .lightOrange, interval: 2))
    
    // nothing ever happens nothing happens at all
    static let o = Bracelet("nehnhaa", design: .singleColor(.red))
    
    // whats good for the goose?
    static let p = Bracelet("wgftg?", design: .singleColor(.green))
    
    // if you're good you get a star
    static let q = Bracelet("iygyga⭐️", design: .singleColor(.mint))
    
    // the moon is waxing gibbous tonight
    static let r = Bracelet("t🌙iwgt", design: .dualColor(color1: .appleGreen, color2: .darkPink, interval: 2))
    
    // on your marks get set go
    static let s = Bracelet("oym gs g", design: .singleColor(.pink))
    
    // all that glitters is not gold
    static let t = Bracelet("atging", design: .singleColor(.black))
    
    // a stitch in time saves 9
    static let u = Bracelet("asits9", design: .singleColor(.green))
    
    // 54321!
    static let v = Bracelet("54321!", design: .dualColor(color1: .maroon, color2: .silver, interval: 1))
    
    // hey you get off my cloud
    static let w = Bracelet("hygom☁️", design: .dualColor(color1: .indigo, color2: .pink, interval: 1))
    
    // broad based trends and helicopter parenting
    static let x = Bracelet("bbathp", design: .singleColor(.mint))
    
    // i am not a number ok
    static let y = Bracelet("iananok", design: .singleColor(.blue))
    
    // I do like that doggy in the window
    static let z = Bracelet("idlt🦮itw", design: .singleColor(.indigo))
    
    static let examples = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
}
