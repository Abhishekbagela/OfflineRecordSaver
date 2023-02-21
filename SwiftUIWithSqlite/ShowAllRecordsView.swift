//
//  ShowAllRecordsView.swift
//  SwiftUIWithSqlite
//
//  Created by Abhishek Bagela on 17/02/23.
//

import SwiftUI

struct ShowAllRecordsView: View {
    @EnvironmentObject private var vm: RecordViewModel
    
    @State private var selectedRecord: Record = .init()
    @State private var recordSelected: Bool = false
    
    @State private var name: String = .init()
    @State private var calorie: String = .init()
    @State private var qty: String = .init()
    
    var body: some View {
        VStack {
            HStack {
                Text("All Record")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            List(vm.records, id: \.id) { record in
                HStack {
                    Text("Name: \(record.name ?? "")")
                    Text("Calories: \(record.calorie ?? "")")
                    Text("Quantity:\(record.qty ?? "")")
                    
                    Spacer()
                    
                    Button {
                        self.selectedRecord = record
                        self.recordSelected = true
                    } label: {
                        Text("Edit")
                            .foregroundColor(.blue)
                    }.buttonStyle(PlainButtonStyle())
                    
                    Button {
                        vm.deleteRecord(recordId: record.id)
                        vm.getAllRecords()
                    } label: {
                        Text("Delete")
                            .foregroundColor(.red)
                    }.buttonStyle(PlainButtonStyle())
                    
                }
                
            }.listStyle(.plain)
                
        }
        .sheet(isPresented: $recordSelected, content: {
            withAnimation(.easeOut) {
                VStack {
                    HStack {
                        Text("Update Record")
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
                        recordSelected.toggle()
                        vm.editRecord(record: Record(id: selectedRecord.id,
                                                     name: self.name,
                                                     calorie: self.calorie,
                                                     qty: self.qty
                                                    ))
                        vm.getAllRecords()
                    } label: {
                        Text("Save")
                            .foregroundColor(.green)
                    }.buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                }
                .padding()
                .onAppear {
                    self.name    = selectedRecord.name ?? ""
                    self.calorie = selectedRecord.calorie ?? ""
                    self.qty     = selectedRecord.qty ?? ""
                }

            }
        })
        .padding()
        .onAppear {
            vm.getAllRecords()
        }
    }
}

struct ShowAllRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllRecordsView()
    }
}
