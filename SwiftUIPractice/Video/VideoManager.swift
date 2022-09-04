//
//  VideoManager.swift
//  Liberopia
//
//  Created by tunko on 2022/08/24.
//

import Foundation

enum Query: String, CaseIterable {
    case nature, animals, people, ocean, food
}

let apiToken : String = "563492ad6f9170000100000151ddee10d23e42b89502a3591245af3d"

class VideoManager : ObservableObject {

    @Published var videos : [Video] = []
    @Published var selectedQuery: Query = Query.nature {
        // 변수 변경시 마다 api 신규 호출하도록 함
        didSet {
            Task.init {
                // api 호출
                await findVideos(topic: selectedQuery)
            }
        }
    }

    var page : Int = 1  // 페이지
    var per_page : Int = 15 // 페이지당 데이터 수

    // findVideos는 비동기 함수이기 때문에 init 함수 안에 Task dot init를 추가해야 합니다.
    init() {
        Task.init {
            await findVideos(topic: selectedQuery)
        }
    }

    func nextPage() {
        page += 1
        Task {
            await findVideos(topic: selectedQuery)
        }
    }

    func findVideos(topic: Query) async {
        do {
//            guard let url = URL(string: "https://api.pexels.com/videos/search?query=\(topic)&per_page=1&orientation=portrait") else {
//                fatalError("Missing URL")
//            }

            guard let url = URL(string: "https://api.pexels.com/videos/search?query=\(topic)&page=\(page)&per_page=\(per_page)&orientation=portrait&size=small") else {
                fatalError("Missing URL")
            }


            var urlRequest = URLRequest(url: url)
            urlRequest.setValue(apiToken, forHTTPHeaderField: "Authorization")

            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error while fetching data")
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodeData = try decoder.decode(ResponseBody.self, from: data)

            print(decodeData)

            DispatchQueue.main.async {
                if self.page == 1 {
                    self.videos = []
                    self.videos = decodeData.videos
                } else {
                    self.videos += decodeData.videos
                }

            }
        } catch {
            print("Error fetch data from pexels : \(error)")
        }
    }
}

struct ResponseBody : Decodable {
    var page : Int
    var perPage : Int
    var totalResults: Int
    var url : String
    var videos: [Video]
}

struct Video: Identifiable, Decodable {
    var id: Int
    var image: String
    var duration: Int
    var user: User
    var videoFiles: [VideoFile]

    struct User: Identifiable, Decodable {
        var id: Int
        var name: String
        var url: String
    }

    struct VideoFile: Identifiable, Decodable {
        var id: Int
        var quality: String
        var fileType: String
        var link: String
    }
}

/**
 {
   "total_results": 10000,
   "page": 1,
   "per_page": 1,
   "photos": [
     {
       "id": 3573351,
       "width": 3066,
       "height": 3968,
       "url": "https://www.pexels.com/photo/trees-during-day-3573351/",
       "photographer": "Lukas Rodriguez",
       "photographer_url": "https://www.pexels.com/@lukas-rodriguez-1845331",
       "photographer_id": 1845331,
       "avg_color": "#374824",
       "src": {
         "original": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png",
         "large2x": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
         "large": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=650&w=940",
         "medium": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=350",
         "small": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=130",
         "portrait": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
         "landscape": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
         "tiny": "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
       },
       "liked": false,
       "alt": "Brown Rocks During Golden Hour"
     }
   ],
   "next_page": "https://api.pexels.com/v1/search/?page=2&per_page=1&query=nature"
 }

 */
