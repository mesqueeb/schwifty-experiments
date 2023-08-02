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
        VStack(alignment: .leading, spacing: Space.xs) {
          Text(item.name).font(.headline)
          Text("$\(item.price, specifier: "%.2f")").font(.caption)
          Text(item.description).font(.caption).foregroundColor(.secondary)
        }
        Spacer()
      }
      .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
  }
}

// #Preview {
//  dbAppetizers.fetch()
//
//  return CAppetizerRow(item: dbAppetizers.values?.first)
// }
