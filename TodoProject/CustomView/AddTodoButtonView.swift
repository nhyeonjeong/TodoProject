//
//  AddTodoButtonView.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/15.
//

import UIKit
import SnapKit

class AddTodoButtonView: BaseView {
    let plusButton: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        view.setTitle(" 새로운 할 일", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(plusButton)
    }
    
    override func configureConstraints() {
        plusButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
