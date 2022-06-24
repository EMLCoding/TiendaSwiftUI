//
//  StaggeredGrid.swift
//  Tienda
//
//  Created by Eduardo Martin Lorenzo on 23/6/22.
//

import SwiftUI

struct StaggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {
    var content: (T) -> Content
    var list: [T]
    var showIndicators: Bool
    var spacing: CGFloat
    var columns: Int
    
    init(list: [T], showIndicators: Bool, spacing: CGFloat = 20, columns: Int, @ViewBuilder content: @escaping (T)->Content) {
        self.content = content
        self.list = list
        self.showIndicators = showIndicators
        self.spacing = spacing
        self.columns = columns
    }
    
    func setUpList() -> [[T]] {
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        var currentIndex: Int = 0
        
        for object in list {
            gridArray[currentIndex].append(object)
            
            if currentIndex == (columns - 1) {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        
        return gridArray
    }
    
    func getIndex(values: [T]) -> Int {
        let index = setUpList().firstIndex { t in
            return t == values
        } ?? 0
        
        return index
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            ForEach(setUpList(), id: \.self) { columnsData in
                LazyVStack(spacing: spacing) {
                    ForEach(columnsData) { object in
                        content(object)
                    }
                }
                .padding(.top, getIndex(values: columnsData) == 1 ? 80 : 0)
            }
        }
        .padding(.vertical)
    }
}
