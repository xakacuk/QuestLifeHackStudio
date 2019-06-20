//
//  HTTPManager.swift
//  QuestLifeHackStudio
//
//  Created by Евгений Бейнар on 20/06/2019.
//  Copyright © 2019 zuk. All rights reserved.
//

import Foundation
import Alamofire

final class HTTPManager {
    
    static let shared = HTTPManager()
    
    public typealias Parameters = [String: Any]
    
    struct Const {
        static let url = "http://megakohz.bget.ru/test.php"
    }
    
    struct Config {
        static let timeout: TimeInterval = 15.0
    }
    
    lazy var networkSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = Config.timeout
        configuration.timeoutIntervalForRequest = Config.timeout
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
    
    func getListCompany(completionHandler: @escaping (Swift.Result<[Company]?, Error>) -> Void) {

        networkSessionManager.request(Const.url, method: .get, parameters: nil).response { response in
            
            if let error = response.error {
                //timeout error, code 400...
                completionHandler(.failure(error))
                return
            }
            
            guard let data = response.data else {
                assertionFailure()
                return
            }
            
            if let rawString = String(bytes: data, encoding: .utf8) {
                print(rawString)
            }
            let decoder = JSONDecoder()

            do {
                let companys = try decoder.decode([Company].self, from: data)
                completionHandler(.success(companys))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    func getCompanyInfo(id: String, completionHandler: @escaping (Swift.Result<[CompanyInfo]?, Error>) -> Void) {
        let path = "?id=\(id)"
        networkSessionManager.request("\(Const.url)\(path)", method: .get, parameters: nil).response { response in
            
            if let error = response.error {
                //timeout error, code 400...
                completionHandler(.failure(error))
                return
            }
            
            guard let data = response.data else {
                assertionFailure()
                return
            }
            
            if let rawString = String(bytes: data, encoding: .utf8) {
                print(rawString)
            }
            let decoder = JSONDecoder()
            
            do {
                let companys = try decoder.decode([CompanyInfo].self, from: data)
                completionHandler(.success(companys))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}
