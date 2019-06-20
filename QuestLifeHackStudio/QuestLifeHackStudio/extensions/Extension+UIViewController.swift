//
//  Extension+UIViewController.swift
//  QuestLifeHackStudio
//
//  Created by Евгений Бейнар on 20/06/2019.
//  Copyright © 2019 zuk. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func showErrorAlertMessadge(title: String, messadge: String) {
        // create alert
        let alert = UIAlertController(title: title, message: messadge, preferredStyle: UIAlertController.Style.alert)
        //add btn action
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        //show
        self.present(alert, animated: true, completion: nil)
    }
}
