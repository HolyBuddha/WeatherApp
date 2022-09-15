//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.06.2022.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(from url: String?, with completion: @escaping (Result<T, Error>) -> Void) {
            guard let url = URL(string: url ?? "") else { return }
    
            URLSession.shared.dataTask(with: url) { data, _, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                DispatchQueue.main.async {
                    completion( Result{ try JSONDecoder().decode(T.self, from: data!) })
                }
                
            }.resume()
//                guard let data = data else {
//                    print(error?.localizedDescription ?? "No error description")
//                    return
//                }
//
//                do {
//                    let weatherData = try JSONDecoder().decode(T.self, from: data)
//                    DispatchQueue.main.async {
//                        completion(weatherData)
//                    }
//                } catch let error {
//                    print(error)
//                    completion(.failure(error))
//                }
//            }.resume()
//        }
//    URLSession.shared.dataTask(with: url) { (data, _, error) in
//           if let error = error { completion(.failure(error)); return }
//           completion( Result{ try JSONDecoder().decode(T.self, from: data!) })
//       }.resume()
    }
}
