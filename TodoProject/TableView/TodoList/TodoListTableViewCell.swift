//
//  TodoListTableViewCell.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/15.
//

import UIKit
import SnapKit

class TodoListTableViewCell: UITableViewCell {
    let checkbox = UIButton()
    let titleLabel = UILabel()
    
    let stackView = UIStackView()
    let smallStackView = UIStackView()
    let memoLabel = UILabel()
    let tagLabel = UILabel()
    let deadlineLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: TodoTable) {
        // 완료된 할 일 여부에 따라서 색 변경
        checkbox.backgroundColor = data.isComplete ? Constants.Color.pointColor : .clear
        // 완료됐다면 타이틀의 색과 태그 색을 subtitle색으로
        titleLabel.textColor = data.isComplete ? Constants.Color.subtitleColor : Constants.Color.titleColor
        memoLabel.text = data.memo
        tagLabel.textColor = data.isComplete ? Constants.Color.subtitleColor : Constants.Color.pointColor
        memoLabel.text = data.memo
        
        if let text = data.tag { // nil이면 숨기기
            tagLabel.text = "# \(text)"
            print("nil아님")
        } else {
            tagLabel.isHidden = true
            print("nil")

        }
        
        // 우선순위에 따라서 제목 앞에 느낌표 다르게
        switch data.priority {
        case 1:
            titleLabel.text = "! \(data.memoTitle)"
        case 2:
            titleLabel.text = "!! \(data.memoTitle)"
        case 3:
            titleLabel.text = "!!! \(data.memoTitle)"
        default:
            titleLabel.text = "\(data.memoTitle)"
        }

        deadlineLabel.text = data.deadlinstFormatString
    }
    
    func configureHierarchy() {
        contentView.addSubview(checkbox)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
        stackView.addSubview(memoLabel)
        smallStackView.addSubview(deadlineLabel)
        smallStackView.addSubview(tagLabel)
        stackView.addSubview(smallStackView)
        
    }
    
    func configureConstraints() {
        
        checkbox.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalTo(contentView).inset(10)
            make.leading.equalTo(contentView).inset(10)
        }
        
        // 전체 합하면 높이는 80
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkbox.snp.trailing).offset(10)
            make.top.equalTo(checkbox.snp.top)
            make.trailing.equalTo(contentView).inset(10)
            make.height.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalTo(contentView).inset(10)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(stackView)
            make.height.equalTo(20)
        }
        smallStackView.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(4)
            make.leading.bottom.trailing.equalTo(stackView)
        }
        
        deadlineLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(smallStackView)
            make.height.equalTo(20)
            
        }
        tagLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(smallStackView)
            make.leading.equalTo(deadlineLabel.snp.trailing).offset(4)
            make.height.equalTo(20)
        }
        
    }
    
    func configureView() {
        stackView.axis = .vertical
        smallStackView.axis = .horizontal
        
        checkbox.layer.cornerRadius = 10
        checkbox.layer.borderWidth = 0.5
        checkbox.layer.borderColor = UIColor.gray.cgColor
        
        titleLabel.font = Constants.Font.normalTitle
        
        memoLabel.textColor = Constants.Color.subtitleColor
        memoLabel.font = Constants.Font.subtitle
        
        deadlineLabel.textColor = Constants.Color.subtitleColor
        deadlineLabel.font = Constants.Font.subtitle
        
        tagLabel.font = Constants.Font.subtitle
    }

}
