import SwiftUI

struct CAppetizerRow: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let item: Appetizer
  let action: (() -> Void)? = nil

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    Button(action: action ?? {}) {
      HStack(spacing: Space.md) {
        CImage(url: item.imageURL, contentMode: .fill, aspectRatio: .square)
          .frame(width: 100)
          .clipShape(RoundedRectangle(cornerRadius: Space.sm))
        VStack(alignment: .leading, spacing: Space.sm) {
          Text(item.name).font(.headline)
          Text(item.description).font(.caption).foregroundColor(.secondary)
        }
      }
      .padding(Space.xs)
      .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  CAppetizerRow(item: AppetizerMockData.orderItemOne)
}
