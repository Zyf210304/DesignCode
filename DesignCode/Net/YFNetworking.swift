//
//  YFNetworking.swift
//  DesignCode
//
//  Created by 亚飞 on 2021/1/14.
//

import Foundation
import Alamofire


/// Closure type executed when the request is successful
public typealias ZNSuccessClosure = (_ JSON: Any) -> Void
/// Closure type executed when the request is failed
public typealias ZNFailedClosure = (_ error: YFNetworkingError) -> Void
/// Closure type executed when monitoring the upload or download progress of a request.
public typealias ZNProgressHandler = (Progress) -> Void

/// Defines the various states of network reachability.
public enum YFReachabilityStatus {
    /// It is unknown whether the network is reachable.
    case unknown
    /// The network is not reachable.
    case notReachable
    /// The connection type is either over Ethernet or WiFi.
    case ethernetOrWiFi
    /// The connection type is a cellular connection.
    case cellular
}

// ============================================================================

/// Reference to `YFNetworking.shared` for quick bootstrapping and examples.
public let ZN = YFNetworking.shared

/// This notification will be sent when you call method `startMonitoring()` to monitor the network
/// and the network status changes.
public let kNetworkStatusNotification = NSNotification.Name("kNetworkStatusNotification")

// ============================================================================

/// `YFNetworking`网络请求主类
public class YFNetworking {
    /// For singleton pattern
    public static let shared = YFNetworking()
    /// TaskQueue Array for (`Alamofire.Request` & callback)
    private(set) var taskQueue = [YFNetworkRequest]()
    /// `Session` creates and manages Alamofire's `Request` types during their lifetimes.
    var sessionManager: Alamofire.Session!

    /// Network reachability manager, The first call to method `startMonitoring()` will be initialized.
    var reachability: NetworkReachabilityManager?
    /// The newwork status, `.unknown` by default, You need to call the `startMonitoring()` method
    var networkStatus: YFReachabilityStatus = .unknown

    // MARK: - Core method

    /// Initialization
    /// `private` for singleton pattern
    private init() {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 20  // Timeout interval
        config.timeoutIntervalForResource = 20  // Timeout interval
        sessionManager = Alamofire.Session(configuration: config)
    }

    /// Creates a `DataRequest` from a `URLRequest` created using the passed components
    ///
    /// - Parameters:
    ///   - method: `HTTPMethod` for the `URLRequest`. `.get` by default.
    ///   - parameters: `nil` by default.
    ///   - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///
    /// - Returns:  The created `DataRequest`.
    public func request(url: String,
                        method: HTTPMethod = .get,
                        parameters: [String: Any]?,
                        headers: [String: String]? = nil,
                        encoding: ParameterEncoding = URLEncoding.default) -> YFNetworkRequest {
        let task = YFNetworkRequest()

        var h: HTTPHeaders?
        if let tempHeaders = headers {
            h = HTTPHeaders(tempHeaders)
        }

        task.request = sessionManager.request(url,
                                              method: method,
                                              parameters: parameters,
                                              encoding: encoding,
                                              headers: h).validate().responseJSON { [weak self] response in
            task.handleResponse(response: response)

            if let index = self?.taskQueue.firstIndex(of: task) {
                self?.taskQueue.remove(at: index)
            }
        }
        taskQueue.append(task)
        return task
    }

    /// Creates a `UploadRequest` from a `URLRequest` created using the passed components
    ///
    /// - Parameters:
    ///   - method: `HTTPMethod` for the `URLRequest`. `.post` by default.
    ///   - parameters: 为了方便格式化参数，采用了[String: String]格式. `nil` by default.
    ///   - datas: Data to upload. The data is encapsulated here! more see `YFMultipartData`
    ///   - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///
    /// - Returns: The created `UploadRequest`.
    public func upload(url: String,
                       method: HTTPMethod = .post,
                       parameters: [String: String]?,
                       datas: [YFMultipartData],
                       headers: [String: String]? = nil) -> YFNetworkRequest {
        let task = YFNetworkRequest()

        var h: HTTPHeaders?
        if let tempHeaders = headers {
            h = HTTPHeaders(tempHeaders)
        }

        task.request = sessionManager.upload(multipartFormData: { (multipartData) in
            // 1.参数 parameters
            if let parameters = parameters {
                for p in parameters {
                    multipartData.append(p.value.data(using: .utf8)!, withName: p.key)
                }
            }
            // 2.数据 datas
            for d in datas {
                multipartData.append(d.data, withName: d.name, fileName: d.fileName, mimeType: d.mimeType)
            }
        }, to: url, method: method, headers: h).uploadProgress(queue: .main, closure: { (progress) in
            task.handleProgress(progress: progress)
        }).validate().responseJSON(completionHandler: { [weak self] response in
            task.handleResponse(response: response)

            if let index = self?.taskQueue.firstIndex(of: task) {
                self?.taskQueue.remove(at: index)
            }
        })
        taskQueue.append(task)
        return task
    }

    /// Creates a `DownloadRequest`...
    ///
    /// - warning: Has not been implemented
    /// - Returns: The created `DownloadRequest`.
    public func download(url: String, method: HTTPMethod = .post) -> YFNetworkRequest {
        // has not been implemented
        fatalError("download(...) has not been implemented")
    }

    // MARK: - Cancellation

    /// Cancel all active `Request`s, optionally calling a completion handler when complete.
    ///
    /// - Note: This is an asynchronous operation and does not block the creation of future `Request`s. Cancelled
    ///         `Request`s may not cancel immediately due internal work, and may not cancel at all if they are close to
    ///         completion when cancelled.
    ///
    /// - Parameters:
    ///   - queue:      `DispatchQueue` on which the completion handler is run. `.main` by default.
    ///   - completion: Closure to be called when all `Request`s have been cancelled.
    public func cancelAllRequests(completingOnQueue queue: DispatchQueue = .main, completion: (() -> Void)? = nil) {
        sessionManager.cancelAllRequests(completingOnQueue: queue, completion: completion)
    }
}

/// Shortcut method for `YFNetworking`
extension YFNetworking {

    /// Creates a POST request
    ///
    /// - note: more see: `self.request(...)`
    @discardableResult
    public func POST(url: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> YFNetworkRequest {
        request(url: url, method: .post, parameters: parameters, headers: nil)
    }

    /// Creates a POST request for upload data
    ///
    /// - note: more see: `self.request(...)`
    @discardableResult
    public func POST(url: String, parameters: [String: String]? = nil, headers: [String: String]? = nil, datas: [YFMultipartData]? = nil) -> YFNetworkRequest {
        guard datas != nil else {
            return request(url: url, method: .post, parameters: parameters, headers: nil)
        }
        return upload(url: url, parameters: parameters, datas: datas!, headers: headers)
    }

    /// Creates a GET request
    ///
    /// - note: more see: `self.request(...)`
    @discardableResult
    public func GET(url: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> YFNetworkRequest {
        request(url: url, method: .get, parameters: parameters, headers: nil)
    }
}

/// Detect network status 监听网络状态
extension YFNetworking {
    /// Starts monitoring for changes in network reachability status.
    public func startMonitoring() {
        if reachability == nil {
            reachability = NetworkReachabilityManager.default
        }

        reachability?.startListening(onQueue: .main, onUpdatePerforming: { [unowned self] (status) in
            switch status {
            case .notReachable:
                self.networkStatus = .notReachable
            case .unknown:
                self.networkStatus = .unknown
            case .reachable(.ethernetOrWiFi):
                self.networkStatus = .ethernetOrWiFi
            case .reachable(.cellular):
                self.networkStatus = .cellular
            }
            // Sent notification
            NotificationCenter.default.post(name: kNetworkStatusNotification, object: nil)
            debugPrint("YFNetworking Network Status: \(self.networkStatus)")
        })
    }

    /// Stops monitoring for changes in network reachability status.
    public func stopMonitoring() {
        guard reachability != nil else { return }
        reachability?.stopListening()
    }
}

/// RequestTask
public class YFNetworkRequest: Equatable {

    /// Alamofire.DataRequest
    var request: Alamofire.Request?
    /// API description information. default: nil
    var description: String?
    /// API additional information, eg: Author | Note...,  default: nil
    var extra: String?

    /// request response callback
    private var successHandler: ZNSuccessClosure?
    /// request failed callback
    private var failedHandler: ZNFailedClosure?
    /// `ProgressHandler` provided for upload/download progress callbacks.
    private var progressHandler: ZNProgressHandler?

    // MARK: - Handler

    /// Handle request response
    func handleResponse(response: AFDataResponse<Any>) {
        switch response.result {
        case .failure(let error):
            if let closure = failedHandler {
                let YFe = YFNetworkingError(code: error.responseCode ?? -1, desc: error.localizedDescription)
                closure(YFe)
            }
        case .success(let JSON):
            if let closure = successHandler {
                closure(JSON)
            }
        }
        clearReference()
    }

    /// Processing request progress (Only when uploading files)
    func handleProgress(progress: Foundation.Progress) {
        if let closure = progressHandler {
            closure(progress)
        }
    }

    // MARK: - Callback

    /// Adds a handler to be called once the request has finished.
    ///
    /// - Parameters:
    ///   - closure: A closure to be executed once the request has finished.
    ///
    /// - Returns:             The request.
    @discardableResult
    public func success(_ closure: @escaping ZNSuccessClosure) -> Self {
        successHandler = closure
        return self
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - Parameters:
    ///   - closure: A closure to be executed once the request has finished.
    ///
    /// - Returns:             The request.
    @discardableResult
    public func failed(_ closure: @escaping ZNFailedClosure) -> Self {
        failedHandler = closure
        return self
    }

    /// Sets a closure to be called periodically during the lifecycle of the instance as data is sent to the server.
    ///
    /// - Note: Only the last closure provided is used.
    ///
    /// - Parameters:
    ///   - closure: The closure to be executed periodically as data is sent to the server.
    ///
    /// - Returns:   The instance.
    @discardableResult
    public func progress(closure: @escaping ZNProgressHandler) -> Self {
        progressHandler = closure
        return self
    }

    /// Cancels the instance. Once cancelled, a `Request` can no longer be resumed or suspended.
    ///
    /// - Returns: The instance.
    func cancel() {
        request?.cancel()
    }

    /// Free memory
    func clearReference() {
        successHandler = nil
        failedHandler = nil
        progressHandler = nil
    }
}

/// Equatable for `YFNetworkRequest`
extension YFNetworkRequest {
    /// Returns a Boolean value indicating whether two values are equal.
    public static func == (lhs: YFNetworkRequest, rhs: YFNetworkRequest) -> Bool {
        return lhs.request?.id == rhs.request?.id
    }
}
