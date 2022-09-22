//
//  AutoFocusTextFeild.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/22.
//

import SwiftUI

struct feildModel : Identifiable {
    var id = UUID()
    var text : String
    var placeHolder : String
    var color : Color
    var fieldFocus : FieldFocus
}

enum FieldFocus : Int {
    case feild1 = 0
    case feild2 = 1
    case feild3 = 2
    case feild4 = 3
    case feild5 = 4
    case feild6 = 5
    case feild7 = 6
}

class AutoFocusViewModel : ObservableObject {
    @Published var fields = [feildModel]()
    func setData() {
        fields = [feildModel(text: "", placeHolder: "placeHolder1", color: Color.red, fieldFocus : .feild1),
                  feildModel(text: "", placeHolder: "placeHolder2", color: Color.orange, fieldFocus : .feild2),
                  feildModel(text: "", placeHolder: "placeHolder3", color: Color.yellow, fieldFocus : .feild3),
                  feildModel(text: "", placeHolder: "placeHolder4", color: Color.green, fieldFocus : .feild4),
                  feildModel(text: "", placeHolder: "placeHolder5", color: Color.cyan, fieldFocus : .feild5),
                  feildModel(text: "", placeHolder: "placeHolder6", color: Color.blue, fieldFocus : .feild6),
                  feildModel(text: "", placeHolder: "placeHolder7", color: Color.purple, fieldFocus : .feild7)]
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct AutoFocusTextFeild: View {
    
    @StateObject var autoFocusViewModel = AutoFocusViewModel()
    @FocusState var focusedField : FieldFocus?

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView{
                VStack{
                    ForEach(0..<autoFocusViewModel.fields.count, id: \.self) { index in
                        TextField(autoFocusViewModel.fields[index].placeHolder, text: $autoFocusViewModel.fields[index].text)
                            .focused($focusedField, equals: autoFocusViewModel.fields[index].fieldFocus)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(Color.gray.opacity(0.1))
                            }
                            .border(.black)
                            .padding()
                            .onTapGesture {
                                withAnimation {
                                    proxy.scrollTo(index, anchor: .top)
                                }
                            }
                        Rectangle()
                            .fill(autoFocusViewModel.fields[index].color)
                            .frame(height: 300)
                            .id(index)
                    }
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            autoFocusViewModel.setData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.focusedField = .feild1
            }
        }
    }
}

struct AutoFocusTextFeild_Previews: PreviewProvider {
    static var previews: some View {
        AutoFocusTextFeild()
    }
}


