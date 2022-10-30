//
//  APIService.swift
//  Dad Jokes
//
//  Created by Stewart Lynch on 2022-03-09.
//

import Foundation
class APIService {
     let urlString: String
     
     init(urlString: String) {
         self.urlString = urlString
    }
    
    private var decodedData = BulbDecoder(status: "", ok: "")
    
    func getJSON() async throws -> BulbDecoder {
        guard
            urlString != ""
        else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: URL(string: urlString)!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
                print(String(data: data, encoding: .utf8)!)
//            if let data = data {
//                if let decodedData = try? JSONDecoder().decode(BulbDecoder.self, from: data) {
//                    print("decodedData")
//                    print(decodedData)
//                } else {
//                    print("Invalid Response")
//                }
//            } else if let error = error {
//                print("HTTP Request Failed \(error)")
//            }
        }
        task.resume()
        return decodedData

//            let (data, response) = URLSession.shared.dataTask(with: request)
//            guard
//                let httpResponse = response as? HTTPURLResponse,
//                httpResponse.statusCode == 200
//            else {
//                throw APIError.invalidResponseStatus
//            }
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = dateDecodingStrategy
//            decoder.keyDecodingStrategy = keyDecodingStrategy
//            do {
//                let decodedData = try decoder.decode(T.self, from: data)
//                return decodedData
//            } catch {
//                throw APIError.decodingError(error.localizedDescription)
//            }
//        } catch {
//            throw APIError.dataTaskError(error.localizedDescription)
//        }
    }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The endpoint URL is invalid", comment: "")
        case .invalidResponseStatus:
            return NSLocalizedString("The APIO failed to issue a valid response.", comment: "")
        case .dataTaskError(let string):
            return string
        case .corruptData:
            return NSLocalizedString("The data provided appears to be corrupt", comment: "")
        case .decodingError(let string):
            return string
        }
    }
}
