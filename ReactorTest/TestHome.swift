//
//  TestHome.swift
//  ReactorTest
//
//  Created by 양시관 on 7/19/24.
//
import SwiftUI

struct TestHome: View {
    @State private var isRed = true
    @State private var showTestView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.red
                VStack{
                    Spacer()
                    
                    // 제목 텍스트
                    Text("반응속도 테스트")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer().frame(height: 40)
                    Text("당신의 반응속도를 테스트해보세요!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                    
                    // NavigationLink를 사용하여 새로운 뷰로 이동
                    NavigationLink(destination: TestView()) {
                        Text("테스트하러가기")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    // 설정으로 가기 버튼
                    NavigationLink(destination: SettingsView()) {
                        Text("기록보러 가기")
                            .font(.title2)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    
                    Spacer()
                }
                
            }
            .edgesIgnoringSafeArea(.horizontal)
            .background(isRed ? Color.red : Color.green)
        }
    }
}

struct SettingsView: View {
    @State private var records: [Double] = []
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                if records.isEmpty {
                    Text("기록이 없습니다!")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(records, id: \.self) { record in
                            Text("반응 시간: \(String(format: "%.5f", record)) 초")
                        }
                    }
                    .navigationTitle("기록")
                    .navigationBarHidden(true)
                }
                
                VStack {
                    Spacer()
                    Button(action: {
                        clearRecords()
                    }) {
                        Image(systemName: "trash")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding(.bottom, 20)
                }
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
            .onAppear {
                loadRecords()
            }
        }
    }
    
    func loadRecords() {
        records = UserDefaults.standard.array(forKey: "reactionTimes") as? [Double] ?? []
    }
    
    func clearRecords() {
        UserDefaults.standard.removeObject(forKey: "reactionTimes")
        records = []
    }
}
