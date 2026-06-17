

import SwiftUI

// MARK: - HomeView

/// Main dashboard screen of the application.
///
/// Displays active and completed tasks,
/// supports searching and filtering,
/// allows task management actions,
/// and provides access to user profile information.

struct HomeView: View {

    // MARK: Properties
@ObservedObject var viewModel: TaskViewModel

let onProfileTapped: () -> Void

@State
private var selectedTask: AppTask?
@State private var taskToDelete: AppTask?

@State
private var showFilterMenu = false
 
    // MARK: Body

    var body: some View {

    NavigationStack {

        ZStack {

            Color.black
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: Navigation Header

                HStack {

                    Button {

                        showFilterMenu = true

                    } label: {

                        Image(
                            systemName: "line.3.horizontal.decrease"
                        )
                        .font(.title2)
                        .foregroundColor(.white)
                    }

                    Spacer()

                    Text("Index")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.white)

                    Spacer()

                    Button {

                        print("PROFILE IMAGE TAPPED")

                        onProfileTapped()

                    } label: {

                        Group {

                            if let image =
                                viewModel.profileUIImage {

                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()

                            } else {

                                Image("profileImage")
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                        .frame(
                            width: 42,
                            height: 42
                        )
                        .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)

                // MARK: Task Filter Options

                .confirmationDialog(
                    "Filter Tasks",
                    isPresented: $showFilterMenu
                ) {

                    Button("Today's Tasks") {

                        viewModel.todayOnlyFilter = true
                    }

                    Button("All Tasks") {

                        viewModel.todayOnlyFilter = false
                    }

                    Button(
                        "Cancel",
                        role: .cancel
                    ) { }
                }

                // MARK: Empty Task State

                if viewModel.tasks.isEmpty {

                    Spacer()

                    EmptyHomeView()

                    Spacer()

                } else {
                    
                    VStack(spacing: 16) {
                        
                        // MARK: Task Search
                        
                        HStack {
                            
                            Image(
                                systemName: "magnifyingglass"
                            )
                            .foregroundColor(.gray)
                            
                            TextField(
                                "",
                                text: $viewModel.searchText,
                                prompt: Text(
                                    "Search for your task..."
                                )
                                .foregroundColor(.gray)
                            )
                            .foregroundColor(.white)
                        }
                        .padding()
                        .background(
                            Color.white.opacity(0.08)
                        )
                        .cornerRadius(12)
                        .padding(.top, 24)
                        
                        
                        // MARK: Quick Filters
                        
                        HStack {
                            
                            Button {
                                
                                viewModel.todayOnlyFilter = true
                                
                            } label: {
                                
                                Text("Today")
                                    .font(.caption)
                                    .foregroundColor(
                                        viewModel.todayOnlyFilter
                                        ? .white
                                        : .gray
                                    )
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        viewModel.todayOnlyFilter
                                        ? Color("MildPurple")
                                        : Color.white.opacity(0.08)
                                    )
                                    .cornerRadius(20)
                            }
                            
                            Button {
                                
                                viewModel.todayOnlyFilter = false
                                
                            } label: {
                                
                                Text("All")
                                    .font(.caption)
                                    .foregroundColor(
                                        !viewModel.todayOnlyFilter
                                        ? .white
                                        : .gray
                                    )
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        !viewModel.todayOnlyFilter
                                        ? Color("MildPurple")
                                        : Color.white.opacity(0.08)
                                    )
                                    .cornerRadius(20)
                            }
                            
                            Spacer()
                        }
                        
                        // MARK: Today Filter Label
                        
                        if viewModel.todayOnlyFilter {
                            
                            HStack {
                                
                                Image(systemName: "calendar")
                                
                                Text(
                                    "Showing Today's Tasks"
                                )
                            }
                            .font(.caption)
                            .foregroundColor(
                                Color("MildPurple")
                            )
                        }
                        
                        // MARK: Search Results Empty State
                        
                        if viewModel.filteredTasks.isEmpty {
                            
                            Spacer()
                            
                            VStack(spacing: 16) {
                                
                                Image(
                                    systemName: "magnifyingglass"
                                )
                                .font(
                                    .system(size: 50)
                                )
                                .foregroundColor(.gray)
                                
                                Text("Task not found")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(
                                    "Try searching with another keyword"
                                )
                                .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                        } else {
                            
                            List {
                                
                                // MARK: Active Task List
                                
                                if !viewModel.activeTasks.isEmpty {
                                    
                                    Section {
                                        
                                        ForEach(
                                            viewModel.activeTasks
                                        ) { task in
                                            
                                            TaskCard(
                                                task: task,

                                                onToggle: {

                                                    viewModel.toggleTask(task)
                                                },

                                                onTap: {

                                                    selectedTask = task
                                                }
                                            )
                                            .listRowBackground(Color.black)
                                            .listRowSeparator(.hidden)
                                            .listRowInsets(
                                                EdgeInsets(
                                                    top: 8,
                                                    leading: 0,
                                                    bottom: 8,
                                                    trailing: 0
                                                )
                                            )
                                            .swipeActions(
                                                edge: .trailing
                                            )  {
                                                
                                                Button(
                                                    role: .destructive
                                                ) {
                                                    
                                                    taskToDelete = task
                                                    
                                                } label: {
                                                    
                                                    Label(
                                                        "Delete",
                                                        systemImage: "trash"
                                                    )
                                                }
                                            }
                                        }
                                        
                                    } header: {
                                        
                                        Text("Tasks")
                                            .foregroundColor(.white)
                                    }
                                }
                                
                                // MARK: Completed Task List
                                
                                if !viewModel.completedTasks.isEmpty {
                                    
                                    Section {
                                        
                                        ForEach(viewModel.completedTasks) { task in
                                            
                                            TaskCard(
                                                task: task,
                                                onToggle: {
                                                    viewModel.toggleTask(task)
                                                },
                                                onTap: {
                                                    selectedTask = task
                                                }
                                            )
                                            .listRowBackground(Color.black)
                                            .listRowSeparator(.hidden)
                                            .listRowInsets(
                                                EdgeInsets(
                                                    top: 8,
                                                    leading: 0,
                                                    bottom: 8,
                                                    trailing: 0))
                                        }
                                        
                                    } header: {
                                        
                                        HStack {
                                            
                                            Text("Completed")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .listStyle(.plain)
                            .scrollContentBackground(.hidden)
                            .background(Color.black)
                            .environment(
                                \.defaultMinListRowHeight,
                                90
                            )
                            .padding(.horizontal, 24)
                        }
                       
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
        // MARK: Task Detail Sheet
    .sheet(
        item: $selectedTask
    ) { task in

        TaskDetailView(
            viewModel: viewModel,
            task: task
        )
    }
    
        // MARK: Delete Confirmation Alert
    .alert(
        "Delete Task?",
        isPresented: Binding(
            get: {
                taskToDelete != nil
            },
            set: { value in

                if !value {

                    taskToDelete = nil
                }
            }
        )
    ) {

        Button(
            "Delete",
            role: .destructive
        ) {

            if let task = taskToDelete {

                viewModel.deleteTask(task)
            }

            taskToDelete = nil
        }

        Button(
            "Cancel",
            role: .cancel
        ) {

            taskToDelete = nil
        }

    } message: {

        Text(
            "This task will be permanently deleted."
        )
    }
}


}

// MARK: - Preview

#Preview {


HomeView(
    viewModel: TaskViewModel(),
    onProfileTapped: {}
)
.preferredColorScheme(.dark)


}
