//
//  toDo.swift
//  InteractiveWidgetKit
//
//  Created by Sabri Çetin on 9.10.2024.
//

import Foundation


struct ToDo : Identifiable  {
    let id : String = UUID().uuidString
    var name : String
    var isDone : Bool = false
}

class SharedDatas {
    
    static let shared = SharedDatas()
    
    var toDos : [ToDo] = [
        
        .init(name: "To Do 1") ,
        .init(name: "To Do 2") ,
        .init(name: "To Do 3")
    ]
}
