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

    let repository = TodoTableRepository()
    var list: Results<TodoTable>!
    
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
        list = realm.objects(TodoTable.self).sorted(byKeyPath: "deadline", ascending: true)
        
        mainView.tableView.reloadData()
    }
    
    // 체크박스 눌렀을 때 event
    @objc
    func checkboxClicked(_ sender: UIButton) { // 버튼에 달아준 addTarget은 sender 매개변수 가능!?
        // realm update
        repository.updateIsComplete(list[sender.tag])
        // 다한 것은 제일 아래로 내리기
//        let data = list[sender.tag]
//        repository.deleteData(data)
//        repository.createItem(data) 
        // UI 업데이트
        mainView.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }

    override func configureView() {
        let rightbarButton = UIBarButtonItem(image: Constants.Image.eclipes, style: .plain, target: self, action: nil)

        
        let realm = try! Realm()
        // pull down button
        let deadlineSort = UIAction(title: "마감일순으로 보기") { _ in
            self.list = realm.objects(TodoTable.self).sorted(byKeyPath: "deadline", ascending: true)
            
            self.mainView.tableView.reloadData()
        }
        let titleSort = UIAction(title: "제목 순으로 보기") { _ in
            self.list = realm.objects(TodoTable.self).sorted(byKeyPath: "memoTitle", ascending: true)
            
            self.mainView.tableView.reloadData()
        }
        let lowPrioritySort = UIAction(title: "우선순위 낮음만 보기") { _ in
            self.list = realm.objects(TodoTable.self).where{
                $0.priority == 3
            }
            self.mainView.tableView.reloadData()
        }
        
        let buttonMenu = UIMenu(children: [deadlineSort, titleSort, lowPrioritySort])
        
        rightbarButton.menu = buttonMenu
        
        navigationItem.rightBarButtonItem = rightbarButton
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
//        mainView.tableView.rowHeight = 50
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = UITableView.automaticDimension
        mainView.tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.identifier)
        mainView.tableView.allowsSelection = false // 선택되는 이벤트 안생기도록
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    } 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.identifier, for: indexPath) as? TodoListTableViewCell else {
            return UITableViewCell()
        }
        cell.checkbox.tag = row // checkbox에 태그달아서 관리
        cell.checkbox.addTarget(self, action: #selector(checkboxClicked), for: .touchUpInside)
        cell.configureCell(data: list[row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true // 편집 허락
//    }
//    

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        
//        // indexPath
//        if editingStyle == .delete {
//            // 삭제버튼을 눌렀을 때 행동
//            repository.deleteData(list[indexPath.row])
//            tableView.reloadData()
//            
//        }
//    }
    
    // swipe했을 때 삭제
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            self.repository.deleteData(self.list[indexPath.row])
            tableView.reloadData()
        }
        delete.backgroundColor = Constants.Color.pointColor
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
