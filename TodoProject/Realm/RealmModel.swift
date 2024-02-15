//
//  TodoRealmModel.swift
//  TodoProject
//
//  Created by 남현정 on 2024/02/15.
//

import Foundation
import RealmSwift

class TodoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var memoTitle: String
    @Persisted var memo: String?
    @Persisted var deadline: String
    @Persisted var tag: String?
    @Persisted var priority: Int // 우선순위는 Int타입으로
    
    init(memoTitle: String, memo: String? = nil, deadline: String, tag: String? = nil, priority: Int) {
        
        self.init()
        self.memoTitle = memoTitle
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
    }
}

