//
//  TimerView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2022/12/16.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject var timerViewModel = TimerViewModel()
       
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.clear)
                    .frame(width: 250, height: 250)
                    .overlay {
                        Circle().stroke(Color.green, lineWidth: 25)
                    }
                
                Circle()
                    .fill(Color.clear)
                    .frame(width: 250, height: 250)
                    .overlay {
                        Circle().trim(from:0, to: timerViewModel.progress())
                            .stroke(style: StrokeStyle(lineWidth: 25, lineCap: .butt, lineJoin: .round))
                            .foregroundColor(
                                (timerViewModel.completed() ? Color.orange : Color.red)
                            ).animation(
                                .easeInOut(duration: 0.2), value: UUID()
                            )
                            .rotationEffect(Angle(degrees: 270.0))
                        Clock(counter: timerViewModel.counter, countTo: timerViewModel.totalSecondTime)
                    }
                 
                Image(systemName: timerViewModel.isTimerRunning ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(y: 250)
                    .onTapGesture {
                        if timerViewModel.isTimerRunning {
                            timerViewModel.stop()
                        } else {
                            timerViewModel.start()
                        }
                    }
            }
        }
    }
}


struct Clock: View {
    var counter: Int
    var countTo: Int
    
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.system(size: 60))
                .fontWeight(.black)
        }
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
