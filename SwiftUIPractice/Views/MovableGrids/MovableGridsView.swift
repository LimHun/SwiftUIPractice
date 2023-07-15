//
//  MovableGridsView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/07/07.
//

import SwiftUI

struct MovableGridsView: View {
    
    @State private var colors: [Color] = [.red, .blue, .purple, .yellow, .black, .indigo, .cyan, .brown, .mint, .orange, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random, .random]
    @State private var draggingItem: Color?
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                let columrs = Array(repeating: GridItem(spacing: 10), count: 5)
                LazyVGrid(columns: columrs, spacing: 10) {
                    ForEach(colors, id: \.self) { color in
                        GeometryReader { _ in
                            // let size = $0.size
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(color.gradient)
                                .draggable(color) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.ultraThinMaterial)
                                        .frame(width: 1, height: 1)
                                        .onAppear {
                                            draggingItem = color
                                        }
                                }
                                .dropDestination(for: Color.self) { items, location in
                                    draggingItem = nil
                                    return false
                                } isTargeted: { status in
                                    if let draggingItem, status, draggingItem != color {
                                        if let sourceIndex = colors.firstIndex(of: draggingItem),
                                           let destinationIndex = colors.firstIndex(of: color) {
                                            withAnimation {
                                                let sourceItem = colors.remove(at: sourceIndex)
                                                colors.insert(sourceItem, at: destinationIndex)
                                            }
                                        }
                                    }
                                }
                        }
                        .frame(height: 100)
                    }
                }
            }
            .padding(15)
        }
        .navigationTitle("Movable Grid")
    }
}

struct MovableGridsView_Previews: PreviewProvider {
    static var previews: some View {
        MovableGridsView()
    }
}
