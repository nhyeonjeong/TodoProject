//
//  DateViewController.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit
import SnapKit

class DateViewController: BaseViewController {
    
    var date: ((String) -> Void)?
    
    let format: DateFormatter = {
        let format = DateFormatter()
        //        format.dateFormat = "yyyy년 MM월 dd일"
        format.dateFormat = "yyyy.M.d"
        return format
    }()
   
    lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.preferredDatePickerStyle = .wheels
        view.datePickerMode = .date
//        view.addTarget(self, action: #selector(datePickerSelected), for: .valueChanged)
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
        let result = format.string(from: datePicker.date)
        date(result)
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



