//
//  AddTodoViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit

class AddTodoViewController: BaseViewController {
    
    let mainView = AddTodoView()
    
    
    override func loadView() {
        view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "새로운 할 일"
        mainView.backgroundColor = Constants.Color.addViewBackgroundColor // 검은색보다 좀 더 연한 색
    }

    override func configureView() {
        
        settingBarButton()
     
    }
    
    @objc
    func addButtonClicked() {
        dismiss(animated: true)

    }
    
    @objc
    func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
}

extension AddTodoViewController {
    func settingBarButton() {
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        
        navigationItem.rightBarButtonItem = addButton
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = cancelButton
    }
}
