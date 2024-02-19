//
//  AddTodoImageTableViewCell.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/20.
//

import UIKit

class AddTodoImageTableViewCell: UITableViewCell {

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
    
    let selectedImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
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
    
    func configureCell(titleList: [String], selectedImage: UIImage) {
        titleLabel.text = titleList[0]
        selectedImageView.image = selectedImage
    }

}

extension AddTodoImageTableViewCell {
    func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(selectedImageView)
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
        
        selectedImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing)
            make.size.equalTo(40)
        }
        nextImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(selectedImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(15)
            make.size.equalTo(15)
        }

    }

}
