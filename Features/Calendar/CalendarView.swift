//
//  CalendarView.swift
//  upToDo
//
//  Created by Maxut Consulting on 09/06/2026.
//


import SwiftUI

// MARK: - CalendarView
// Shows monthly calendar with task indicators
// Reuses tasks from HomeView via shared state
// (Firebase integration comes later)
struct CalendarView: View {
    
    // ── Currently selected date ──
    @State private var selectedDate = Date()
    
    // ── Sample tasks for UI preview ──
    // These will come from Firebase later
    @State private var tasks: [TaskItem] = [
        TaskItem(
            id: UUID().uuidString,
            title: "Do Math Homework",
            description: "Math Assignment",
            dueDate: Date(),
            dueTime: "16:45",
            isCompleted: false,
            createdAt: Date()
        ),
        TaskItem(
            id: UUID().uuidString,
            title: "Buy Grocery",
            description: "Milk and Bread",
            dueDate: Date(),
            dueTime: "16:45",
            isCompleted: true,
            createdAt: Date()
        )
    ]
    
    // ── Tasks for selected date ──
    private var tasksForSelectedDate: [TaskItem] {
        tasks.filter {
            Calendar.current.isDate(
                $0.dueDate,
                inSameDayAs: selectedDate)
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // ── Title ──
                Text("Calendar")
                    .font(.system(size: 18,
                                  weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.bottom, 16)
                
                // ── Monthly Calendar ──
                // Dates with tasks show a purple dot
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .tint(Color(red: 0.53,
                            green: 0.46,
                            blue: 1.0))
                .colorScheme(.dark)
                .padding(.horizontal, 16)
                
                Divider()
                    .background(Color.white.opacity(0.1))
                    .padding(.vertical, 8)
                
                // ── Tasks for selected date ──
                if tasksForSelectedDate.isEmpty {
                    
                    // No tasks on this date
                    VStack(spacing: 12) {
                        Spacer()
                        Image(systemName: "calendar.badge.exclamationmark")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                        Text("No tasks for this day")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    
                } else {
                    
                    // Tasks list for selected date
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(tasksForSelectedDate) { task in
                                CalendarTaskRow(task: task)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Calendar Task Row
struct CalendarTaskRow: View {
    let task: TaskItem
    
    var body: some View {
        HStack(spacing: 14) {
            
            // ── Colored dot indicator ──
            Circle()
                .fill(task.isCompleted
                      ? Color.gray
                      : Color(red: 0.53,
                              green: 0.46,
                              blue: 1.0))
                .frame(width: 8, height: 8)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(task.title)
                    .font(.system(size: 14,
                                  weight: .medium))
                    .foregroundColor(task.isCompleted
                                     ? .gray : .white)
                    .strikethrough(task.isCompleted,
                                   color: .gray)
                Text(task.dueTime)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.white.opacity(0.04))
        .cornerRadius(8)
        .padding(.vertical, 3)
    }
}

// MARK: - Preview
#Preview {
    CalendarView()
}




