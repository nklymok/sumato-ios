//
//  StudyKanjiView.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

struct StudyKanjiView: View {
    @ObservedObject var kanjiStats: StatsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("My Kanji")
                        .font(.system(size: 48))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                TotalLearnedStatsView(totalLearned: kanjiStats.kanjiLearned)
                Spacer()
                HStack(spacing: 30) {
                    KanjiButton(
                        howManyLeft: kanjiStats.kanjiLeftToReview,
                        iconText: "復習",
                        subIconText: "Review",
                        outerTextColor: .green,
                        innerTextColor: .black,
                        destination: KanjiReviewView()
                    )
                    KanjiButton(
                        howManyLeft: kanjiStats.kanjiLeftToStudy,
                        iconText: "学",
                        subIconText: "Study",
                        outerTextColor: .blue,
                        innerTextColor: .blue,
                        destination: KanjiLessonView()
                    )
                    
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    let mockStats = StatsViewModel()
    mockStats.kanjiLearned = 5
    mockStats.kanjiLeftToReview = 3
    mockStats.kanjiLeftToStudy = 2
    return StudyKanjiView(kanjiStats: mockStats)
}

struct KanjiButton<Destination>: View where Destination: View {
    let howManyLeft: Int
    let iconText: String
    let subIconText: String
    let outerTextColor: Color
    let innerTextColor: Color
    let destination: Destination
    
    var body: some View {
        let disabled = howManyLeft == 0
        VStack {
            NavigationLink(destination: destination
                .toolbar(.hidden, for: .tabBar)
                .navigationBarBackButtonHidden(true)) {
                    VStack {
                        Text(iconText)
                            .font(.system(size: 45))
                            .frame(width: 100, height: 85)
                        Text(subIconText)
                        
                    }.padding(15)
                        .fontWeight(.semibold)
                        .foregroundColor(innerTextColor)
                }
                .buttonStyle(.bordered)
                .disabled(disabled)
                .opacity(disabled ? 0.5 : 1.0)
            Text("\(howManyLeft) left")
                .foregroundColor(outerTextColor)
                .fontWeight(.semibold)
                .padding(.top, 15)
        }
    }
}
