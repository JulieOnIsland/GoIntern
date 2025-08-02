//
//  Application.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/15/25.
//

import Foundation
import SwiftData

@Model
class Application {
    var companyName: String
    var deadline: Date
    var isComplete: Bool
    var resumeStatus: Status
    var interviewStatus: Status
    var jobDescription: String
    var link: String
    
    init(companyName: String, deadline: Date, isComplete: Bool, resumeStatus: Status, interviewStatus: Status, jobDescription: String, link: String) {
        self.companyName = companyName
        self.deadline = deadline
        self.isComplete = isComplete
        self.resumeStatus = resumeStatus
        self.interviewStatus = interviewStatus
        self.jobDescription = jobDescription
        self.link = link
    }
}

enum Status: Codable {
    case pending
    case accepted
    case rejected
}
