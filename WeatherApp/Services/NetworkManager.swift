//
//  AppDelegate.swift
//  PryanikiApp
//
//  Created by Vladimir Izmaylov on 23.08.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()

    private init() {}
    
    func fetchData<T: Decodable>(from url: String?, with completion: @escaping(T) -> Void) {
            guard let url = URL(string: url ?? "") else { return }
    
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else {
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
    
                do {
                    let weatherData = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(weatherData)
                    }
                } catch let error {
                    print(error)
                }
            }.resume()
        }
}
