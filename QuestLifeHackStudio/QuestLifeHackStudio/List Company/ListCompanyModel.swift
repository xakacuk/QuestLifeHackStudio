//
//  ListCompanyModel.swift
//  QuestLifeHackStudio
//
//  Created by Евгений Бейнар on 20/06/2019.
//  Copyright © 2019 zuk. All rights reserved.
//

import Foundation

final class ListCompanyModel {
    
    private let httpManage = HTTPManager.shared
    private var companys = [Company]()
    
    func getListCompany(completion: @escaping (Swift.Result<[Company], Error>) -> Void) {
        self.companys.removeAll()
        httpManage.getListCompany { result in
            switch result {
                case .success(let response):
                    self.companys.removeAll()
                    self.companys = response!
                    completion(.success(self.companys))
                    break
                case .failure(let error):
                    print("error")
                    completion(.failure(error))
                    break
            }
        }
    }
}
