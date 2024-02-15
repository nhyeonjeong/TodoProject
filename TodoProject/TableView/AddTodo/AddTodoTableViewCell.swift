//
//  AddTodoTableViewCell.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit

class AddTodoTableViewCell: UITableViewCell {
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.addViewTableColor
        view.layer.cornerRadius = 10
        return view
    }()
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.Color.titleColor
        return view
    }()
    
    let subTitleLabel: UILabel = {
        let view = UILabel()
        view.font = Constants.Font.normalTitle
        view.textColor = Constants.Color.subtitleColor
        view.textAlignment = .right
        return view
    }()
    
    let nextImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(systemName: "chevron.forward")
        view.contentMode = .scaleAspectFit
        view.tintColor = Constants.Color.subtitleColor
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear // 없으면 안돼

        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(titleList: [String], subtitle: String) {
        titleLabel.text = titleList[0]
        subTitleLabel.text = subtitle
    }

}

extension AddTodoTableViewCell {
    func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(subTitleLabel)
        backView.addSubview(nextImageView)

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
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing)
        }
        nextImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(subTitleLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(15)
            make.size.equalTo(15)
        }

    }
    
}
