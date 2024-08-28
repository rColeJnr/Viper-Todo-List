//
//  VtlDummyData.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import Foundation

struct Todo {
    let name: String
    let details: String
    let dateCreated: String
    let status: Bool
    
    init(name: String, details: String, dateCreated: String, status: Bool) {
        self.name = name
        self.details = details
        self.dateCreated = dateCreated
        self.status = status
    }
}

let dummyData = [
    Todo(name: "Memorize a poem", details: "Memorize a love poem to recite to someonMemorize a love poem to recite to someonMemorize a love poem to recite to someone", dateCreated: "28/08/2024", status: true),
    Todo(name: "Memorize another poem", details: "Memorize yet a love poem to recite to someone", dateCreated: "28/08/2024", status: false),
    Todo(name: "Memorize yet another poem", details: "Memorize one more love poem to recite to someone", dateCreated: "28/08/2024", status: false),
    Todo(name: "Memorize yet another poem", details: "Memorize one more love poem to recite to someone", dateCreated: "28/08/2024", status: false),
    Todo(name: "Memorize yet another poem", details: "Memorize one more love poem to recite to someone", dateCreated: "28/08/2024", status: false),
]
