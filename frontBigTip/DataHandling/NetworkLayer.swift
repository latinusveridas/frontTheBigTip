//
//  NetworkLayer.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import Alamofire

class BigTipAPI {
        
    enum FilterMode {
            case relevancy
            case tailored
    }
    
    
    func downloadTipsVideos(_ paginationSkip: Int,_ paginationFirst: Int, filterMode: FilterMode ) {
            
    }
    
    func downloadThumbnails(tipVideos: [TipVideo]) {
            
            
    }
    
    func downloadTipVideo(tipVideo: TipVideo) {
            
            
    }
    
    var session: Session?
    

// MARK: Lower network layer, including session management
    
    init() {
        // Headers
        let header1 = HTTPHeader(name: "header1", value: "xxx")
        let defaultHeaders = HTTPHeaders([header1])

        // Request Adapter & Retrier
        let accessTokenManager = BigTipTokenManager(clientID: "xx", baseURLString: "xx", accessToken: "xx", refreshToken: "xx")

        // Session
        self.session = Session(interceptor: accessTokenManager)
    }
    
}

extension BigTipAPI {

    // MARK: Request Adapter & Retrier
    
    class BigTipTokenManager: RequestInterceptor {
    
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void

    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        return Session(configuration: configuration)
    }()

    private let lock = NSLock()

    private var clientID: String
    private var baseURLString: String
    private var accessToken: String
    private var refreshToken: String

    private var isRefreshing = false

    public init(clientID: String, baseURLString: String, accessToken: String, refreshToken: String) {
        self.clientID = clientID
        self.baseURLString = baseURLString
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(baseURLString) {
            var urlRequest = urlRequest
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            completion(.success(urlRequest))
        }

    }
      
      func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
          lock.lock() ; defer { lock.unlock() }
  
          if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
  
              if !isRefreshing {
                  refreshTokens { [weak self] succeeded, accessToken, refreshToken in
                      guard let strongSelf = self else { return }
  
                      strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
  
                      if let accessToken = accessToken, let refreshToken = refreshToken {
                          strongSelf.accessToken = accessToken
                          strongSelf.refreshToken = refreshToken
                      }
  
                  }
              }
          } else {
              completion(.doNotRetry)
          }
      }
  
      private func refreshTokens(completion: @escaping RefreshCompletion) {
          guard !isRefreshing else { return } // isRefreshing should be false to avoid double retry
  
          isRefreshing = true
  
          let urlString = "\(baseURLString)/oauth2/token"
  
          let parameters: [String: Any] = [
              "access_token": accessToken,
              "refresh_token": refreshToken,
              "client_id": clientID,
              "grant_type": "refresh_token"
          ]
  
          session.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
              .responseJSON { [weak self] response in
                  guard let strongSelf = self else { return }
  
                  if 
                      let json = response.result.value as? [String: Any], 
                      let accessToken = json["access_token"] as? String, 
                      let refreshToken = json["refresh_token"] as? String 
                  {
                      completion(true, accessToken, refreshToken)
                  } else {
                      completion(false, nil, nil)
                  }
  
                  strongSelf.isRefreshing = false
              }
      }
      
      
    }
  
}
        
// enum Router: URLRequestConvertible {
//     case search(query: String, page: Int)

//     static let baseURLString = "https://thebigtip.com"
//     static let perPage = 50

//     func asURLRequest() throws -> URLRequest {
    
//         let result: (path: String, parameters: Parameters) = {
        
//             switch self {
            
//             case let .search(query, page) where page > 0:
            
//                 return ("/search", ["q": query, "offset": Router.perPage * page])
                
//             case let .search(query, _):
            
//                 return ("/search", ["q": query])
                
//             }
//         } ()

//         let url = try Router.baseURLString.asURL()
//         let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))

//         return try URLEncoding.default.encode(urlRequest, with: result.parameters)
//     }
// }

// Alamofire.request(Router.search(query: "foo bar", page: 1)) // https://example.com/search?q=foo%20bar&offset=50


// /// Outcome of determination whether retry is necessary.
// public enum RetryResult {
//     /// Retry should be attempted immediately.
//     case retry
//     /// Retry should be attempted after the associated `TimeInterval`.
//     case retryWithDelay(TimeInterval)
//     /// Do not retry.
//     case doNotRetry
//     /// Do not retry due to the associated `AFError`.
//     case doNotRetryWithError(Error)
// }



// AF.request(url, headers).responseJSON { response in
//     guard response.result.isSuccess, let value = response.result.value as? [String : Any] else {
//         print("Error \(String(describing: response.result.error))")
//         return
//     }
// }


/* 
https://thebigtip.com
https://thebigtip.com/main
https://thebigtip.com/search?param=xyz&param2=xy%20z    // %20 => Space
https://thebigtip.com/followed
https://thebigtip.com/saved
https://thebigtip.com/profile
https://thebigtip.com/about
https://thebigtip.com/tipvideo/upload
https://thebigtip.com/tipvideo/get
https://thebigtip.com/tipvideo/update
https://thebigtip.com/tipvideo/delete
https://thebigtip.com/user

CRUD
TipVideo
Users

*/

enum Router: URLRequestConvertible {

    case createProfile(parameters: Parameters)
    case readProfile(userId: String)
    case updateProfile(userId: String, parameters: Parameters)
    case deleteProfile(userId: String)
    
    case uploadTipVideo(parameters: Parameters)
    case getTipVideo(tipVideoId: String)
    case updateTipVideo(tipVideoId: String, parameters: Parameters)
    case deleteTipVideo(tipVideoId: String)
    
    case readUser(userId: String)

    static let baseURLString = "https://thebigtip.com"

    var method: HTTPMethod {
        switch self {
        
        case .createProfile:
            return .post
        case .readProfile:
            return .get
        case .updateProfile:
            return .put
        case .deleteProfile:
            return .delete
            
        case .uploadTipVideo:
          return .post
        case .getTipVideo:
          return .get
        case .updateTipVideo:
          return .put
        case .deleteTipVideo:
          return .delete
          
        case .readUser:
          return .get
          
        }
    }

    var path: String {
        switch self {
        
        case .createProfile:
          return "/profile"
        case .readProfile(let userId):
          return "/profile/\(userId)"
        case .updateProfile(let userId, _):
          return "/profile/\(userId)"
        case .deleteProfile(let userId):
          return "/profile/\(userId)"
            
        case .uploadTipVideo:
          return "/tipvideo/"
        case .getTipVideo:
          return "/tipvideo/"
        case .updateTipVideo:
          return "/tipvideo/"
        case .deleteTipVideo:
          return "/tipvideo/"  
          
        case .readUser:
          return "/user/"
        
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        
        case .createProfile(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            
        case .updateProfile(_, let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            
        default:
            break
            
        }

        return urlRequest
    }
}
