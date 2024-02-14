//
//  TestViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/15.
//

import UIKit

class TestViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "df"
        print("dfdf")
    }
    @objc
    func addTodoButtonClicked() {
        let vc = AddTodoViewController()
        present(vc, animated: true)
    }
    

}
