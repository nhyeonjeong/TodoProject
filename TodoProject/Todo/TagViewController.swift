//
//  TagViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit
import SnapKit

class TagViewController: BaseViewController {
    
    let tagTextfield = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.backgroundColor
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.post(name: NSNotification.Name("AddTodo"), object: nil, userInfo: [TodoList.tag.todoListString: tagTextfield.text!]) // 알람센터에 저장될 때는 옵셔널로 저장못하는듯 하여 그냥 string으로 저장
    }
 
    override func configureHierarchy() {
        view.addSubview(tagTextfield)
    }
    
    override func configureConstraints() {
        tagTextfield.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
}
