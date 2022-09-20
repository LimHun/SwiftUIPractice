//
//  FoodDeliveryHome.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/17.
//

import SwiftUI

struct FoodDeliveryHome: View {
    @State var currentIndex : Int = 0
    
    var body: some View {
        VStack{
            HeaderView()
            
            // MARK: Attributed Text's
            VStack(alignment: .leading) {
                Text(attributedTitle)
                    .font(.largeTitle.bold())
                Text(attributedSubTitle)
                    .font(.largeTitle.bold())
            }
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            GeometryReader { proxy in
                let size = proxy.size
                CarouselView(size: size)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background{
            Color("LightGreen")
                .ignoresSafeArea()
        }
    }
    
    // MARK: MilkShake Carousel View
    @ViewBuilder
    func CarouselView(size: CGSize) -> some View {
        VStack{
            // 여기서 중단
        }
    }
    
    // MARK: Header View
    @ViewBuilder
    func HeaderView() -> some View {
        HStack{
            Button {
                
            } label: {
                HStack(spacing: 10) {
                    Image("Hun")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                    
                    Text("Tunko")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    
                }
                .padding(.leading, 8)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background {
                    Capsule()
                        .fill(Color("LightGreen-1"))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                
            } label: {
                Image(systemName: "cart")
                    .font(.title2)
                    .foregroundColor(.black)
                    .overlay(alignment: .topTrailing) {
                        Circle()
                            .fill(.red)
                            .frame(width: 10, height: 10)
                            .offset(x: 2, y: -5)
                    }
            }

        }
        .padding(15)
    }
    
    var attributedTitle: AttributedString {
        var attString = AttributedString(stringLiteral: "Good Food,")
        if let range = attString.range(of: "Food,") {
            attString[range].foregroundColor = .white
        }
        return attString
    }
    
    var attributedSubTitle: AttributedString {
        var attString = AttributedString(stringLiteral: "Good Mood.")
        if let range = attString.range(of: "Good") {
            attString[range].foregroundColor = .black
        }
        return attString
    }
}

struct FoodDeliveryHome_Previews: PreviewProvider {
    static var previews: some View {
        FoodDeliveryHome()
    }
}
