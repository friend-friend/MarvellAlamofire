//
//  NetworkError.swift
//  MarvellAlamofire
//
//  Created by Вячеслав Онучин on 19.03.2023.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL = "INVALID URL"
    case errorDecod = "The data has not been decrypted"
}
