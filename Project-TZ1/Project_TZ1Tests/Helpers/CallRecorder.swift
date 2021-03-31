//
//  CallRecorder.swift
//  Project_TZ1Tests
//
//  Created by Роман Тищенко on 24.03.2021.
//

import Foundation

enum CallType: String {
    case mainViewShowPhotos
    case detailViewShowMedia
}

final class CallRecorder {
    
    private var calls = [String: Int]()
    
    func recordCall(callType: CallType) {
        guard let callCount = calls[callType.rawValue] else {
            calls[callType.rawValue] = 1
            return
        }
        calls[callType.rawValue] = callCount + 1
    }
    
    func isCallRecorded(callType: CallType) -> Bool {
        calls.contains(where: { $0.key == callType.rawValue })
    }
    
    func getCallsCount(callType: CallType) -> Int {
        return calls[callType.rawValue] ?? 0
    }
    
    func deleteRecord(callType: CallType) {
        calls.removeValue(forKey: callType.rawValue)
    }
    
    func deleteAllRecords() {
        calls.removeAll()
    }
}
