//
//  TimerViewModel.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2022/12/17.
//

import SwiftUI

class TimerViewModel: ObservableObject {
    
    @Published var counter: Int = 0
    @Published var isTimerRunning: Bool = false
    
    var totalSecondTime: Int = 3600 // 10초
    
    var timer = Timer()
    
    func start() {
        self.isTimerRunning.toggle()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                          repeats: true) { _ in
            self.counter += 1
            
            if self.counter == self.totalSecondTime {
                self.stop()
            }
            print("counter : \(self.counter)")
            print("totalSecondTime : \(self.totalSecondTime)")
        }
    }
    func stop() {
        self.isTimerRunning.toggle()
        self.timer.invalidate()
    }
    
    func reset() {
        self.counter = 0
        self.timer.invalidate()
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return 1 - (CGFloat(counter) / CGFloat(totalSecondTime))
    }
}

