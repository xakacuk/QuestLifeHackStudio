//
//  ListCompanyTableView.swift
//  QuestLifeHackStudio
//
//  Created by Евгений Бейнар on 20/06/2019.
//  Copyright © 2019 zuk. All rights reserved.
//

import UIKit

private enum Constans: String {
    case companyCell
}

final class ListCompanyViewController: UIViewController {
    
    private let model = ListCompanyModel()
    private var companys = [Company]()
    
    lazy private var companyTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        table.dataSource = self
        table.delegate = self
        table.register(CompanyTableViewCell.self, forCellReuseIdentifier: Constans.companyCell.rawValue)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Company List"
        setupView()
        getListCompany()
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
    
    private func getListCompany() {
    //показать спинер
        model.getListCompany { result in
            switch result {
                
                case .success(let response):
                    self.companys = response
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

extension ListCompanyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CardCompanyListViewController()
        vc.companyId = companys[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}

extension ListCompanyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constans.companyCell.rawValue, for: indexPath) as! CompanyTableViewCell
        let company = companys[indexPath.row]
        cell.company = company
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
