//
//  Enumeration.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/14.
//

import UIKit

enum Constants {

    
    enum Color {
        static let backgroundColor = UIColor.black
        static let addViewBackgroundColor = UIColor.systemGray6
        static let addViewTableColor = UIColor.systemGray5
        
        static let titleColor = UIColor.white
        static let subtitleColor = UIColor.systemGray2
        
        static let tagColor = UIColor.blue
        
        static let pointColor = UIColor.systemPink
        static let pointColor2 = UIColor.red
        static let pointColor3 = UIColor.green
    }
    enum Font {
        static let boldBigTitle: UIFont = .boldSystemFont(ofSize: 24)
        static let boldTitle: UIFont = .boldSystemFont(ofSize: 20)
        static let subtitle: UIFont = .systemFont(ofSize: 14)
        static let normalTitle: UIFont = .systemFont(ofSize: 15)
    }
    enum Image {
        static let eclipes = UIImage(systemName: "ellipsis.circle.fill")
    }
}

// 힐 일 추가할 때 리스트들
// Int로 후에 리팩토링하기
enum TodoList: String, CaseIterable {
    case memoBox = "메모"
    case deadline = "마감일"
    case tag = "태그"
    case priority = "우선 순위"
    case addImage = "이미지 추가"
    
    var todoListString: String {
        String(describing: self)
    }
    
    var tableViewCellTitle: [String] {
        switch self {
        case .memoBox:
            return ["제목", "메모"]
        default:
            return [self.rawValue] // 그대로 출력, subtitle
        }
    }
//    
//    func pushViewCon<T: BaseViewController>() -> T {
//        switch self {
//        case .deadline:
//            return DateViewController() as! T
//        case .tag:
//            return TagViewController() as! T
//        case .priority:
//            return PriorityViewController() as! T
//        default:
//            return UIViewController() as! T
//        }
//    }
}

enum TodoClassify: Int, CaseIterable {
    case today = 0
    case expected
    case entire
    case flag
    case completed
    
    var titleString: String {
        switch self {
        case .today:
            return "오늘"
        case .expected:
            return "예정"
        case .entire:
            return "전체"
        case .flag:
            return "깃발 표시"
        case .completed:
            return "완료됨"
        }
    }
    
    var systemImage: UIImage { // UIImage에는 tintColor가 없다.
        var systemname = ""
        switch self {
        case .today:
            systemname = "calendar.circle.fill"
        case .expected:
            systemname = "calendar.circle.fill"
        case .entire:
            systemname = "tray.circle.fill"
        case .flag:
            systemname = "flag.circle.fill"
        case .completed:
            systemname = "checkmark.circle.fill"
        }
        return UIImage(systemName: systemname) ?? UIImage()
    }
    
    var systmeImageViewTint: UIColor {
        switch self {
        case .today:
            return .systemBlue
        case .expected:
            return .red
        case .entire:
            return .gray
        case .flag:
            return .orange
        case .completed:
            return .gray
        }
    }
}
