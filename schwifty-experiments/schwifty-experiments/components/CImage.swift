import SwiftUI

enum AspectRatio {
  case landscape
  case portraitVideo
  case portraitImage
  case square
  var size: CGSize {
    switch self {
    case .landscape: return CGSize(width: 16, height: 9)
    case .portraitVideo: return CGSize(width: 9, height: 16)
    case .portraitImage: return CGSize(width: 3, height: 4)
    case .square: return CGSize(width: 1, height: 1)
    }
  }
}

/// see https://alejandromp.com/blog/image-aspectratio-without-frames/#a-better-solution-with-frames
struct CImage: View {
  // ╔═══════╗
  // ║ Props ║
  // ╚═══════╝
  let url: String
  let contentMode: ContentMode
  let aspectRatio: AspectRatio

  init(url: String, contentMode: ContentMode = .fill, aspectRatio: AspectRatio = .square) {
    self.url = url
    self.contentMode = contentMode
    self.aspectRatio = aspectRatio
  }

  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    AsyncImage(url: URL(string: url)) { image in
      image
        .resizable()
        .aspectRatio(contentMode: contentMode) // this is the magic trick
        .frame(
          minWidth: 0,
          maxWidth: .infinity,
          minHeight: 0,
          maxHeight: .infinity
        )
        .aspectRatio(aspectRatio.size, contentMode: .fit)
        .clipped()
    } placeholder: {
      ProgressView()
    }
  }
}

#Preview {
  let url = "https://images.pexels.com/photos/17619209/pexels-photo-17619209/free-photo-of-light-road-traffic-vacation.jpeg?auto=compress&cs=tinysrgb&w=1200&lazy=load"

  return HStack {
    VStack {
      Text("Fill")
      Group {
        CImage(url: url, contentMode: .fill, aspectRatio: .landscape)
        CImage(url: url, contentMode: .fill, aspectRatio: .portraitImage)
        CImage(url: url, contentMode: .fill, aspectRatio: .portraitVideo)
        CImage(url: url, contentMode: .fill, aspectRatio: .square)
      }.border(Color.red)
    }
    VStack {
      Text("Fit")
      Group {
        CImage(url: url, contentMode: .fit, aspectRatio: .landscape)
        CImage(url: url, contentMode: .fit, aspectRatio: .portraitImage)
        CImage(url: url, contentMode: .fit, aspectRatio: .portraitVideo)
        CImage(url: url, contentMode: .fit, aspectRatio: .square)
      }.border(Color.red)
    }
  }
  .padding(16)
  .background(Color.black)
}
