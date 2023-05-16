//
//  AddView.swift
//  TodoList
//
//  Created by Eziz Abdylow on 14.05.2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    var body: some View {
        ScrollView {
            TextField("itemInput", text: $textFieldText, prompt: Text("Type something here").foregroundColor(.primary))
                .padding(.horizontal)
                .frame(height: 55)
                .background(.secondary)
                .cornerRadius(10)
            Button {
                saveButtonPressed()
            } label: {
                Text("SAVE")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(secondaryAccentColor)
                    .cornerRadius(10)
            }
        }
        .padding(14)
        .navigationTitle("Add An Item 🖋️")
        .alert(alertTitle, isPresented: $showAlert) {
            Button("Cancel", role: .cancel) {}
        }
    }
    
    func saveButtonPressed() {
        if textIsAppropiate() {
            listViewModel.addItem(title: textFieldText)
            dismiss()
        }
    }
    
    func textIsAppropiate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new todo item must be at least 3 characters long!!!"
            showAlert.toggle()
            return false
        }
        return true
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
                .environmentObject(ListViewModel())
        }
    }
}
