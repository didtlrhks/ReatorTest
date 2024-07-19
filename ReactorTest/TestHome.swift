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
                    
                    Spacer()
                }
                
            }
            .edgesIgnoringSafeArea(.horizontal)
            .background(isRed ? Color.red : Color.green)
                
        }
    }
}


