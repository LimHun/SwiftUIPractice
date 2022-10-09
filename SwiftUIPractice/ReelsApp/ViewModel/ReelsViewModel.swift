//
//  ReelsViewModel.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/08.
//

import SwiftUI
import AVFoundation
import Combine

enum NetworkError: Error {
    case invalidRequestError(String)
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

class ReelsViewModel : ObservableObject {
    
    @Published var reels : ReelsBody?
    @Published var reelsList : [ReelsItem] = []
    @Published var reelsPlayer : [AVPlayer] = []
    
//    @Published var usernameMessage: String = ""
//    @Published var isValid: Bool = false
//
//    private lazy var isReels : AnyPublisher<Bool, Never> = {
//        $reels
//            .flatMap { reels -> AnyPublisher<Bool, Never> in
//                self.requestFeedList()
//            }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }()
//
//    init() {
//        isReels
//            .map { $0 ? "" : "Username not available. Try a different one."}
//            .assign(to: &$usernameMessage)
//    }
//
//    func requestFeedList() -> AnyPublisher<Bool, Never> {
//        let urlString = "http://52.78.124.248:3456/api/public/feed/list?select_type=all&latitude=37.536977&longitude=126.955242&km=1000&category=65535&ad_product_uid=0&video_uid=0&random_seed=133q1234&offset=0"
//        guard let url = URL(string: urlString) else {
//            return Just(false).eraseToAnyPublisher()
//        }
//
//        // URLSession.shared.dataTaskPublisher 은 요청을 수행하는데 사용함
//        // 이 퍼블리셔는 일회성 퍼블리셔이며 데이터가 도착하면 이벤트를 내보냅니다.
//        // 구독자가 없으면 Combine 게시자는 아무 작업도 수행하지 않는다는 점을 염두에 두는것이 좋습니다.
//        // 즉, 이 게시자는 구독자가 한명 이상인 경우가 아니면 지정된 URL에 대한 호출을 수행하지 않습니다.
//        // 나중에 이 파이프 라인을 UI에 연결하고 사용자가 선호하는 사용자 이름을 입력할 때마다 호출되도록 하는 방법을 보여드리겠습니다.
//        return URLSession.shared.dataTaskPublisher(for: url)
//        // 요청이 반환되면 퍼블리셔는 data및 response 포함하는 값을 내보냅니다.
//        // 이 줄에서 map 연산자를 사용하여 이 결과를 변환합니다.
//        // 보시다 시피 몇가지 작은 변경 사항을 제외하고는 이전 버전에 코드에서 대부분 데이터 맵핑 코드를 재사용할 수 있습니다.
//            .map { data, response in
//                do {
//                    let decoder = JSONDecoder()
//                    let decodeData = try decoder.decode(ReelsBody.self, from: data)
//                    print(decodeData.url)
//                    // completion 클로저를 호출하는 대신 Boolean사용자 이름을 계속 사용할 수 있는지 여부를 나타내는 값을 반환할 수 있습니다. 이 값은 파이프라인을 통해 전달됩니다.
//                    return true
//                }
//                catch {
//                    // 데이터 매핑이 실패할 경우 오류를 포착하고 반환 false합니다. 이는 좋은 절충안인것 같습니다.
//                    return false
//                }
//            }
//        // 네트워크에 엑세스 할 때 발생할 수 있는 오류에 대해서도 동일한 작업을 수행합니다.
//        // 이것은 우리가 나중에 다시 방문할 수도 있는 단순화 있습니다. 에러 예외처리 추가로 수정 해야할 가능성이 있습니다.
//            .replaceError(with: false)
//            .eraseToAnyPublisher()
//    }
    
    // 일반적인 네트워크 요청 코드
//    func requestFeedList(completion: @escaping (Result<Bool, NetworkError>) -> Void) {
//        let urlString = "http://52.78.124.248:3456/api/public/feed/list?select_type=all&latitude=37.536977&longitude=126.955242&km=1000&category=65535&ad_product_uid=0&video_uid=0&random_seed=133q1234&offset=0"
//        guard let url = URL(string: urlString) else {
//            completion(.failure(.invalidRequestError("URL invalid")))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(.transportError(error)))
//                return
//            }
//
//            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
//                completion(.failure(.serverError(statusCode: response.statusCode)))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let decodeData = try decoder.decode(ReelsBody.self, from: data)
//                completion(.success(true))
//            }
//            catch {
//                completion(.failure(.decodingError(error)))
//            }
//        }
//
//        task.resume()
//    }
    
    // 1차 async await 사용
    init() {
        Task.init {
            await requestFeedList()
        }
    }
    
    func requestFeedList(_ offset : Int = 0) async {
        do {
            let requestURL = "\(WeegleServer.url)/api/public/feed/list?select_type=all&latitude=37.536977&longitude=126.955242&km=1000&category=65535&ad_product_uid=0&video_uid=0&random_seed=133q1234&offset=\(offset)"
            
            guard let url = URL(string: requestURL) else {
                fatalError("Missing URL")
            }
            
            let urlRequest = URLRequest(url: url)
            //urlRequest.setValue(apiToken, forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
            }
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error while fetching data")
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodeData = try decoder.decode(ReelsBody.self, from: data)
            
            print(decodeData)
            DispatchQueue.main.async {
                
                if offset == 0 {
                    self.reelsList.removeAll()
                }
                
                for i in 0..<decodeData.item.count {
                    let url = URL(string: "\(WeegleServer.convertedAWS)/\(decodeData.item[i].videoFilename)")
                    let avPlayer = AVPlayer(url: url!)
                    var item = decodeData.item[i]
                    item.avPlayer = avPlayer
                    self.reelsList.append(item)
                }
            }
        } catch {
            print("Error fetch data from pexels : \(error)")
        }
    }
}
