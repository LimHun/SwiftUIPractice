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
    
    let practiceViews : [Any] = [ListColorChange.self,
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
                                 TestView.self,
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
                                 LoginView.self,
                                 SocialMediaView.self,
                                 OTPView.self]
    
    func buildView(types: [Any], index: Int) -> (AnyView, isNaviBar: Bool) {
        switch types[index].self {
        case is ListColorChange.Type:
            return (AnyView( ListColorChange()), false)
        case is VideoGridView.Type:
            return (AnyView( VideoGridView()), false)
        case is TestView.Type:
            return (AnyView( TestView()), false)
        case is CarouselView.Type:
            return (AnyView( CarouselView()), false)
        case is StockView.Type:
            return (AnyView( StockView()), false)
        case is TouchAnimationView.Type:
            return (AnyView( TouchAnimationView()), false)
        case is TikTokView.Type:
            return (AnyView( TikTokView()), false)
        case is MovieVerticalView.Type:
            return (AnyView( MovieVerticalView()), false)
        case is ReelsApp.Type:
            return (AnyView( ReelsApp()), false)
        case is StickyContentView.Type:
            return (AnyView( StickyContentView()), false)
        case is ResponsiveContent.Type:
            return (AnyView( ResponsiveContent()), false)
        case is FoodDeliveryHome.Type:
            return (AnyView( FoodDeliveryHome()), false)
        case is RollingView.Type:
            return (AnyView( RollingView()), false)
        case is VideoPlayerTest.Type:
            return (AnyView( VideoPlayerTest()), false)
        case is VideoNavi.Type:
            return (AnyView( VideoNavi()), false)
        case is AutoFocusTextFeild.Type :
            return (AnyView( AutoFocusTextFeild()), false)
        case is CoreLoactionUI.Type:
            return (AnyView( CoreLoactionUI()), false)
        case is EnvironmentTest.Type:
            return (AnyView( EnvironmentTest()), false)
        case is MultiView.Type:
            return (AnyView( MultiView()), false)
        case is LandingScreenView.Type:
            return (AnyView( LandingScreenView()), false)
        case is GestureTest.Type:
            return (AnyView(GestureTest()), false)
        case is ProSwiftUIView.Type:
            return (AnyView(ProSwiftUIView()), false)
        case is SnapCarouselView.Type:
            return (AnyView(SnapCarouselView()), false)
        case is BottomSheet.Type:
            return (AnyView(BottomSheet()), false)
        case is SplashScreen.Type :
            return (AnyView(SplashScreen()), false)
        case is TimerView.Type:
            return (AnyView(TimerView()), false)
        case is IntroView.Type:
            return (AnyView(IntroView()), false)
        case is LoginView.Type:
            return (AnyView(LoginView()), false)
        case is SocialMediaView.Type:
            return (AnyView(SocialMediaView()), true)
        case is OTPView.Type:
            return (AnyView(OTPView()), false)
        default: return (AnyView(EmptyView()), false)
        }
    }
    
    @State private var selectedItem: String = ""
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<practiceViews.count, id: \.self) { index in
                    
                    let studyTitle : String = String(describing: practiceViews[index])
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
