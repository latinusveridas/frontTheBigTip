//
//  SessionManagement.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

//import Foundation
//import Alamofire
//
//class BigTipTokenHandler {
//
//    let urlSession = URLSessionConfiguration.default
//    var session = Session.init(configuration: , delegate: <#T##SessionDelegate#>, rootQueue: <#T##DispatchQueue#>, startRequestsImmediately: <#T##Bool#>, requestQueue: <#T##DispatchQueue?#>, serializationQueue: <#T##DispatchQueue?#>, interceptor: <#T##RequestInterceptor?#>, serverTrustManager: <#T##ServerTrustManager?#>, redirectHandler: <#T##RedirectHandler?#>, cachedResponseHandler: <#T##CachedResponseHandler?#>, eventMonitors: <#T##[EventMonitor]#>)
//
//
//}
    
// OLD
    
//    // Definition du RefreshCompletion utilisé lors de la requete RefreshToken
//    private typealias RefreshCompletion = (_ succeeded: Bool, _ jwt: String?) -> ()
//
//    // Definition de l'objet SessionManager
//    let sessionManager: SessionManager = {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
//        return SessionManager(configuration: configuration)
//    } ()
//
//    private let lock = NSLock()
//    private var login: String
//    private var password: String
//    private var jwt: String?
//    private var baseURLString: String
//
//    // RequestRetryCompletion is typealias (_ shouldRetry: Bool, _ timeDelay: TimeInterval), used as a queue
//    private var isRefreshing: Bool = false
//    private var requestsToRetry: [RequestRetryCompletion] = []
//
//    // Initialization
//    public init() {
//        self.jwt = UserDefaults.standard.string(forKey: "jwt")
//        self.baseURLString = "http://83.217.132.102:3000/"
//    }
//
//    // Request Adapter Delegate
//    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
//    /* Check prefix and add HTTP headers */
//        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(baseURLString) {
//            var urlRequest = urlRequest
//            print("DEBUG ADAPTER jwt IS", jwt!)
//            urlRequest.setValue(jwt, forHTTPHeaderField: "jwt")
//            return urlRequest
//        }
//
//        return urlRequest
//    }
//
//    // RequestRetrier Delegate
//    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
//        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 /* Unauthorized */ {
//            requestsToRetry.append(completion)
//
//            if !isRefreshing {
//                print("Refresh is required, launching of the refreshToken function")
//                refreshToken { [weak self] succeeded, jwt in
//                    guard let strongSelf = self else {return}
//
//                    strongSelf.lock.lock() ; defer {strongSelf.lock.unlock()}
//
//                    if let jwt = jwt {
//                        strongSelf.jwt = jwt
//                    }
//
//                    strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
//                    strongSelf.requestsToRetry.removeAll()
//
//                }
//            }
//        } else {
//            completion(false,0.0)
//        }
//    }
//
//    //RefreshToken
//    private func refreshToken (completion: @escaping RefreshCompletion) {
//    /* This function send credentials to request jwt */
//        let urlRefreshEndpoint = "http://83.217.132.102:3000/auth/refresh"
//        guard !isRefreshing else { return }
//
//        isRefreshing = true
//
//        let headers: HTTPHeaders = [
//            "login": login,
//            "pw": password
//        ]
//
//        sessionManager.request(urlRefreshEndpoint, method: .post,encoding: JSONEncoding.default, headers: headers).responseJSON { [weak self] response in
//            guard let strongSelf = self else { return }
//            guard let json = response.result.value as? [String:Any] else {return}
//
//            if
//                let json = response.result.value as? [String:Any],
//                let data = json["data"] as? [String:Any],
//                let jwt = data["jwt"] as? String
//            {
//                UserDefaults.standard.set(jwt, forKey: "jwt")
//                completion(true,self?.jwt)
//            } else {
//                completion(false,nil)
//            }
//
//            strongSelf.isRefreshing = false
//
//        }
//    }
//
//
//


