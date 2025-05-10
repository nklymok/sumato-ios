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
                if kanjiStats.dataFetched && kanjiStats.kanjiLeftToReview == 0 && kanjiStats.kanjiLeftToStudy == 0 {
                    GreatJobView()
                }
                HStack(spacing: 30) {
                    KanjiButton(
                        howManyLeft: kanjiStats.kanjiLeftToReview,
                        nextAvailableAt: kanjiStats.nextReviewAt,
                        iconText: "復習",
                        subIconText: "Review",
                        outerTextColor: .green,
                        innerTextColor: .black,
                        destination: "kanjiReview"
                    )
                    KanjiButton(
                        howManyLeft: kanjiStats.kanjiLeftToStudy,
                        nextAvailableAt: kanjiStats.nextStudyAt,
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
                appState.showPoints = true
                kanjiStats.fetchData(forUserId: appState.userId)
            }
            .padding()
            .navigationDestination(for: StudyKanjiNavigation.self) { selection in
                if (selection.viewName == "kanjiReview") {
                    KanjiPracticeView(isReview: true)
                        .navigationBarBackButtonHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                        .environmentObject(appState)
                } else if (selection.viewName == "kanjiLesson") {
                    KanjiLessonView()
                        .navigationBarBackButtonHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                } else if (selection.viewName == "kanjiFinish") {
                    KanjiFinishView(kanjis: selection.kanjis)
                        .navigationBarBackButtonHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                } else if (selection.viewName == "kanjiStudy") {
                    KanjiPracticeView(isReview: false)
                        .navigationBarBackButtonHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                        .environmentObject(appState)
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
    let nextAvailableAt: Date?
    let iconText: String
    let subIconText: String
    let outerTextColor: Color
    let innerTextColor: Color
    let destination: String
    @EnvironmentObject var appState: AppState
    
    private var countdownText: String {
        guard howManyLeft == 0, let next = nextAvailableAt else {
          return "\(howManyLeft) left"
        }
        let interval = next.timeIntervalSinceNow
        if interval <= 0 { return "\(howManyLeft) left" }

        let fmt = DateComponentsFormatter()
        fmt.allowedUnits = [.day, .hour, .minute]
        fmt.unitsStyle   = .short     // e.g. “1d 3h 15m”
        let s = fmt.string(from: interval) ?? "soon"
        return "next in \(s)"
      }
    
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
            Text(countdownText)
                    .foregroundColor(outerTextColor)
                    .fontWeight(.semibold)
                    .padding(.top, 15)
        }
    }
}

struct GreatJobView: View {
    var body: some View {
        VStack {
            Text("Great job! ✨")
                .fontWeight(.semibold)
                .font(.title)
            Text("Now come back tomorrow 💤")
                .fontWeight(.medium)
            Text("(Lessons are updated every 24h)")
                .font(.footnote)
                .padding(.top, 10)
                .padding(.bottom, 20)
                .fontWeight(.thin)
        }
    }
}
