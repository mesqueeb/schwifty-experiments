import SwiftUI

struct CNavigationRow: Identifiable, Hashable {
  let title: String
  let stacks: [StackPath]
  var id: String { title }
}

struct CNavigationList: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let rows: [CNavigationRow]

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @Environment(StackVC.self) private var stackVC

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    ForEach(rows, id: \.self) { row in
      Button(action: {
        stackVC.setStacks(row.stacks)
      }) {
        VStack {
          HStack {
            Text(row.title).font(.body)
            Spacer()
            Image(systemName: "chevron.right").font(.body)
          }
          .padding(Space.xs)
          Divider()
        }
        .contentShape(Rectangle())
      }
      .buttonStyle(.plain)
    }
  }
}

#Preview {
  let rows: [CNavigationRow] = [
    CNavigationRow(title: "Test", stacks: [._404]),
    CNavigationRow(title: "Test2", stacks: [._404])
  ]

  return CNavigationList(rows: rows)
}
