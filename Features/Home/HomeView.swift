

import SwiftUI

// MARK: - HomeView
struct HomeView: View {

    @State private var showAddTask   = false
    @State private var searchText    = ""
    @State private var showTodayOnly = true

    @State private var tasks: [TaskItem] = [
        TaskItem(id: UUID().uuidString,
                 title: "Do Math Homework",
                 description: "Math Assignment",
                 dueDate: Date(),
                 dueTime: "16:45",
                 isCompleted: false,
                 createdAt: Date()),

        TaskItem(id: UUID().uuidString,
                 title: "Take out dogs",
                 description: "Evening walk",
                 dueDate: Date(),
                 dueTime: "18:20",
                 isCompleted: false,
                 createdAt: Date()),

        TaskItem(id: UUID().uuidString,
                 title: "Business meeting with CEO",
                 description: "Discuss roadmap",
                 dueDate: Date(),
                 dueTime: "08:15",
                 isCompleted: false,
                 createdAt: Date()),

        TaskItem(id: UUID().uuidString,
                 title: "Buy Grocery",
                 description: "Milk and Bread",
                 dueDate: Date(),
                 dueTime: "16:45",
                 isCompleted: true,
                 createdAt: Date())
    ]

    // MARK: - Filters
    private var filteredTasks: [TaskItem] {
        searchText.isEmpty
        ? tasks
        : tasks.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var displayedTasks: [TaskItem] {
        guard showTodayOnly else { return filteredTasks }
        return filteredTasks.filter {
            Calendar.current.isDateInToday($0.dueDate)
        }
    }

    private var incompleteTasks: [TaskItem] {
        displayedTasks.filter { !$0.isCompleted }
    }

    private var completedTasks: [TaskItem] {
        displayedTasks.filter { $0.isCompleted }
    }

    // MARK: - UI
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {

                // Top Bar
                HStack {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)

                    Spacer()

                    Text("Index")
                        .foregroundColor(.white)
                        .font(.system(size: 20))

                    Spacer()

                    Image("ProfileImage2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 42, height: 42)
                        .clipShape(Circle())
                }
                .padding()

                if displayedTasks.isEmpty {

                    Spacer()

                    Image("empty_state")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 227, height: 227)

                    Text("What do you want to do today?")
                        .foregroundColor(.white)

                    Text("Tap + to add your tasks")
                        .foregroundColor(.white)

                    Spacer()

                } else {

                    ScrollView {
                        VStack(spacing: 0) {

                            ForEach(incompleteTasks) { task in
                                TaskRowView(task: task) {
                                    toggleTask(task)
                                }
                            }

                            if !completedTasks.isEmpty {

                                Text("Completed")
                                    .foregroundColor(.white)

                                ForEach(completedTasks) { task in
                                    TaskRowView(task: task) {
                                        toggleTask(task)
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 120)
                    }
                }
            }
        }
    }

    // MARK: - FUNCTIONS (CORRECT PLACE)
    func toggleTask(_ task: TaskItem) {
        if let i = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[i].isCompleted.toggle()
        }
    }
}

// MARK: - Task Row
struct TaskRowView: View {
    let task    : TaskItem
    let onToggle: () -> Void
    
    var body: some View {
        HStack(spacing: 14) {
            Button(action: onToggle) {
                ZStack {
                    Circle()
                        .strokeBorder(
                            task.isCompleted
                            ? Color("MildPurple")
                            : Color.gray,
                            lineWidth: 1.5)
                        .frame(width: 16, height: 16)
                    
                    if task.isCompleted {
                        Circle()
                            .fill(Color("MildPurple"))
                            .frame(width: 16, height: 16)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text(task.title)
                    .font(.system(size: 16,
                                  weight: .regular))
                    .frame(width: .infinity, height: 21, alignment: .leading)
                    .foregroundColor(task.isCompleted
                                     ? .gray : .white)
                    .strikethrough(task.isCompleted,
                                   color: .gray)
                
                Text("Today At \(task.dueTime)")
                    .frame(width: .infinity, height: 21)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(width: 372, height: 72, alignment: .leading)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal, 14)
        .padding(.vertical, 7)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
