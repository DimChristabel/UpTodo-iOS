//
//  Task.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//



import Foundation

struct TaskItem: Identifiable, Codable {
    
    let id: String
    
    let title: String
    
    let description: String
    
    let dueDate: Date
    
    let dueTime: String
    
    var isCompleted: Bool
    
    let createdAt: Date
}













