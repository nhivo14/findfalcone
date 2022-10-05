//
//  NetworkService.swift
//  FindingFalcone
//
//  Created by NhiVHY on 04/10/2022.
//

import Foundation
import Alamofire

class NetworkService {
//    let header: HTTPHeaders = ["Accept" : "application/json"]

    private func makeRequest<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters? = nil, header: HTTPHeaders? = nil, completion: @escaping (Result<T?, AFError>) -> Void) {
        AF.request(url, method: method, parameters: parameters, headers: header).response { response in
            switch response.result {
            case .failure (let error):
                completion(.failure(error))
            case .success (let data):
                guard let data = data else {
                    completion(.success(nil))
                    return
                }
                do {
                    let dataRespnse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(dataRespnse))
                } catch {
                    print("Decode failed...")
                    completion(.success(nil))
                }
            }
        }
    }
    
}

extension NetworkService {
    func findFalcone(body: DataRequest, completion: @escaping (Result<FinalResult?, AFError>) -> Void) {
        let url = "https://findfalcone.herokuapp.com/find"
        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/json")]
        let params = ["token" : body.token, "planet_names" : body.planet_names, "vehicle_names" : body.vehicle_name] as [String : Any]
        makeRequest(url: url, method: .post, parameters: params, header: headers) { (result: Result<FinalResult?, AFError>) in
            completion(result)
        }
    }
    
    func makeNewToken(completion: @escaping (Result<Token?, AFError>) -> Void) {
        let url = "https://findfalcone.herokuapp.com/token"
        let headers: HTTPHeaders = [.accept("application/json")]
        makeRequest(url: url, method: .post, header: headers) { (result: Result<Token?, AFError>) in
            completion(result)
        }
    }
    
    func getListVehicles(completion: @escaping (Result<[Vehicle]?, AFError>) -> Void) {
        let url = "https://findfalcone.herokuapp.com/vehicles"
        makeRequest(url: url, method: .get) { (result: Result<[Vehicle]?, AFError>) in
            completion(result)
        }
    }
    
    func getListPlanets(completion: @escaping (Result<[Planet]?, AFError>) -> Void) {
        let url = "https://findfalcone.herokuapp.com/planets"
        makeRequest(url: url, method: .get) { (result: Result<[Planet]?, AFError>) in
            completion(result)
        }
    }
    
}
