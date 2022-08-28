//
//  CustomCarousel.swift
//  Carousel
//
//  Created by tunko on 2022/08/22.
//

import SwiftUI

struct CustomCarousel<Content: View, Item, ID>: View where Item: RandomAccessCollection, ID: Hashable, Item.Element: Equatable {

    var content: (Item.Element, CGSize) -> Content
    var id : KeyPath<Item.Element, ID>

    // MARK: View Properties
    var spacing: CGFloat
    var cardPadding: CGFloat
    var items: Item
    @Binding var index: Int

    init(index: Binding<Int>, items: Item, spacing: CGFloat = 30, cardPadding: CGFloat = 80, id: KeyPath<Item.Element, ID>,
         @ViewBuilder content: @escaping (Item.Element, CGSize) -> Content) {
        self.content = content
        self.id = id
        self._index = index
        self.spacing = spacing
        self.cardPadding = cardPadding
        self.items = items
    }

    // MARK: Gesture Properties
    @GestureState var translation: CGFloat = 0
    @State var offset : CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0

    @State var currentIndex: Int = 0

    // MARK: rotation
    @State var rotation: Double = 0

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let cardWidth = size.width - (cardPadding - spacing)
            LazyHStack(spacing: spacing) {
                ForEach(items, id: id) { movie in
                    // Since We Already Applied Spacing
                    // And Again We're Adding it to Frame
                    // So Simply Removing the Spacing
                    let index = indexOf(item: movie)
                    content(movie, CGSize(width: size.width - cardPadding, height: size.height))
                        // MARK: Rotating Each View 5 Deg Multiplied With it's Index
                        // And While Scrolling Setting it to 0, thus it will give some nice Circular Carousel Effect
                        .rotationEffect(.init(degrees: Double(index) * 5), anchor: .bottom)
                        .rotationEffect(.init(degrees: rotation), anchor: .bottom)
                        // MARK: Apply After Rotation, Thus you will get smooth Effect
                        .offset(y: offestY(index: index, cardWidth: cardWidth))
                        .frame(width: size.width - cardPadding, height: size.height)
                        .contentShape(Rectangle())
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: offset)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 5)
                    .updating($translation, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onChanged{ onChange(value: $0, cardWidth: cardWidth) }
                    .onEnded{ onEnd(Value: $0, cardWidth: cardWidth)}
            )
        }
        .padding(.top, 60)
        .onAppear {
            let extraSpace = (cardPadding / 2) - spacing
            offset = extraSpace
            lastStoredOffset = offset
        }
        .animation(.easeInOut, value: translation == 0)
    }

    // MARK: Moving Current Item UP
    func offestY(index: Int, cardWidth: CGFloat) -> CGFloat {

        // MARK: We're converting the current Translation, Not Whole Offset
        // That's Why Created @GestureState to Hold the Current Translation Data

        // Converting Translation to -60...60
        let progress = ((translation < 0 ? translation : -translation) / cardWidth) * 60
        let yOffset = -progress < 60 ? progress : -(progress + 120)

        // MARK: Checking Provious, Next And In-Between Offsets
        let previous = (index - 1) == self.index ? (translation < 0 ? yOffset : -yOffset) : 0
        let next = (index + 1) == self.index ? (translation < 0 ? -yOffset : yOffset) : 0
        let In_Between = (index - 1) == self.index ? previous : next

        return index == self.index ? -60 - yOffset : In_Between
    }

    // MARK: Item Index
    func indexOf(item: Item.Element) -> Int {
        let array = Array(items)
        if let index = array.firstIndex(of: item) {
            return index
        }
        return 0
    }

    // MARK: Limiting Scroll On First And Last Items
    func limitScroll() -> CGFloat {
        let extraSpace = (cardPadding / 2) - spacing
        if index == 0 && translation > extraSpace {
            return extraSpace + (offset / 4)
        } else if index == items.count - 1 && translation < 0 {
            return offset - (translation / 2)
        } else {
            return offset
        }
    }

    func onChange(value: DragGesture.Value, cardWidth: CGFloat) {
        let translationX = value.translation.width
        offset = translationX + lastStoredOffset

        let progress = offset / cardWidth
        rotation = progress * 5
    }

    func onEnd(Value:DragGesture.Value, cardWidth: CGFloat) {
        var _index = (offset / cardWidth).rounded()
//        print("offset : \(offset)")
//        print("offset / cardWidth : \((offset / cardWidth))")
//        print("offset / cardWidth . rounded: \(_index)")

        _index = max(-CGFloat(items.count - 1), _index)
        _index = min(_index, 0)

        currentIndex = (Int)(_index)

        // MARK: Updating Index
        // Note Since We're Moving On Right Side
        // So All Data Will be Nagative
        index = -currentIndex

        withAnimation {
            // MARK: Removing Extra Space
            // Why / 2 -> Because We Need Both Sides Need To Be Visible
            let extraSpace = (cardPadding / 2) - spacing
            offset = (cardWidth * _index) + extraSpace

            let progress = offset / cardWidth
            rotation = (progress * 5).rounded() - 1
            print(rotation)
        }
        print(offset)
        lastStoredOffset = offset
    }
}

struct CustomCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
