//
//  TestView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/28.
//

import SwiftUI

struct FruitType : Identifiable{
    var id = UUID()
    var fruitName : String
}

struct TestView: View {
    //var array : [String] = ["🍎", "🥝", "🍐", "🍊", "🍏", "🍒", "🍉", "🍇", "🫐"]
    
    var array : [FruitType] = [FruitType(fruitName: "🍎"),
                               FruitType(fruitName: "🥝"),
                               FruitType(fruitName: "🍐"),
                               FruitType(fruitName: "🍊"),
                               FruitType(fruitName: "🍏"),
                               FruitType(fruitName: "🍒"),
                               FruitType(fruitName: "🍉"),
                               FruitType(fruitName: "🍇"),
                               FruitType(fruitName: "🫐")]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(array) { fruit in
                Text("array: \(fruit.fruitName)")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
