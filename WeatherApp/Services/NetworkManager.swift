//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.06.2022.
//

import Foundation

// MARK: - Class

final class NetworkManager {
    
    // MARK: - Internal properties
    
    static let shared = NetworkManager()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Internal methods
    
    func fetchData<T: Decodable>(from url: String?, with completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure("Bad url"))
            return
        }
        
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
