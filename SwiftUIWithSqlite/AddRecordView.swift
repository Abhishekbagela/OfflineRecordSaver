//
//  AddRecordView.swift
//  SwiftUIWithSqlite
//
//  Created by Abhishek Bagela on 17/02/23.
//

import SwiftUI

struct AddRecordView: View {
    @EnvironmentObject private var vm: RecordViewModel
    
    @State private var name: String = .init()
    @State private var calorie: String = .init()
    @State private var qty: String = .init()
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Record")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            
            TextField("Enter Name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            TextField("Enter Calorie", text: $calorie)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            
            TextField("Enter Qty.", text: $qty)
                .textFieldStyle(.roundedBorder)
            
            Button {
                vm.save(record: Record(name: self.name,
                                       calorie: self.calorie,
                                       qty:  self.qty)
                )
                vm.getAllRecords()
            } label: {
                Text("Save")
            }
            .foregroundColor(.green)
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

struct AddRecordView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecordView()
    }
}
