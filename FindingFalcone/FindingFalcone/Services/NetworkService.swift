//
//  NetworkService.swift
//  FindingFalcone
//
//  Created by NhiVHY on 04/10/2022.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    let baseURL: String = {
        return "https://findfalcone.herokuapp.com"
    }()
    
}

extension NetworkService {
    //    let header: HTTPHeaders = ["Accept" : "application/json"]
    public func makeGetRequest<T: Decodable>(url: String,
                                             headers: HTTPHeaders?,
                                             params: Parameters?,
                                             encoding: ParameterEncoding = URLEncoding.default,
                                             completion: ((Swift.Result<T, NetworkError>) -> Void)?) {
        self.makeRequest(url: url,
                         method: .get,
                         headers: headers,
                         params: params,
                         encoding: encoding,
                         completion: completion)
    }
    
    public func makePostRequest<T: Decodable>(url: String,
                                              headers: HTTPHeaders?,
                                              params: Parameters?,
                                              encoding: ParameterEncoding = JSONEncoding.default,
                                              completion: ((Swift.Result<T, NetworkError>) -> Void)?) {
        self.makeRequest(url: url,
                         method: .post,
                         headers: headers,
                         params: params,
                         encoding: encoding,
                         completion: completion)
    }
    
    
    private func makeRequest<T: Decodable>(url: String,
                                           method: HTTPMethod,
                                           headers: HTTPHeaders?,
                                           params: Parameters?,
                                           encoding: ParameterEncoding,
                                           completion: ((Swift.Result<T, NetworkError>) -> Void)?) {
        AF.request(url,
                   method: method,
                   parameters: params,
                   encoding: encoding,
                   headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(_):
                    if let json = response.value as? [String : Any] {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: json)
                            let rsp = try JSONDecoder().decode(T.self, from: data)
                            completion?(.success(rsp))
                        } catch let error {
                            completion?(.failure(NetworkError(error.asAFError)))
                        }
                    } else {
                        completion?(.failure(NetworkError()))
                    }
                case .failure(let error):
                    completion?(.failure(NetworkError(error.asAFError)))
                }
            }
    }
}


class NetworkError: Error {
    
    var message = ""
    
    init(_ error: AFError?) {
        if let error = error {
            switch error.responseCode {
            case 401:
                self.message = "401"
            case 404:
                self.message = "404"
            case 500:
                self.message = "500"
            default:
                self.message = error.localizedDescription
            }
        } else {
            self.message = "Dont know"
        }
    }
    
    init(_ message: String = "Dont know") {
        self.message = message
    }
    
}

extension NetworkService {
    func createNewToken(completion: ((Result<Token, NetworkError>) -> Void)? = nil) {
        let authen = Constant.accept
        let headers: HTTPHeaders = [.accept(authen)]
        self.makePostRequest(url: self.baseURL + Endpoint.token, headers: headers, params: nil, completion: completion)
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
