//
//  AddTodoTableViewCell.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit
import SnapKit

class AddTodoMemoTableViewCell: UITableViewCell {
    
    let backView = UIView()
    
    let titleTextField = UITextField()
    let memoTextView = UITextView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear // 없으면 안됨
        backView.backgroundColor = Constants.Color.addViewTableColor

        memoTextView.backgroundColor = .clear // textview는 textfield랑 다르게 색이 있는듯?
        
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(titleList: [String]) {
        titleTextField.placeholder = titleList[0]
        memoTextView.text = titleList[1] // 마치 placeholder인것처럼
    }
}

extension AddTodoMemoTableViewCell {
    func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(titleTextField)
        backView.addSubview(memoTextView)
    }
    
    func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        // 에 여기도 tableview였나!?! -> 리팱토링하기..ㅜ
        titleTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.leading.equalToSuperview().inset(15)
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    func configureView() {
        backView.layer.cornerRadius = 10
        configureTitleLabel(content: titleTextField)
        configureTitleLabel(content: memoTextView)

    }
    
    // 좀 꼬아서 한듯..
    func configureTitleLabel(content: Any) {
        if let content = content as? UITextField {
            content.textColor = Constants.Color.subtitleColor
            content.font = Constants.Font.subtitle
        } else {
            if let content = content as? UITextView {
                content.textColor = Constants.Color.subtitleColor
                content.font = Constants.Font.subtitle
            }
        }
    }
}
