//
//  HomeComponent.swift
//  upToDo
//
//  Created by Maxut Consulting on 11/06/2026.
//

import SwiftUI

// MARK: - Search Bar
// Search input with magnifying glass icon
// Used in: HomeView
struct HomeSearchBar: View {
    @Binding var text  : String
    var placeholder    : String  = "Search for your task..."
    var bgColor        : Color   = Color.white.opacity(0.07)
    var cornerRadius   : CGFloat = 4
    var iconColor      : Color   = .gray
    var textColor      : Color   = .gray
    var fontSize       : CGFloat = 16
    var height         : CGFloat = 48
    var horizPad       : CGFloat = 12
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(iconColor)
                .font(.system(size: fontSize))
            TextField(placeholder, text: $text)
                .foregroundColor(textColor)
                .font(.system(size: fontSize))
        }
        .padding(.horizontal, horizPad)
        .frame(height: height)
        .background(bgColor)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.gray, lineWidth: 0.8)
        )
    }
}

// MARK: - Today Chip
// Filter chip that toggles today/all tasks
// Used in: HomeView
struct TodayFilterChip: View {
    @Binding var isActive: Bool
    var activeColor  : Color   = Color("MildPurple")
    var inactiveColor: Color   = Color.gray
    var fontSize     : CGFloat = 16
    var width        : CGFloat = 110
    var height       : CGFloat = 31
    var cornerRadius : CGFloat = 6
    
    var body: some View {
        Button {
            isActive.toggle()
        } label: {
            HStack(spacing: 6) {
                Text("Today")
                    .font(.system(size: fontSize,
                                  weight: .regular))
                Image(systemName: isActive
                      ? "checkmark" : "circle")
                Image(systemName: "chevron.down")
            }
            .foregroundColor(.white)
            .frame(width: width, height: height)
            .background(isActive
                        ? activeColor
                        : inactiveColor)
            .cornerRadius(cornerRadius)
        }
    }
}

// MARK: - Completed Section Chip
// Purple chip showing "Completed" label
// Used in: HomeView task list
struct CompletedChip: View {
    var bgColor     : Color   = Color("MildPurple")
    var fontSize    : CGFloat = 12
    var fontWeight  : Font.Weight = .medium
    var textColor   : Color   = .white
    var horizPad    : CGFloat = 10
    var vertPad     : CGFloat = 5
    var cornerRadius: CGFloat = 4
    
    var body: some View {
        HStack {
            HStack(spacing: 6) {
                Text("Completed")
                    .font(.system(size: fontSize,
                                  weight: fontWeight))
                    .foregroundColor(textColor)
                Image(systemName: "chevron.down")
                    .font(.system(size: fontSize))
                    .foregroundColor(textColor)
            }
            .padding(.horizontal, horizPad)
            .padding(.vertical, vertPad)
            .background(bgColor)
            .cornerRadius(cornerRadius)
            Spacer()
        }
    }
}

// MARK: - Task Row
// Single task item in the list
// Used in: HomeView, CalendarView
struct TaskRowView: View {
    let task    : TaskItem
    let onToggle: () -> Void
    
    // ── Change row properties here ──
    var checkboxSize    : CGFloat = 22
    var checkboxBorder  : CGFloat = 1.5
    var titleFontSize   : CGFloat = 14
    var timeFontSize    : CGFloat = 11
    var rowBgColor      : Color   = Color.white.opacity(0.04)
    var rowCornerRadius : CGFloat = 8
    var rowHorizPad     : CGFloat = 16
    var rowVertPad      : CGFloat = 14
    var rowSpacing      : CGFloat = 3
    var activeColor     : Color   = Color("PurpleColor")
    
    var body: some View {
        HStack(spacing: 14) {
            
            // ── Checkbox ──
            Button(action: onToggle) {
                ZStack {
                    Circle()
                        .strokeBorder(
                            task.isCompleted
                            ? activeColor
                            : Color.gray.opacity(0.6),
                            lineWidth: checkboxBorder)
                        .frame(width: checkboxSize,
                               height: checkboxSize)
                    if task.isCompleted {
                        Circle()
                            .fill(activeColor)
                            .frame(width: checkboxSize * 0.55,
                                   height: checkboxSize * 0.55)
                    }
                }
            }
            
            // ── Task info ──
            VStack(alignment: .leading, spacing: 3) {
                Text(task.title)
                    .font(.system(size: titleFontSize,
                                  weight: .medium))
                    .foregroundColor(task.isCompleted
                                     ? .gray : .white)
                    .strikethrough(task.isCompleted,
                                   color: .gray)
                Text("Today At \(task.dueTime)")
                    .font(.system(size: timeFontSize))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal, rowHorizPad)
        .padding(.vertical, rowVertPad)
        .background(rowBgColor)
        .cornerRadius(rowCornerRadius)
        .padding(.horizontal, rowHorizPad)
        .padding(.vertical, rowSpacing)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 16) {
            HomeSearchBar(text: .constant(""))
                .padding(.horizontal, 16)
            TodayFilterChip(isActive: .constant(true))
                .padding(.horizontal, 16)
            CompletedChip()
                .padding(.horizontal, 16)
            TaskRowView(
                task: TaskItem(
                    id: UUID().uuidString,
                    title: "Do Math Homework",
                    description: "",
                    dueDate: Date(),
                    dueTime: "16:45",
                    isCompleted: false,
                    createdAt: Date()
                )
            ) { }
        }
    }
}





