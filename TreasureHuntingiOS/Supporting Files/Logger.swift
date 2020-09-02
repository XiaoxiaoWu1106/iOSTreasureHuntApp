//
//  Logger.swift
//  TreasureHuntingiOS
//
//  Created by Ye Lu on 2.9.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import Foundation

class Logger {
    class func verbose(_ message: Any) {
        printInDebuggingEnvironment("⚪️", message: message)
    }
    class func debug(_ message: Any) {
        printInDebuggingEnvironment("⚫️", message: message)
    }
    class func info(_ message: Any) {
        printInDebuggingEnvironment("🔵", message: message)
    }
    class func warning(_ message: Any) {
        printInDebuggingEnvironment("🔶", message: message)
    }
    class func error(_ message: Any) {
        printInDebuggingEnvironment("🔴", message: message)
    }
    private class func printInDebuggingEnvironment(_ prefix: String, message: Any) {
        #if DEBUG
        print("\(prefix) \(message)")
        #endif
    }
}
