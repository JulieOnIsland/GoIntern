//
//  Message.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/15/25.
//

import Foundation
import SwiftData

@Model
class Message {
    var name: String
    var place: String
    var memo: String
    var createdDate: Date
    var content: String
    
    init(name: String, place: String, memo: String, createdDate: Date, content: String) {
        self.name = name
        self.place = place
        self.memo = memo
        self.createdDate = createdDate
        self.content = content
    }
}
