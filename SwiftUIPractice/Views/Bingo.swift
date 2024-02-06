//
//  Bingo.swift
//  SwiftUIPractice
//
//  Created by tunko on 1/18/24.
//

import SwiftUI
 
struct Bingo: View {
    private var que: [String] = [
        "커피보다 차를 선호하는",
        "두 개 이상의 언어를 구사할 수 있는",
        "책을 한 달에 10페이지 이상 읽는",
        "악기를 연주할 수 있는",
        "자신의 블로그나 웹사이트를 가지고 있는",
        "영화 감상을 취미로 삼는",
        "명상이나 요가를 정기적으로 하는",
        "수제 공예품을 만들어본",
        "캠핑을 자주 가는",
        "사진 촬영을 취미로 삼는",
        "퍼즐이나 브레인 게임을 좋아하는",
        "고전 문학을 좋아하는",
        "외국에서 생활한 경험이 있는",
        "아침형 인간인",
        "늘 냉철한",
        "커피를 매우 자주 마시는",
        "아이디어가 많은",
        "비디오 게임을 즐겨 하는",
        "자신이 좋아하는 작가나 예술가가 있는",
        "고양이를 키우는",
        "강아지를 키우는",
        "테크놀로지나 기기에 관심이 많은",
        "취미로 운동을 하는",
        "이번주에 직접 요리를 해먹은",
        "자전거 타기를 취미로 삼는",
        "명상이나 요가 등 정신적 건강을 위한 활동을 하는",
        "패션과 스타일에 관심이 많은",
        "취미로 글을 쓰는 (예: 시, 소설, 블로그)",
        "사주, 별자리, 타로 등 점성술에 관심이 있는",
        "산책이나 하이킹을 자주 하는",
        "새로운 언어를 배우고 싶어하는",
        "자기계발 서적을 읽는",
        "다른 나라의 영화나 드라마를 즐겨 보는",
        "헤어스타일이나 패션을 자주 바꾸는",
        "보드게임이나 카드게임을 좋아하는",
        "애주가",
        "새벽 공부를 하는",
        "그림이나 스케치를 취미로 하는",
        "애완동물을 키우는",
        "1월에 생일이 있는",
        "2월에 생일이 있는",
        "3월에 생일이 있는",
        "4월에 생일이 있는",
        "5월에 생일이 있는",
        "6월에 생일이 있는",
        "7월에 생일이 있는",
        "8월에 생일이 있는",
        "9월에 생일이 있는",
        "10월에 생일이 있는",
        "11월에 생일이 있는",
        "12월에 생일이 있는",
        "혼자 여행을 즐기는",
        "책 읽기나 글쓰기와 같은 조용한 활동을 좋아하는",
        "MBTI '_ST_' 성향을 가진",
        "MBTI '__FJ' 성향을 가진",
        "MBTI 'I__J' 성향을 가진",
        "MBTI 'IN__' 성향을 가진",
        "MBTI '__TP' 성향을 가진",
        "MBTI 'I__P' 성향을 가진",
        "MBTI '__FP' 성향을 가진",
        "MBTI '_NT_' 성향을 가진",
        "MBTI 'ES__' 성향을 가진",
        "MBTI 'EN__' 성향을 가진",
        "MBTI '__TJ' 성향을 가진"
    ]
    
    @State private var questions: [String] = []
    @State private var draggingItem: String?
    private let screenWidth = UIScreen.main.bounds.size.width
    private let rawCount: CGFloat = 4
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    Text("PEOPLE BINGO")
                        .font(.system(size: 80))
                        .fontWeight(.heavy)
                    
                    HStack {
                        Text("NAME: ________")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                        Text("GROUP: ____")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                    }
                    let columrs = Array(repeating: GridItem(spacing: 10), count: Int(rawCount))
                    LazyVGrid(columns: columrs, spacing: 10) {
                        ForEach(questions, id: \.self) { question in
                            HStack {
                                VStack(spacing: 0) {
                                    
                                    Text(question)
                                        .font(.system(size: 30))
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 0) {
                                        Rectangle().fill(Color.white).frame(height: 100).border(.black)
                                        Rectangle().fill(Color.white).frame(height: 100).border(.black)
                                        Rectangle().fill(Color.white).frame(height: 100).border(.black)
                                    }
                                }
                            }
                            .frame(height: 220)
                            .border(1, .black)
                        }
                    }
                }
                .padding(20)
                Button(action: {
                    setQuestion()
                }, label: {
                    HStack {
                        Spacer()
                        Text("친해지길바래:) 팀빌딩 워크샵")
                            .font(.title)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .frame(height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.clear)
                            .border(1, .black)
                            
                    }
                })
                .padding(20)
            }
        }
        .navigationTitle("Movable Grid")
        .onAppear {
            setQuestion()
        }
        .statusBar(hidden: true)
    }
    
    func setQuestion() {
        withAnimation { questions = pickRandomItems(from: que, count: Int(rawCount * rawCount)) }
    }
     
    func pickRandomItems(from array: [String], count: Int) -> [String] {
        // 배열의 아이템 수가 요청된 개수보다 적은 경우, 빈 배열 반환
        guard array.count >= count else {
            print("Array does not contain enough items.")
            return []
        }

        // 배열에서 무작위로 'count' 개수만큼 아이템을 선택
        let randomItems = Array(array.shuffled().prefix(count))
        return randomItems
    }

}

#Preview {
    Bingo()
}
