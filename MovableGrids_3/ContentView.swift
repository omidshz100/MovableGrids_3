//
//  ContentView.swift
//  MovableGrids_3
//
//  Created by Omid Shojaeian Zanjani on 26/01/24.
//

import SwiftUI

struct ContentView: View {
    // ❓ why ignore repeatitive color
    @State private var colors:[Color] = [.red,.green,.blue,.orange,.yellow,.brown,.accentColor,.cyan,.indigo,.mint]
    @State private var draggingItem:Color?
    
    
    var body: some View {
        NavigationStack{
            VStack{
                
                ScrollView{
                    let columns = Array(repeating: GridItem(spacing:10), count: 3)
                    LazyVGrid(columns: columns, spacing: 10) {
                        // ❓ When I use GeometryReader for content behaviour of scrollview fails, why?
                        ForEach(colors, id: \.self){ colorItem in
                            GeometryReader{
                                let size = $0.size
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(colorItem.gradient)
                                // note modifier draggable accept any confomed to trasfable like Color or any custom
                                    .draggable(colorItem){
                                        // custom preview view designed here
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .fill(.ultraThinMaterial)
                                            .frame(width: 1, height: 1)
                                            .onAppear(){
                                                draggingItem = colorItem
                                            }
                                    }
                                // Drop destination
                                    .dropDestination(for: Color.self) { items, location in
                                        draggingItem = nil
                                        return false
                                    } isTargeted: { status in
                                        if let draggingItem, status, draggingItem != colorItem {
                                            if let sourceIndex = colors.firstIndex(of: draggingItem), let destinationIndex = colors.firstIndex(of: colorItem) {
                                                
                                                withAnimation(.bouncy) {
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
                    .padding(15)
                }
                .navigationTitle("Movable Grid")
            }
        }
    }
}

#Preview {
    ContentView()
}
