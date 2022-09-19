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
            guard let url = URL(string: url ?? "") else {
                completion(.failure("Bad url"))
                return }
    
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                DispatchQueue.main.async {
                    completion( Result { try JSONDecoder().decode(T.self, from: data!) })
                }
                
            }.resume()

    }
}
