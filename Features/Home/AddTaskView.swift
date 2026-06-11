//
//  AddTaskView.swift
//  upToDo
//
//  Created by Maxut Consulting on 31/05/2026.
//


import SwiftUI

// MARK: - AddTaskView
struct AddTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var title        = ""
    @State private var description  = ""
    @State private var showCalendar = false
    @State private var showTime     = false
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    
    var body: some View {
        ZStack {
            Color(red: 0.12, green: 0.12,
                  blue: 0.12).ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                // Add Task header
                HStack {
                    Text("Add Task")
                        .font(.system(size: 16,
                                      weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    
                    // ── Purple send arrow button ──
                    Button {
                        guard !title.isEmpty else { return }
                        dismiss()
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 15))
                            .foregroundColor(
                                title.isEmpty
                                ? Color.gray
                                : Color(red: 0.53,
                                        green: 0.46,
                                        blue: 1.0))
                    }
                    .disabled(title.isEmpty)
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 20)
                
                // ── Title field ──
                TextField("", text: $title,
                          prompt: Text("Do math homework")
                    .foregroundColor(.white))
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.08))
                    .cornerRadius(4)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                
                // ── Description field ──
                TextField("", text: $description,
                          prompt: Text("Description")
                    .foregroundColor(.gray))
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                
                Divider()
                    .background(Color.white.opacity(0.08))
                
                // ── Bottom icons row ──
                HStack {
                    // Clock icon — opens calendar
                    Button {
                        showCalendar = true
                    } label: {
                        Image(systemName: "clock")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    // Send arrow icon bottom right
                    Button {
                        guard !title.isEmpty else { return }
                        dismiss()
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 15))
                            .foregroundColor(
                                title.isEmpty
                                ? Color.gray
                                : Color(red: 0.53,
                                        green: 0.46,
                                        blue: 1.0))
                    }
                    .disabled(title.isEmpty)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                Spacer()
            }
        }
        // ── Calendar Sheet ──
        .sheet(isPresented: $showCalendar) {
            CalendarPickerView(
                selectedDate: $selectedDate,
                showCalendar: $showCalendar,
                showTime: $showTime
            )
            .presentationDetents([.medium])
            .presentationCornerRadius(16)
        }
        // ── Time Sheet ──
        .sheet(isPresented: $showTime) {
            TimePickerView(
                selectedTime: $selectedTime,
                showTime: $showTime
            )
            .presentationDetents([.height(300)])
            .presentationCornerRadius(16)
        }
    }
}

// MARK: - Calendar Picker
struct CalendarPickerView: View {
    @Binding var selectedDate: Date
    @Binding var showCalendar: Bool
    @Binding var showTime    : Bool
    
    var body: some View {
        ZStack {
            Color(red: 0.12, green: 0.12,
                  blue: 0.12).ignoresSafeArea()
            
            VStack(spacing: 0) {
                DatePicker("",
                           selection: $selectedDate,
                           displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .tint(Color(red: 0.53,
                                green: 0.46,
                                blue: 1.0))
                    .colorScheme(.dark)
                    .padding(.horizontal, 8)
                
                Spacer()
                
                // ── Cancel + Choose Time ──
                HStack {
                    Button("Cancel") {
                        showCalendar = false
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    
                    Spacer()
                    
                    Button("Choose Time") {
                        showCalendar = false
                        showTime     = true
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .bold))
                    .padding(.horizontal, 28)
                    .padding(.vertical, 12)
                    .background(Color(red: 0.53,
                                      green: 0.46,
                                      blue: 1.0))
                    .cornerRadius(4)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 36)
            }
        }
    }
}

// MARK: - Time Picker
struct TimePickerView: View {
    @Binding var selectedTime: Date
    @Binding var showTime    : Bool
    
    @State private var selectedHour   = 8
    @State private var selectedMinute = 20
    @State private var isAM           = true
    
    let hours   = Array(1...12)
    let minutes = Array(0...59)
    
    var body: some View {
        ZStack {
            Color(red: 0.12, green: 0.12,
                  blue: 0.12).ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // ── Title ──
                Text("Choose Time")
                    .font(.system(size: 16,
                                  weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 24)
                
                Divider()
                    .background(Color.white.opacity(0.1))
                    .padding(.top, 12)
                    .padding(.bottom, 20)
                
                // ── Hour : Minute AM/PM boxes ──
                HStack(spacing: 12) {
                    
                    // ── Hour box ──
                    VStack(spacing: 4) {
                        // Number above
                        Text(String(format: "%02d",
                                    selectedHour == 1
                                    ? 12
                                    : selectedHour - 1))
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        
                        // Selected box
                        Text(String(format: "%02d",
                                    selectedHour))
                            .font(.system(size: 32,
                                          weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 80, height: 64)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                        
                        // Number below
                        Text(String(format: "%02d",
                                    selectedHour == 12
                                    ? 1
                                    : selectedHour + 1))
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .gesture(DragGesture()
                        .onEnded { value in
                            if value.translation.height < 0 {
                                selectedHour = selectedHour == 12
                                ? 1 : selectedHour + 1
                            } else {
                                selectedHour = selectedHour == 1
                                ? 12 : selectedHour - 1
                            }
                        })
                    
                    // ── Colon ──
                    Text(":")
                        .font(.system(size: 32,
                                      weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    // ── Minute box ──
                    VStack(spacing: 4) {
                        // Number above
                        Text(String(format: "%02d",
                                    selectedMinute == 0
                                    ? 59
                                    : selectedMinute - 1))
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        
                        // Selected box
                        Text(String(format: "%02d",
                                    selectedMinute))
                            .font(.system(size: 32,
                                          weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 80, height: 64)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                        
                        // Number below
                        Text(String(format: "%02d",
                                    selectedMinute == 59
                                    ? 0
                                    : selectedMinute + 1))
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .gesture(DragGesture()
                        .onEnded { value in
                            if value.translation.height < 0 {
                                selectedMinute = selectedMinute == 59
                                ? 0 : selectedMinute + 1
                            } else {
                                selectedMinute = selectedMinute == 0
                                ? 59 : selectedMinute - 1
                            }
                        })
                    
                    // ── AM/PM box ──
                    VStack(spacing: 4) {
                        // Above
                        Text(isAM ? "PM" : "AM")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        
                        // Selected box
                        Text(isAM ? "AM" : "PM")
                            .font(.system(size: 24,
                                          weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 72, height: 64)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                        
                        // Below
                        Text(isAM ? "PM" : "AM")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        isAM.toggle()
                    }
                }
                .padding(.bottom, 28)
                
                // ── Cancel + Save ──
                HStack(spacing: 12) {
                    Button("Cancel") {
                        showTime = false
                    }
                    .foregroundColor(Color(red: 0.53,
                                          green: 0.46,
                                          blue: 1.0))
                    .font(.system(size: 15, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    
                    Button("Save") {
                        var components = Calendar.current
                            .dateComponents([.year, .month, .day],
                                            from: Date())
                        components.hour = isAM
                        ? selectedHour
                        : selectedHour + 12
                        components.minute = selectedMinute
                        if let date = Calendar.current
                            .date(from: components) {
                            selectedTime = date
                        }
                        showTime = false
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color(red: 0.53,
                                      green: 0.46,
                                      blue: 1.0))
                    .cornerRadius(4)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    AddTaskView()
}






