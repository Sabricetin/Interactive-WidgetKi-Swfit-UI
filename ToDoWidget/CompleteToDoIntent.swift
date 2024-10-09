//
//  CompleteToDoIntent.swift
//  InteractiveWidgetKit
//
//  Created by Sabri Çetin on 9.10.2024.
//

import Foundation
import SwiftUI
import AppIntents

struct CompleteToDoIntent : AppIntent {
    
    
    
    static var title: LocalizedStringResource = "Complete To Do"
    
    @Parameter(title: "ToDo Id")
    var id : String
    
    init() {
        
    }
    
    init(id: String) {
        self.id = id
    }
    
    func perform() async throws -> some IntentResult {
        
        if let index = SharedDatas.shared.toDos.firstIndex(where: {
            $0.id == id
            
        }) {
            SharedDatas.shared.toDos[index].isDone.toggle()
            print("Database Updated")

        }
        
        
        return .result()
    }
}
