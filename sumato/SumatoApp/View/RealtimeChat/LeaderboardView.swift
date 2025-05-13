import SwiftUI
import Foundation

struct GlobalStat: Identifiable, Codable {
    let userId: String
    let username: String
    let weeklyKanjis: Int

    var id: String { userId }
}

struct LeaderboardView: View {
    @State private var stats: [GlobalStat] = []
    @State private var isLoading = false
    @State private var errorMessage: String? = nil

    private var fromDate: Date {
        let calendar = Calendar.current
        let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        return calendar.startOfDay(for: oneWeekAgo)
    }

    private var toDate: Date {
        Date()
    }

    private var dateRangeText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return "\(formatter.string(from: fromDate)) - \(formatter.string(from: toDate))"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Leaderboard")
                .font(.title)
            Text("Stats for \(dateRangeText)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                List(stats) { stat in
                    HStack {
                        Text(stat.username)
                        Spacer()
                        Text("\(stat.weeklyKanjis)")
                            .bold()
                    }
                    .listRowBackground(
                        stat.userId == AppState.userId ? Color.accentColor.opacity(0.2) : Color.clear
                    )
                }
                .listStyle(PlainListStyle())
            }
        }
        .padding()
        .onAppear(perform: fetchStats)
    }

    private func fetchStats() {
        isLoading = true
        errorMessage = nil
        APIClient.shared.fetchGlobalStats(from: fromDate, to: toDate) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetched):
                    stats = fetched
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
                isLoading = false
            }
        }
    }
}

#if DEBUG
struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
#endif