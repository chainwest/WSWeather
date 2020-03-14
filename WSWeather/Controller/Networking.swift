//
//  Networking.swift
//  WSWeather
//
//  Created by Evgeniy on 13.03.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    
    private func baseRequest<T>(ofType: T.Type, method: HTTPMethod, url: String,
                                parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default,
                                completion: @escaping (Swift.Result<T, Error>) -> Void) where T: Codable {
        
        AF.request(url, method: method, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()

                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(Swift.Result.success(decodedData))
                } catch let error {
                    completion(Swift.Result.failure(error))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWeatherByCity(parameters: [String : String], completion: @escaping (Swift.Result<WeatherModel, Error>) -> Void) {
        baseRequest(ofType: WeatherModel.self, method: .get, url: Constants.url, parameters: parameters) { response in
            completion(response)
        }
    }
}
