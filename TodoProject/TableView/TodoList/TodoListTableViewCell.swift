//
//  TodoListTableViewCell.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/15.
//

import UIKit
import SnapKit

class TodoListTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let deadlinePriorityLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(title: String, deadlinePriorityString: String) {
        titleLabel.text = title
        deadlinePriorityLabel.text = deadlinePriorityString
    }
    
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(deadlinePriorityLabel)
    }
    
    func configureConstraints() {
        
        // 전체 합하면 높이는 80
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView).inset(10)
            make.height.equalTo(20)
        }
        deadlinePriorityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView).inset(10)
            make.height.equalTo(20)
        }
    }
    
    func configureView() {
        
        titleLabel.textColor = Constants.Color.titleColor
        titleLabel.font = Constants.Font.normalTitle
        
        deadlinePriorityLabel.textColor = Constants.Color.subtitleColor
        deadlinePriorityLabel.font = Constants.Font.subtitle
    }

}
