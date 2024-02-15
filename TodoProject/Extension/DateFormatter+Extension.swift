//
//  DateFormatter+Extension.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/16.
//

import Foundation

extension DateFormatter {
    static let Format: DateFormatter = {
        let format = DateFormatter()
        //        format.dateFormat = "yyyy년 MM월 dd일"
        format.dateFormat = "yyyy.M.d"
        return format
    }()

}
