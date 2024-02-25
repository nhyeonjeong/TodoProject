//
//  TodoDetailViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/19.
//
import UIKit
import RealmSwift

// 할 일을 추가하는 VC를 비슷하니까 상속!
class TodoDetailViewController: AddTodoViewController {
    // 메모타이틀, 메모, 마감일, 태그 수정, 우선순위...~...
    // 처음에 띄워줄 뭉탱이만 가져왔다. 뭉텅이로 가져와..
    var todoData: TodoTable = TodoTable(memoTitle: "", memo: "", deadline: Date(), priority: 0)

    // dismiss될 때 실행될 함수
    var updateTableView: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTitle = todoData.memoTitle
        memo = todoData.memo
        
        var array: [String] = []
        todoCases.forEach { todoCase in
            switch todoCase {
            case TodoList.memoBox:
                array.append("")
            case TodoList.deadline:
                array.append(format.string(from: todoData.deadline))
            case TodoList.tag:
                if let tag = todoData.tag {
                    array.append(tag)
                } else {
                    array.append("")
                }
            case TodoList.priority:
                print("priority")
                array.append("\(todoData.priority)순위")
                // list는 나오지 않도록
            case TodoList.addImage:
                array.append("") // selectedImage로 알아서 이미지 그려줌
            default:
                print("히히")
            }
        }
        todoSubTItles = array // 처음에 데이터 띄워주기
        
    }

    override func settingBarButton() {
        let addButton = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(updateButtonClicked))
        
        navigationItem.rightBarButtonItem = addButton
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func updateButtonClicked() {
        // 원래 있던 이미지 삭제
        removeImageFromDocument(filename: "\(todoData.id)")
        // 새로운 이미지 저장
        saveImageToDocument(image: selectedImage, filename: "\(todoData.id)")
        // realm todoTable update
        let realm = try! Realm()
        do {
            try realm.write {
                todoData.memoTitle = memoTitle
                todoData.memo = memo
                todoData.deadline = deadlineDate
                todoData.tag = tagString
                todoData.priority = priorityInt
            }
        } catch {
            print("update TodoTable Error", error)
        }
//        repository.updateRecord(todoData) // 원본의 id정보가 넘어가야 한다
        updateTableView?() // 이전화면 테이블뷰 reload
        dismiss(animated: true)
    }
}
