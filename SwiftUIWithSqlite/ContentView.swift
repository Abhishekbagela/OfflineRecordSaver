//
//  ContentView.swift
//  SwiftUIWithSqlite
//
//  Created by Abhishek Bagela on 17/02/23.
//

import SwiftUI

class Record: Codable, Identifiable {
    var id     : String
    var name   : String?
    var calorie: String?
    var qty    : String?
    
    init(id: String = UUID().uuidString, name: String? = nil, calorie: String? = nil, qty: String? = nil) {
        self.id = id
        self.name = name
        self.calorie = calorie
        self.qty = qty
    }
}

class RecordViewModel: ObservableObject {
    
    @Published var records: [Record] = []
    
    func save(record: Record) {
        DB_Manager().save(rec: record)
    }
    
    func getAllRecords() {
        self.records = DB_Manager().getAllRecords()
    }
    
    func deleteRecord(recordId: String) {
        DB_Manager().delete(recordId: recordId)
    }
    
    func editRecord(record: Record) {
        DB_Manager().edit(rec: record)
    }
    
}


struct ContentView: View {
    @StateObject private var vm: RecordViewModel = RecordViewModel()
    
    var body: some View {
        VStack {
            AddRecordView()
                .environmentObject(vm)
            Divider()
            ShowAllRecordsView()
                .environmentObject(vm)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
