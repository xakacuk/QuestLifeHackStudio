//
//  CardCompanyListViewController.swift
//  QuestLifeHackStudio
//
//  Created by Евгений Бейнар on 20/06/2019.
//  Copyright © 2019 zuk. All rights reserved.
//

import UIKit

private enum Constans: String {
    case cardCell
}

final class CardCompanyListViewController: UIViewController {
    
    private let model = CardCompanyModel()
    private var companyInfo = [CompanyInfo]()
    var companyId = ""
    
    lazy private var companyTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        table.dataSource = self
        table.delegate = self
        table.register(CompanyTableViewCardCell.self, forCellReuseIdentifier: Constans.cardCell.rawValue)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Card Company"
        setupView()
        getListCompany(id: companyId)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(companyTableView)
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        companyTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        companyTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        companyTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        companyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func getListCompany(id: String) {
//показать спинер
        model.getListCompany(id: id) { result in
            switch result {
                
                case .success(let response):
                    self.companyInfo = response
                    self.companyTableView.reloadData()
    //вырубить спинер
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
    //вырубить спинер
                        self.showErrorAlertMessadge(title: "Error", messadge: "проверте подключение")
                        print("проверьте подключение")
                    } else {
    //вырубить спинер
                        self.showErrorAlertMessadge(title: "Error", messadge: error.localizedDescription)
                        print(error.localizedDescription)
                    }
                    break
                }
        }
    }
}

extension CardCompanyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}

extension CardCompanyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constans.cardCell.rawValue, for: indexPath) as! CompanyTableViewCardCell
        let info = companyInfo[indexPath.row]
        cell.companyInfo = info
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
