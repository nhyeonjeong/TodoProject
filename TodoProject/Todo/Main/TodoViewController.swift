//
//  TodoViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit

class TodoViewController: BaseViewController {
    var addTodoButton = UIBarButtonItem()
    var addListButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.backgroundColor
        settingToolBar()

    }
    
    @objc
    func addTodoButtonClicked() {
        let vc = UINavigationController(rootViewController: AddTodoViewController())
        present(vc, animated: true)
    }
    
    @objc
    func addListButtonClicked() {
        
    }
}

extension TodoViewController {
    func settingToolBar() {
        navigationController?.isToolbarHidden = false
        
        addTodoButton = UIBarButtonItem(title: "새로운 할 일", image: UIImage(systemName: "plus.circle.fill"), target: self, action: #selector(addTodoButtonClicked))
        addListButton = UIBarButtonItem(title: "목록 추가", image: nil, target: self, action: #selector(addListButtonClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        var items = [UIBarButtonItem]()

        [addTodoButton,flexibleSpace,addListButton].forEach {
            items.append($0)
        }
        self.toolbarItems = items
    }
}
