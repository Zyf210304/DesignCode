//
//  YFAPI.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/14.
//

import Foundation
import Alamofire

/// Type representing HTTP methods.
public enum YFHTTPMethod {
    /// Common HTTP methods.
    case delete, get, patch, post, put
}

/// API interface protocol
public protocol YFAPIProtocol {
    /// API URL address
    var url: String { get }
    /// API description information
    var description: String { get }
    /// API additional information, eg: Author | Note...
    var extra: String? { get }
    /// Type representing HTTP methods.
    var method: YFHTTPMethod { get }
}

/// Extension method
public extension YFAPIProtocol {

    /// 根据`YFAPIProtocol`进行一个网络请求
    ///
    /// - Parameters:
    ///   - parameters: `nil` by default.
    ///   - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - success: Successful response
    ///   - failed: Failed response
    ///
    func fetch(_ parameters: [String: Any]? = nil, headers: [String: String]? = nil, success: ZNSuccessClosure?, failed: ZNFailedClosure?) {
        let task = ZN.fetch(self, parameters: parameters, headers: headers)
        if let s = success {
            task.success(s)
        }
        if let f = failed {
            task.failed(f)
        }
    }

    /// 根据`YFAPIProtocol`进行一个网络请求
    ///
    /// - Parameters:
    ///   - parameters: `nil` by default.
    ///   - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///
    func fetch(_ parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> YFNetworkRequest {
        ZN.fetch(self, parameters: parameters, headers: headers)
    }
}

/// 为了`YFAPIProtocol`给`YFNetworking`扩展的网络请求方法
public extension YFNetworking {
    /// Creates a request, for `YFAPIProtocol`
    ///
    /// - note: more see: `self.request(...)`
    @discardableResult
    func fetch(_ api: YFAPIProtocol, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> YFNetworkRequest {
        let method = methodWith(api.method)
        let task = request(url: api.url, method: method, parameters: parameters, headers: headers)
        task.description = api.description
        task.extra = api.extra
        return task
    }
}

/// Function to convert request method
private func methodWith(_ m: YFHTTPMethod) -> Alamofire.HTTPMethod {
    // case delete, get, patch, post, put
    switch m {
    case .delete: return .delete
    case .get: return .get
    case .patch: return .patch
    case .post: return .post
    case .put: return .put
    }
}
