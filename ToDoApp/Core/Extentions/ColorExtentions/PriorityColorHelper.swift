//
//  PriorityColorHelper.swift
//  upToDo
//
//  Created by Maxut Consulting on 16/06/2026.
//

import SwiftUI

// MARK: - Priority Color Helper

struct PriorityColorHelper {

    static func color(
        for priority: Int
    ) -> Color {

        switch priority {

        case 1...3:
            return .green

        case 4...6:
            return .yellow

        case 7...8:
            return .orange

        case 9...10:
            return .red

        default:
            return .gray
        }
    }
}
