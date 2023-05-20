//
//  TestView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/28.
//

import SwiftUI

struct FruitType: Identifiable {
    var id = UUID()
    var fruitName: String
}

class Student: ObservableObject {
    var name: String
    init(name: String) {
        self.name = name
    }
}

struct TestView: View {
     
    @State var age: Int = 0
    @StateObject var student = Student(name: "name")
    
    var array: [FruitType] = [FruitType(fruitName: "🍎"),
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
            Button {
                age += 1
            } label: {
                Text("age add Button👍")
            }

        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
