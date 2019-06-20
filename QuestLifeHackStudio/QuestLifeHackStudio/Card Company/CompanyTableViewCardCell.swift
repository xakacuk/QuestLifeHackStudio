//
//  CompanyTableViewCardCell.swift
//  QuestLifeHackStudio
//
//  Created by Евгений Бейнар on 20/06/2019.
//  Copyright © 2019 zuk. All rights reserved.
//

import UIKit

final class CompanyTableViewCardCell: UITableViewCell {
    
    var companyInfo: CompanyInfo? {
        didSet {
            guard let id = companyInfo?.id, let name = companyInfo?.name, let description = companyInfo?.description else {return}
            labelInfo.text = "\(id)\n\(name)\n\(description)"
        }
    }
    
    private let labelInfo: UILabel = {
        let info = UILabel()
        info.textColor = .black
        info.font = UIFont.boldSystemFont(ofSize: 16)
        info.textAlignment = .left
        info.numberOfLines = 0
        return info
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(labelInfo)
        labelInfo.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: frame.size.width, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
