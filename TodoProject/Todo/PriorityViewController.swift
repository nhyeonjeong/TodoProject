//
//  PriorityViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit

class PriorityViewController: BaseViewController {
    
    var selectedIndex = 0

    let segment: UISegmentedControl = {
        let view = UISegmentedControl()
        view.insertSegment(withTitle: "1", at: 0, animated: true)
        view.insertSegment(withTitle: "2", at: 1, animated: true)
        view.insertSegment(withTitle: "3", at: 2, animated: true)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.Color.backgroundColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 선택했는지 안했는지 처리해주지 않으면 런타임 오류
        selectedIndex = segment.isSelected ? segment.selectedSegmentIndex : 0
        NotificationCenter.default.post(name: NSNotification.Name("AddTodo"), object: nil, userInfo: [TodoList.priority.todoListString: "\(segment.titleForSegment(at: selectedIndex) ?? "0" )순위"])
    }
    
    override func configureHierarchy() {
        view.addSubview(segment)
    }
    
    override func configureConstraints() {
        segment.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
}
