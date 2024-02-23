//
//  ListDetailViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/23.
//

import UIKit
import RealmSwift

class ListDetailViewController: BaseViewController {
    
    var list: List<TodoTable>! // Result<TodoTable>로는 안넘어와진다
    
    let mainView = TodoListView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        mainView.backgroundColor = Constants.Color.backgroundColor
    }

}


extension ListDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.identifier, for: indexPath) as? TodoListTableViewCell else {
            return UITableViewCell()
        }
        // 이미지 가져오기
        if let image = loadImageToDocument(filename: "\(list[indexPath.row].id)") { // 여기서 지정해주는 시점이 더 빠른건가..?
            cell.todoImageView.image = image
        } else {
            cell.todoImageView.isHidden = true // 막아야된다...
        }
        cell.configureCell(data: list[indexPath.row])
        return cell
    }
    
    func configureTableView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.identifier)
        mainView.tableView.rowHeight = UITableView.automaticDimension
    }
}
