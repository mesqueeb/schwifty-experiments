import SwiftUI

struct SPublicPortfolioCvEntry: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath
  let username: String?
  let entryId: UUID?

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(StackVC.self) private var stackVC

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
    CStack(scrollView: true, padding: .a) {
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
  let stackPathPerRootIndex: [StackPath] = [.weather, .portfolioFeed, .frameworks, .account]

  @State var stackVC = StackVC(initialRootIndex: 1, stackPathPerRootIndex)

  return SPublicPortfolioCvEntry(path: .publicPortfolioCvEntry("Michael", UUID()), username: "Michael", entryId: UUID())
    .environment(stackVC)
}
