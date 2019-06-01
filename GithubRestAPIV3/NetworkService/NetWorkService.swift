//
//  NetWorkService.swift
//  GithubRestAPIV3
//
//  Created by Sinder on 2019/5/31.
//  Copyright © 2019 Sinder. All rights reserved.
//

import UIKit
import Alamofire

class NetWorkService: NSObject {

    static let shared = NetWorkService()
    
    private lazy var sesstionManager : SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    override init() {
        super.init()
    }
   

    func sendWithRequest(url: String,header: [String:String],parameters: Parameters,completionCallBack:@escaping ()->(),successCallBack:@escaping (_ result: [String: Any])->(),failedWithError:@escaping (_ error: Error) -> ()) {
        sesstionManager.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON { (responseData) in
            switch responseData.result {
            case .success:
                guard let res = responseData.result.value as? Parameters  else {
                   debugPrint("nima")
                   return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: responseData.data!, options: .allowFragments) as! [String: Any]
                    print("SUCCESS:  \(json)")
                } catch {
                    debugPrint("error occord")
                }
                successCallBack(res)
                break
            case .failure(let error):
                debugPrint("error:\(error)")
                failedWithError(error)
                break
            }
        }
    
    }
}
