//
//  StudyKanjiView.swift
//  sumato
//
//  Created by Nazarii Klymok on 21.04.2024.
//

import SwiftUI

struct StudyKanjiView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var kanjiStats = StatsViewModel()
    
    var body: some View {
        NavigationStack(path: $appState.path) {
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
                        destination: "kanjiReview"
                    )
                    KanjiButton(
                        howManyLeft: kanjiStats.kanjiLeftToStudy,
                        iconText: "学",
                        subIconText: "Study",
                        outerTextColor: .blue,
                        innerTextColor: .blue,
                        destination: "kanjiLesson"
                    )
                    
                }
                Spacer()
            }
            .onAppear {
                kanjiStats.fetchData(forUserId: appState.userId)
            }
            .padding()
            .navigationDestination(for: StudyKanjiNavigation.self) { selection in
                if (selection.viewName == "kanjiReview") {
                    KanjiReviewView()
                        .navigationBarBackButtonHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                } else if (selection.viewName == "kanjiLesson") {
                    KanjiLessonView()
                        .navigationBarBackButtonHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                } else if (selection.viewName == "kanjiFinish") {
                    KanjiFinishView(kanjis: selection.kanjis)
                        .navigationBarBackButtonHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                } else if (selection.viewName == "kanjiPractice") {
                    KanjiPracticeView()
                        .navigationBarBackButtonHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                }
            }
        }
    }
}

#Preview {
    let mockStats = StatsViewModel()
    mockStats.kanjiLearned = 5
    mockStats.kanjiLeftToReview = 3
    mockStats.kanjiLeftToStudy = 2
    let appState = AppState()
    appState.path = NavigationPath()
    appState.showPoints = true
    appState.userId = 1
    return StudyKanjiView()
        .environmentObject(appState)
}

struct KanjiButton: View {
    let howManyLeft: Int
    let iconText: String
    let subIconText: String
    let outerTextColor: Color
    let innerTextColor: Color
    let destination: String
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        let disabled = howManyLeft == 0
        VStack {
            NavigationLink(value: StudyKanjiNavigation(viewName: destination, kanjis: []))
            {
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
