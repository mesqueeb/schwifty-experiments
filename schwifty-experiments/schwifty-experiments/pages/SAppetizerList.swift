import SwiftUI

struct SAppetizerList: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let path: StackPath

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(Collection<Appetizer>.self) private var dbAppetizers

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    CStack(scrollView: true, padding: .a, alignment: .leading) {
      CNavigationHeader(self.path, "Appetizers")

      LazyVStack {
        ForEach(dbAppetizers.values) { item in
          CAppetizerRow(item: item)
        }
      }
    }
    .task {
      await dbAppetizers.fetch()
    }
  }
}

#Preview {
  let stackPathPerRootIndex: [StackPath] = [.weather, .portfolioFeed, .frameworks, .account]

  @State var stackVC = StackVC(initialRootIndex: 0, stackPathPerRootIndex)

  return SAppetizerList(path: ._404)
    .environment(stackVC)
}
