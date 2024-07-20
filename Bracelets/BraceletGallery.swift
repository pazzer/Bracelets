//
//  BraceletGallery.swift
//  Bracelets
//
//  Created by Paul Patterson on 17/07/2024.
//

import SwiftUI



struct BraceletGallery: View {
    
    var braceletData: [(bracelet: Bracelet, layoutPath: PathLayout)] = {
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
                    ForEach(Array(zip(braceletData.indices, braceletData)), id: \.0) { index, item in
                        NavigationLink {
                            BraceletView(
                                bracelet: item.bracelet,
                                layoutPath: item.layoutPath)
                        } label: {
                            BraceletView(
                                bracelet: item.bracelet,
                                layoutPath: item.layoutPath)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color(white: 0.935))
                                )
                        }
                    }
                })
                
            }
            
        }
        .scrollIndicators(.never)
        .padding()
    }
}






#Preview("Bracelet Gallery", traits: .portrait) {
    
    struct Preview: View {

        var body: some View {
            NavigationStack {
                BraceletGallery()
                    .navigationTitle("Bracelets")
                    .navigationBarTitleDisplayMode(.large)
            }
        }
    }
    
    return Preview()
}
