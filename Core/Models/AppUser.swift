//
//  AppUser.swift
//  upToDo
//
//  Created by Maxut Consulting on 04/06/2026.
//

import Foundation


struct AppUser: Identifiable, Codable {
    
    let id: String
    let displayName: String
    let email: String
    let avatarURL: String
    let createdAt: Date
}






