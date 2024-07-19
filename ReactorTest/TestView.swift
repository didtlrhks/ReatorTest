//
//  TestView.swift
//  ReactorTest
//
//  Created by 양시관 on 7/19/24.
//

import Foundation
import SwiftUI

import SwiftUI

struct TestView: View {
    @State private var backgroundColor: Color = .blue
    @State private var firstTimer: Timer?
    @State private var secondTimer: Timer?
    @State private var timeElapsed: Double = 0
    @State private var isSecondTimerRunning: Bool = false

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    if isSecondTimerRunning {
                        secondTimer?.invalidate()
                        isSecondTimerRunning = false
                    }
                }
            
            VStack {
                Text("테스트 화면")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                
                if timeElapsed > 0 {
                    Text("반응 시간: \(String(format: "%.2f", timeElapsed)) 초")
                        .font(.title)
                        .padding()
                }
            }
        }
        .onAppear {
            startFirstTimer()
        }
        .onDisappear {
            firstTimer?.invalidate()
            secondTimer?.invalidate()
        }
    }
    
    func startFirstTimer() {
        let randomTimeInterval = Double.random(in: 1...2)
        firstTimer = Timer.scheduledTimer(withTimeInterval: randomTimeInterval, repeats: false) { _ in
            backgroundColor = getRandomColor()
            startSecondTimer()
        }
    }
    
    func startSecondTimer() {
        let startTime = Date()
        isSecondTimerRunning = true
        secondTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            timeElapsed = Date().timeIntervalSince(startTime)
        }
    }
    
    func getRandomColor() -> Color {
        let colors: [Color] = [.green, .blue, .yellow, .orange, .purple, .pink]
        return colors.randomElement() ?? .blue
    }
}
