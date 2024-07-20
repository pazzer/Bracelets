//
//  BraceletGallery.swift
//  Bracelets
//
//  Created by Paul Patterson on 17/07/2024.
//

import SwiftUI



struct BraceletGallery: View {
    
    
    var bracelets = {
        let paths = CubicBezier.examples
        return Bracelet.examples.enumerated().map { ii, bracelet in
            let path = paths[ii % paths.count]
            let layout = PathLayout(path: path)
            return (bracelet, layout)
        }
    }()
    
    
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                LazyVGrid(columns: [.init(), .init()], content: {
                    ForEach(Array(zip(bracelets.indices, bracelets)), id: \.0) { index, bracelet in
                        BraceletView(bracelet: bracelet.0, pathLayout: bracelet.1)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color(white: 0.935))
                            )
                    }
                })
                
            }
            
        }
        .scrollIndicators(.never)
        .padding()
    }
}






#Preview("Bracelet Gallery") {
    
    struct Preview: View {
        

        var body: some View {
            BraceletGallery()
        }
    }
    
    return Preview()
}
