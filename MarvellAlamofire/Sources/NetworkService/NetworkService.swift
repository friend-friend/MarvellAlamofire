//
//  NetworkService.swift
//  MarvellAlamofire
//
//  Created by Вячеслав Онучин on 19.03.2023.
//

import Foundation
import CryptoKit
import Alamofire

protocol NetworkServiceProtocol {
    func addURL() -> URL?
    func getData(url: URL?, completion: @escaping (Result<MarvellAnswer, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    func addURL() -> URL? {
        let publicKey = "c3f19d6c9d8a5d5d80896fd1c124fc4f"
        let privetKey = "0acbef5810deab200955f0efa0acce136d7e6bd2"
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(ts)\(privetKey)\(publicKey)")
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.path = "/v1/public/characters"
        components.queryItems =
        [
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]
        return components.url
    }
    
    func getData(url: URL?, completion: @escaping (Result<MarvellAnswer, NetworkError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        let request = AF.request(url)
        request.validate()
        request.responseDecodable(of: MarvellAnswer.self) { data in
            guard let data = data.value else {
                completion(.failure(.errorDecod))
                return
            }
            completion(.success(data))
        }
    }
}
