//
//  ContentView.swift
//  ToDoList
//
//  Created by Owsito on 18.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [String] = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
    @State private var newTask = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Yeni görev ekle", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)
                    
                    Button(action: addTask) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                    .padding(.trailing)
                    .disabled(newTask.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding(.vertical)
                
                if tasks.isEmpty {
                    Spacer()
                    Text("Görev listen boş.")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List {
                        ForEach(tasks, id: \.self) { task in
                            Text(task)
                        }
                        .onDelete(perform: deleteTasks)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("To Do List")
            .toolbar {
                EditButton()
            }
        }
    }
    
    func addTask() {
        let trimmed = newTask.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        
        tasks.append(trimmed)
        newTask = ""
        saveTasks()
    }
    
    func deleteTasks(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }
    
    func saveTasks() {
        UserDefaults.standard.set(tasks, forKey: "tasks")
    }
}
