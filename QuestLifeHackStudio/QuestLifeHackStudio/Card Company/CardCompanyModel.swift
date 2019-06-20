//
//  CardCompanyModel.swift
//  QuestLifeHackStudio
//
//  Created by Евгений Бейнар on 20/06/2019.
//  Copyright © 2019 zuk. All rights reserved.
//

import Foundation

final class CardCompanyModel {
    
    private let httpManage = HTTPManager.shared
    private var info = [CompanyInfo]()
    
    func getListCompany(id: String, completion: @escaping (Swift.Result<[CompanyInfo], Error>) -> Void) {
        self.info.removeAll()
        httpManage.getCompanyInfo(id: id) { result in
            switch result {
                case .success(let response):
                    self.info.removeAll()
                    self.info = response!
                    completion(.success(self.info))
                    break
                case .failure(let error):
                    print("error")
                    completion(.failure(error))
                    break
            }
        }
    }
}
