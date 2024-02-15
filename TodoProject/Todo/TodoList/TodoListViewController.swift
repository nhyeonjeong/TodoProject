//
//  ClassifyViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/15.
//

import UIKit

class TodoListViewController: BaseViewController {

    let mainView = TodoListView()
    
    var classifyText = ""
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = classifyText
        mainView.backgroundColor = Constants.Color.backgroundColor
        
        // realm read
    }
    
    @objc func rightBarButtonClicked() {
        // pull down button
        
    }
    
    override func configureView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Constants.Image.eclipes, style: .plain, target: self, action: #selector(rightBarButtonClicked))
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.identifier)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
