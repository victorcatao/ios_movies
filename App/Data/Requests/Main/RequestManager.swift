//
//  RequestManager.swift
//  Victor Catao
//
//  Created by Victor Catao on 18/04/19.
//  Copyright © 2019 Victor Catao. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class RequestManager<T:Codable> {
    
    /// Checks if there active internet connection
    private class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    /// The default headers for the URLRequest
    private class var headers: [String : String] {
        return [
            "Content-type": "application/json;charset=utf-8",
            "Authorization": "Bearer \(AppSettings.apiToken)"
        ]
    }
    
    static func postToAPIService(endpoint: Endpoint, parameters:Parameters? = nil) -> Observable<T> {
        return createObservableFor(method: .post, endpoint: endpoint, parameters: parameters)
    }
    
    static func getToAPIService(endpoint: Endpoint, parameters:Parameters? = nil, customURL: String? = nil) -> Observable<T> {
        return createObservableFor(method: .get, endpoint: endpoint, parameters: parameters, encoding: URLEncoding.default, customURL: customURL)
    }
    
    static func putToAPIService(endpoint: Endpoint, parameters:Parameters? = nil) -> Observable<T> {
        return createObservableFor(method: .put, endpoint: endpoint, parameters: parameters)
    }
    
    static func deleteToAPIService(endpoint: Endpoint, parameters:Parameters? = nil) -> Observable<T> {
        return createObservableFor(method: .delete, endpoint: endpoint, parameters: parameters)
    }
    
    /// Returns the Alamofire Instance as an Observable
    private static func createObservableFor(method: HTTPMethod, endpoint: Endpoint, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, customURL: String? = nil) -> Observable<T> {
        let url = customURL ?? "\(API_URL)\(endpoint.value)"
        return Observable.create { observer -> Disposable in
            if(isConnectedToInternet) {
                printAccess(url, parameters)
                Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON(completionHandler: { (response) in
                    self.printResult(response.value)
                    if let status = response.response?.statusCode {
                        print("STATUS: \(status)")
                    }
                    if let result = resultBlock(response, error: { (error) in
                        observer.onError(error) }){
                        observer.onNext(result)
                    }
                })
            } else {
                observer.onError(RequestError.noInternetConnection)
            }
            return Disposables.create()
        }
    }
    
    /// Handles the request response traying to parse the result into a 'T' given type or returning an error
    private static func resultBlock(_ response: DataResponse<Any>, error: (RequestError)->())->T?{
        switch response.result {
        case .success:
            if let status = response.response?.statusCode, status >= 200, status <= 299 {
                if let result = decode(response) {
                    return result
                }
            } else if(response.response?.statusCode == 401) {
                let startViewController = HomeViewController()
                UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: startViewController)
            } else {
                if let result = decodeError(response), result.hasError{
                    error(.failure(reason: result.message, code: result.code ?? "\(response.response?.statusCode ?? 400)", devReason: nil))
                    break
                }
            }
            
            // Nao retornou um erro do back, vamos tratar o erro daqui
            error(getErrorFor(response))
            break
        case .failure:
            error(getErrorFor(response))
            break
        }
        return nil
    }
    
    /// Decodes the response object data to a given class type
    private static func decode(_ response:DataResponse<Any>)->T?{
        guard let data = response.data else {
            return nil
        }
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        }
        catch {
            print(error)
            return nil
        }
    }
    
    /// Tries to decode the response object as ErrorFeedback. If success, it means that there are errors
    /// on the request
    private static func decodeError(_ response:DataResponse<Any>) -> ErrorFeedback? {
        guard let data = response.data else {
            return nil
        }
        do {
            let object = try JSONDecoder().decode(ErrorFeedback.self, from: data)
            return object
        }
        catch {
            print(error)
            return nil
        }
    }
    
    /// Returns an error according to the given response object
    private static func getErrorFor(_ response: DataResponse<Any>)->RequestError{
        let message = response.error?.localizedDescription
        if let statusCode = response.response?.statusCode, (statusCode < 200 || statusCode >= 300) {
            if let resp = response.response {
                if(resp.statusCode == 401) {
                    if(response.request?.url?.absoluteString.contains("/auth") == true) {
                        return .failure(reason: "error_not_authorized".localized, code: "\(resp.statusCode)", devReason: message)
                    } else {
                        return .sessionExpired
                    }
                } else {
                    return .failure(reason: "unkown_error".localized, code: "\(resp.statusCode)", devReason: message)
                }
            }
        }
        return .unknownReason
    }
    
    // Prints the request
    private static func printAccess(_ url:String, _ parameters: Parameters?){
        let param: Any = parameters ?? ""
        print("\n ~~~~~~~ URL ACESSADA ~~~~~~~ \n - URL:\n \(url) \n - PARAMS:\n \(param)\n\n ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ \n")
    }
    
    /// Prints the result
    private static func printResult(_ result:Any?){
        print("\n ~~~~~~~ RESPOSTA DO REQUEST ~~~~~~~ \n \(result ?? "") \n\n ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ \n")
    }
}
