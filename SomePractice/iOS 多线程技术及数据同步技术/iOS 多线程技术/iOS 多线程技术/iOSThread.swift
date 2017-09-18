//
//  iOSThread.swift
//  iOS 多线程技术
//
//  Created by 白彬涵 on 2017/9/15.
//  Copyright © 2017年 CMIOT. All rights reserved.
//

import Foundation

class iOSThread: NSObject {
    func main() {
        NSThreadFun()
    }
}

extension iOSThread {
    func NSThreadFun() {
        let thread = Thread {
            print("1")
        }
        thread.name = "Test NSThread"
        thread.start()
    }
}

extension iOSThread {
    func NSOperationFun() {
        let operation = BlockOperation.init {
            NSLog("%@", Thread.current)
        }
        operation.start()
    }
}


class data {
    var value: Int = 0
    var dataToEdit: Int {
        get {
            return value
        }
        set {
            let conditionLock = NSConditionLock()
            conditionLock.condition 
            conditionLock.lock(whenCondition: 2)
            
            
            let lock = NSLock()
            lock.lock()
            objc_sync_enter(self.value) // 同步时候
            value = newValue
            objc_sync_exit(self.value)
            lock.unlock()
        }
    }
}


