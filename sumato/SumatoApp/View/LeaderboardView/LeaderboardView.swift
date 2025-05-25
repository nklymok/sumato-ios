import SwiftUI
import Foundation

struct GlobalStat: Identifiable, Codable {
    let id: Int
    let name: String
    let picture: String?
    let kanjisStudied: Int
}

struct LeaderboardView: View {
    @EnvironmentObject var state: AppState
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
            HStack {
                Text("Leaderboard")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: fetchStats) {
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.large)
                }
            }
            Text("Stats for \(dateRangeText): how many kanjis everyone studied in the last week")
                .font(.subheadline)
                .foregroundColor(.secondary)

            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(Array(stats.enumerated()), id: \.element.id) { index, stat in
                            HStack(spacing: 12) {
                                Group {
                                    if index == 0 {
                                        Image(systemName: "crown.fill")
                                            .foregroundColor(.yellow)
                                    } else {
                                        Text("\(index + 1)")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .frame(width: 30)

                                if let urlString = stat.picture,
                                   let url = URL(string: urlString) {
                                    AsyncImage(url: url) { phase in
                                        if let image = phase.image {
                                            image.resizable()
                                                 .scaledToFill()
                                        } else {
                                            Circle().fill(Color.gray.opacity(0.3))
                                        }
                                    }
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                } else {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 40, height: 40)
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(stat.name.components(separatedBy: "@").first ?? stat.name)
                                        .font(.headline)
                                        .lineLimit(1)
                                    Text("\(stat.kanjisStudied) kanji")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(
                                (index == 0 ? Color.yellow.opacity(0.3) :
                                 index == 1 ? Color.gray.opacity(0.2) :
                                 index == 2 ? Color.orange.opacity(0.2) :
                                 (stat.id == state.userId ? Color.accentColor.opacity(0.2) : Color.clear))
                            )
                            .cornerRadius(8)
                        }
                    }
                }
                .refreshable {
                    fetchStats()
                }
            }
        }
        .padding()
        .onAppear(perform: fetchStats)
    }

    private func fetchStats() {
        isLoading = true
        errorMessage = nil
        APIClient.shared.fetchGlobalStats(from: fromDate,
                                          to: toDate) {
            result in
               DispatchQueue.main.async {
                 switch result {
                 case .success(let fetched):
                   stats = fetched.sorted { $0.kanjisStudied > $1.kanjisStudied }
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
