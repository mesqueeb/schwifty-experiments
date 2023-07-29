import SwiftUI

struct DbPublicPortfolioCvEntry: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath
  let username: String?
  let entryId: UUID?

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @EnvironmentObject var stackVC: StackVC

  var portfolio: Portfolio? {
    return dbPortfolios.doc(username)?.data
  }

  var entry: CvEntry? {
    return portfolio?.cv.first(where: { $0.id == entryId })
  }

  var title: String {
    return textIf(entry?.id) { "Entry: \($0)" }
  }

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    VStack {
      CNavigationHeader(path, title)

      VStack {
        Text(entry?.description ?? "")
        Text("\(entry?.year ?? 0)")
        Text("\(entry?.month ?? 0)")
      }
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.pageWeather, .portfolioFeed, .pageFrameworks, .pageAccount]

  @StateObject var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return DbPublicPortfolioCvEntry(path: .publicPortfolioCvEntry("Michael", UUID()), username: "Michael", entryId: UUID())
    .environmentObject(stackVC)
}