//
//  DateViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit
import SnapKit

class DateViewController: BaseViewController {
    
    var date: ((Date) -> Void)?
   
    lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.preferredDatePickerStyle = .wheels
        view.datePickerMode = .date
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.backgroundColor

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let date else {
            return
        }
        date(datePicker.date)
    }
//    @objc
//    func datePickerSelected() {
//        
//    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
}



