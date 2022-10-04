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

    private func makeRequest<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters? = nil, header: HTTPHeaders, completion: @escaping (Result<T?, AFError>) -> Void) {
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

//extension NetworkService {
//
//    func getListUser(page: Int, limit: Int, completion: @escaping (Result<ListUserResponse?, AFError>) -> Void) {
//        let url = "https://dummyapi.io/data/v1/user?page=\(page)&limit=\(limit)"
//        makeRequest(url: url, method: .get ) { (result: Result<ListUserResponse?, AFError>)  in
//            completion(result)
//        }
//    }
//
//    func getUserById(id: String, completion: @escaping (Result<UserResponse?, AFError>) -> Void) {
//        let url = "https://dummyapi.io/data/v1/user/" + id
//        makeRequest(url: url, method: .get) { (result: Result<UserResponse?, AFError>) in
//            completion(result)
//        }
//    }
//
//    func updateUser(body: UserResponse, completion: @escaping (Result<UserResponse?, AFError>) -> Void) {
//        let params = ["fisrtName": body.firstName, "lastName": body.lastName]
//        let url = "https://dummyapi.io/data/v1/user/" + body.id
//        makeRequest(url: url, method: .put, parameters: params) { (result: Result<UserResponse?, AFError>) in
//            completion(result)
//        }
//    }
//
//    func deleteUser(id: String, completion: @escaping (Result<DeleteUserResponse?, AFError>) -> Void) {
//        let url = "https://dummyapi.io/data/v1/user/" + id
//        makeRequest(url: url, method: .delete) { (result: Result<DeleteUserResponse?, AFError>) in
//            completion(result)
//        }
//    }
//}
//

// git: https://github.com/nhivo14/findfalcone
