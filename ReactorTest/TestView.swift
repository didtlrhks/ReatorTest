//
//  TestView.swift
//  ReactorTest
//
//  Created by 양시관 on 7/19/24.
//
import SwiftUI


struct TestView: View {
    @State private var backgroundColor: Color = .blue
    @State private var firstTimer: Timer?
    @State private var secondTimer: Timer?
    @State private var timeElapsed: Double = 0
    @State private var isSecondTimerRunning: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    if isSecondTimerRunning {
                        secondTimer?.invalidate()
                        isSecondTimerRunning = false
                        saveRecord(time: timeElapsed)
                    }
                }
            
            VStack {
                Text("색이 변하면 화면을 터치하세요!")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                
                if timeElapsed > 0 {
                    Text("반응 시간: \(String(format: "%.5f", timeElapsed)) 초")
                        .font(.title)
                        .padding()
                    
                    Text("\(getReactionTimePercentile(reactionTime: timeElapsed))")
                        .font(.title2)
                        .padding()
                }
            }
        }
        .onAppear {
            resetTimers()
            startFirstTimer()
        }
        .onDisappear {
            resetTimers()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black) // 원하는 색상으로 변경
                        .font(.title2)
                }
            }
        }
    }
    
    func resetTimers() {
        firstTimer?.invalidate()
        secondTimer?.invalidate()
        isSecondTimerRunning = false
        timeElapsed = 0
    }
    
    func startFirstTimer() {
        let randomTimeInterval = Double.random(in: 1...5)
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
    
    func saveRecord(time: Double) {
        var records = UserDefaults.standard.array(forKey: "reactionTimes") as? [Double] ?? []
        records.append(time)
        UserDefaults.standard.set(records, forKey: "reactionTimes")
    }
    func getReactionTimePercentile(reactionTime: Double) -> String {
        switch reactionTime {
        case 0..<0.1:
            return "Top 1%"
        case 0.1..<0.15:
            return "Top 5%"
        case 0.15..<0.2:
            return "Top 10%"
        case 0.2..<0.25:
            return "Top 25%"
        case 0.25..<0.3:
            return "Top 50%"
        case 0.3..<0.35:
            return "Top (50-75%)"
        case 0.35..<0.4:
            return "Top (75-90%)"
        default:
            return "굉장히 느려요."
        }
    }
}
