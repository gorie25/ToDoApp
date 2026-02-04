import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Today's Tasks")
                            .font(.system(size: 28, weight: .bold))
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "bell.fill")
                            .font(.title3)
                            .foregroundColor(.primary)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    
                    // Calendar Week View
                    weekCalendarView
                        .padding(.horizontal)
                        .padding(.bottom, 12)
                    
                    // Filter Chips
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            FilterChip(title: "All", isSelected: viewModel.selectedFilter == nil) {
                                viewModel.selectedFilter = nil
                            }
                            
                            ForEach(TaskStatus.allCases, id: \.self) { status in
                                FilterChip(title: status.title, isSelected: viewModel.selectedFilter == status) {
                                    viewModel.selectedFilter = status
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 12)
                    
                    // Task List
                    let tasks = viewModel.filteredTasks(from: viewModel.taskGroups)
                    if tasks.isEmpty {
                        emptyStateView
                    } else {
                        List {
                            ForEach(tasks) { task in
                                TaskRowView(task: task)
                                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .listRowBackground(Color.clear)
                            }
                            .onDelete { indexSet in
                                Task {
                                    await viewModel.deleteTask(at: indexSet, from: tasks, in: viewModel.taskGroups)
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
                
                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { viewModel.showAddTask = true }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.purple, Color.blue]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .clipShape(Circle())
                                .shadow(color: Color.purple.opacity(0.4), radius: 12, x: 0, y: 6)
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 24)
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                Task {
                    await viewModel.fetchData()
                }
            }
            .sheet(isPresented: $viewModel.showAddTask) {
                NavigationStack {
                    AddTaskView(viewModel: AddTaskViewModel(getTaskGroupsUseCase: AppDependencies.shared.getTaskGroupsUseCase))
                }
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.5))
            
            Text("No tasks yet")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.gray)
            
            Text("Add a task to get started")
                .font(.system(size: 16))
                .foregroundColor(.gray.opacity(0.8))
        }
        .frame(maxHeight: .infinity)
    }
    
    private var weekCalendarView: some View {
        let calendar = Calendar.current
        let today = Date()
        let weekDates = (-3...3).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: today)
        }
        
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(weekDates, id: \.self) { date in
                    VStack(spacing: 8) {
                        Text(dayOfWeek(date))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(isSameDay(date, viewModel.selectedDate) ? .white : .gray)
                        
                        Text("\(calendar.component(.day, from: date))")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(isSameDay(date, viewModel.selectedDate) ? .white : .primary)
                    }
                    .frame(width: 50, height: 70)
                    .background(
                        isSameDay(date, viewModel.selectedDate) ?
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ) :
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(16)
                    .onTapGesture {
                        viewModel.selectedDate = date
                    }
                }
            }
        }
    }
    
    private func dayOfWeek(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date).uppercased()
    }
    
    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    isSelected ?
                    LinearGradient(
                        gradient: Gradient(colors: [Color.purple, Color.blue]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ) :
                    LinearGradient(
                        gradient: Gradient(colors: [Color(UIColor.secondarySystemBackground)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(20)
        }
    }
}
}

#Preview {
    HomeView()
        .modelContainer(for: TaskGroup.self, inMemory: true)
}
