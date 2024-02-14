//
//  AddTodoTableViewCell.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit

class AddTodoTableViewCell: UITableViewCell {
    
    let backView = UIView()
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.Color.titleColor
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear // 없으면 안돼
        backView.backgroundColor = Constants.Color.addViewTableColor

        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(titleList: [String]) {
        titleLabel.text = titleList[0]
    }

}

extension AddTodoTableViewCell {
    func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(titleLabel)

    }
    
    func configureConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }

    }
    
    func configureView() {
        backView.layer.cornerRadius = 10
        titleLabel.font = Constants.Font.talbeViewTitle
    }
    
}
