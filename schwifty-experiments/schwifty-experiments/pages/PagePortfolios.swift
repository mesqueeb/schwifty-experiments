import SwiftUI

struct PagePortfolios: View {
  @EnvironmentObject var stackVC: StackVC
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    if horizontalSizeClass == .compact {
      NavigationStack(path: $stackVC.stacks1) {
        DbPortfolioFeed()
          .navigationDestination(for: StackPath.self) { path in
            pathToView(path)
          }
      }
    }
    else {
      GeometryReader { geometry in
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            DbPortfolioFeed()
            ForEach(stackVC.stacks1, id: \.self) { path in
              NavigationStack {
                ScrollView {
                  VStack {
//                    Text(title)
//                       .font(.largeTitle)
//                       .fontWeight(.semibold)
                    pathToView(path)
                  }
                }
              }
              .frame(width: geometry.size.width * 0.5)
              .background(Color.red)
            }
          }
        }
      }
    }
  }
}

#Preview {
  @ViewBuilder
  func pathToView(_ path: StackPath) -> some View {
    Text("404")
  }

  return PagePortfolios()
}
