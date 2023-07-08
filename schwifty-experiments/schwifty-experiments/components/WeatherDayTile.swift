import SwiftUI

enum WeatherType: String {
  case sunny = "sun.max.fill"
  case cloudy = "cloud.fill"
  case rainy = "cloud.rain.fill"
  case snowy = "snowflake"
  case windy = "wind"
}

struct WeatherDayTile: View {
  let day: String
  let weather: WeatherType
  let temperature: Int

  var body: some View {
    VStack(spacing: 8) {
      Text(day).font(.system(size: 16, weight: .bold)).foregroundColor(.white)
      Image(systemName: weather.rawValue)
        .symbolRenderingMode(SymbolRenderingMode.multicolor)
        .resizable()
        .aspectRatio(contentMode: ContentMode.fit)
        .frame(width: 32, height: 32)
      Text("\(temperature)").font(.system(size: 22, weight: .medium)).foregroundColor(.white)
    }
  }
}

struct WeatherDayTilePreviews: PreviewProvider {
  static var previews: some View {
    WeatherDayTile(day: "Tue", weather: .cloudy, temperature: 20).background(.red)
  }
}
