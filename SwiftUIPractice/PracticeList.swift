//
//  PracticeList.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/27.
//

import SwiftUI

struct CustomViewType: Identifiable {
    let id: UUID = UUID()
    var anyView: AnyView
}

struct PracticeList: View {
    
    let practiceViews: [Any] = [
        TinderHome.self,
        SnapCarouselCardView.self,
        DynamicTabView.self,
        Bingo.self,
        Test.self,
        TextFieldView.self,
        SafariView.self,
        ParallaxScrollEffectView.self,
        ParallaxScrollEffectView2.self,
        SpotifyHeaderAnimationView.self,
        ShimmerView.self,
        ListColorChange.self,
        VideoGridView.self,
        CarouselView.self,
        StockView.self,
        TouchAnimationView.self,
        TikTokView.self,
        MovieVerticalView.self,
        ReelsApp.self,
        StickyContentView.self,
        ResponsiveContent.self,
        FoodDeliveryHome.self,
        RollingView.self,
        VideoPlayerTest.self,
        VideoNavi.self,
        AutoFocusTextFeild.self,
        CoreLoactionUI.self, 
        MultiView.self,
        LandingScreenView.self,
        GestureTest.self,
        EnvironmentTest.self,
        ProSwiftUIView.self,
        SnapCarouselView.self,
        BottomSheet.self,
        SplashScreen.self,
        TimerView.self,
        IntroView.self,
        OTPView.self,
        ExPhotoPickerView.self,
        TaskManagementApp.self,
        DropDownView.self,
        NativePopovers.self,
        SpotifyResponvieUI.self,
        OnBoardingScreen.self,
        OnBoardingSlideView.self,
        TextTapView.self,
        MovableGridsView.self
    ]
    
    func buildView(types: [Any], index: Int) -> (AnyView, isNaviBar: Bool) {
        switch types[index].self {
        case is TinderHome.Type:
            return (AnyView(TinderHome()), true)
        case is SnapCarouselCardView.Type:
            return (AnyView(SnapCarouselCardView()), true)
        case is DynamicTabView.Type:
            return (AnyView(DynamicTabView()), true)
        case is Bingo.Type:
            return (AnyView(Bingo()), true)
        case is Test.Type:
            return (AnyView(Test()), true)
        case is TextFieldView.Type:
            return (AnyView(TextFieldView()), true)
        case is SafariView.Type:
            return (AnyView(SafariView(url: URL(string: "https://product.kyobobook.co.kr/detail/S000001913217")!)), true)
        case is ParallaxScrollEffectView2.Type:
            return (AnyView(ParallaxScrollEffectView2()), true)
        case is ParallaxScrollEffectView.Type:
            return (AnyView(ParallaxScrollEffectView()), true)
        case is SpotifyHeaderAnimationView.Type:
            return (AnyView(SpotifyHeaderAnimationView()), true)
        case is ShimmerView.Type:
            return (AnyView(ShimmerView()), true)
        case is ListColorChange.Type:
            return (AnyView( ListColorChange()), true)
        case is VideoGridView.Type:
            return (AnyView( VideoGridView()), true)
        case is CarouselView.Type:
            return (AnyView( CarouselView()), true)
        case is StockView.Type:
            return (AnyView( StockView()), true)
        case is TouchAnimationView.Type:
            return (AnyView( TouchAnimationView()), true)
        case is TikTokView.Type:
            return (AnyView( TikTokView()), true)
        case is MovieVerticalView.Type:
            return (AnyView( MovieVerticalView()), true)
        case is ReelsApp.Type:
            return (AnyView( ReelsApp()), true)
        case is StickyContentView.Type:
            return (AnyView( StickyContentView()), true)
        case is ResponsiveContent.Type:
            return (AnyView( ResponsiveContent()), true)
        case is FoodDeliveryHome.Type:
            return (AnyView( FoodDeliveryHome()), true)
        case is RollingView.Type:
            return (AnyView( RollingView()), true)
        case is VideoPlayerTest.Type:
            return (AnyView( VideoPlayerTest()), true)
        case is VideoNavi.Type:
            return (AnyView( VideoNavi()), true)
        case is AutoFocusTextFeild.Type:
            return (AnyView( AutoFocusTextFeild()), true)
        case is CoreLoactionUI.Type:
            return (AnyView( CoreLoactionUI()), true)
        case is EnvironmentTest.Type:
            return (AnyView( EnvironmentTest()), true)
        case is MultiView.Type:
            return (AnyView( MultiView()), true)
        case is LandingScreenView.Type:
            return (AnyView( LandingScreenView()), true)
        case is GestureTest.Type:
            return (AnyView(GestureTest()), true)
        case is ProSwiftUIView.Type:
            return (AnyView(ProSwiftUIView()), true)
        case is SnapCarouselView.Type:
            return (AnyView(SnapCarouselView()), true)
        case is BottomSheet.Type:
            return (AnyView(BottomSheet()), true)
        case is SplashScreen.Type:
            return (AnyView(SplashScreen()), true)
        case is TimerView.Type:
            return (AnyView(TimerView()), true)
        case is IntroView.Type:
            return (AnyView(IntroView()), true) 
        case is OTPView.Type:
            return (AnyView(OTPView()), true)
        case is ExPhotoPickerView.Type:
            return (AnyView(ExPhotoPickerView()), true)
        case is TaskManagementApp.Type:
            return (AnyView(TaskManagementApp()), true)
        case is DropDownView.Type:
            return (AnyView(DropDownView()), true)
        case is NativePopovers.Type:
            return (AnyView(NativePopovers()), true)
        case is SpotifyResponvieUI.Type:
            return (AnyView(SpotifyResponvieUI().preferredColorScheme(.dark)), true)
        case is OnBoardingScreen.Type:
            return (AnyView(OnBoardingScreen()), true)
        case is OnBoardingSlideView.Type:
            return (AnyView(OnBoardingSlideView()), true)
        case is TextTapView.Type:
            return (AnyView(TextTapView()), true)
        case is MovableGridsView.Type:
            return (AnyView(MovableGridsView()), true)
        default: return (AnyView(EmptyView()), true)
        }
    }
    
    @State private var selectedItem: String = ""
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<practiceViews.count, id: \.self) { index in
                    
                    let studyTitle: String = String(describing: practiceViews[index])
                    NavigationLink {
                        buildView(types: practiceViews, index: index).0
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarTitle(studyTitle)
                            .navigationBarHidden(buildView(types: practiceViews, index: index).isNaviBar)
                            .onAppear {
                                isActive = true
                            }.onDisappear {
                                isActive = false
                            }
                    } label: {
                        Text(studyTitle)
                    }
                }
            }
            .listStyle(.automatic)
            .navigationBarBackButtonHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PracticeList_Previews: PreviewProvider {
    static var previews: some View {
        PracticeList()
    }
}
