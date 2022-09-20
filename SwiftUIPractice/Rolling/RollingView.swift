//
//  RollingView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/20.
//

import SwiftUI

struct RollingView: View {
//    @State var value: Int = 111
    @State var numberId : Int = 0
    
    @State var values : [Int] = [1,2,3,4,5,6,7,8,9,10]
    
    var body: some View {
        VStack{
            ForEach(values.indices, id : \.self) { index in
                RollingText(font: .system(size: 55), weight: .black, value: $values[index]).id(numberId)
            }
            
            Button("Change Value") {
                for (index, _) in values.enumerated() {
                    values[index] = .random(in: 0...90000000)
                }
            }
        }
        .padding()
        .navigationTitle("Rolling Counter")
    }
}

struct RollingView_Previews: PreviewProvider {
    static var previews: some View {
        RollingView()
    }
}
