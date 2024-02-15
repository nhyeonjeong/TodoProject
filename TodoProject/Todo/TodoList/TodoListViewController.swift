//
//  ClassifyViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/15.
//

import UIKit
import RealmSwift

class TodoListViewController: BaseViewController {

    let mainView = TodoListView()
    
    var classifyText = ""

    var data: Results<TodoTable>!
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = classifyText
        mainView.backgroundColor = Constants.Color.backgroundColor
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // realm read
        // realm위치 접근
        let realm = try! Realm()
        // 어떤 테이블? - 마감일순이 디폴트인걸로
        data = realm.objects(TodoTable.self).sorted(byKeyPath: "deadline", ascending: true)
        
        mainView.tableView.reloadData()
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
        mainView.tableView.rowHeight = 50
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.identifier)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.identifier, for: indexPath) as? TodoListTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(title: data[row].memoTitle, deadlinePriorityString: data[row].deadlinePriority)
        return cell
    }
}
