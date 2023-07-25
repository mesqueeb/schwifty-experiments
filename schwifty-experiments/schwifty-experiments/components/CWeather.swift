import SwiftUI

struct CWeather: View {
  // ╔═══════╗
  // ║ Setup ║
  // ╚═══════╝
  @State private var isNight = false

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    ZStack {
      Bg(isNight: isNight).ignoresSafeArea()

      VStack {
        Text("Cupertino, CA")
          .font(.system(size: 32, weight: .medium))
          .foregroundColor(.white)
          .padding()
        VStack(spacing: 10) {
          HStack {
            Image(systemName: "cloud.sun.fill")
              .symbolRenderingMode(SymbolRenderingMode.multicolor)
              .resizable()
              .aspectRatio(contentMode: ContentMode.fit)
              .frame(width: 180, height: 180)
          }
          Text("22°").font(.system(size: 70, weight: .medium)).foregroundColor(.white)
        }.padding(.bottom, 40)
        HStack(spacing: 20) {
          WeatherDayTile(day: "Tue", weather: .cloudy, temperature: 20)
          WeatherDayTile(day: "Wed", weather: .rainy, temperature: 16)
          WeatherDayTile(day: "Thu", weather: .snowy, temperature: -3)
          WeatherDayTile(day: "Fri", weather: .sunny, temperature: 26)
          WeatherDayTile(day: "Sat", weather: .windy, temperature: 22)
        }
        Spacer()
        SchwiftyButton(action: { isNight.toggle() },
                       label: isNight ? "Set Day" : "Set Night",
                       kind: .onColor)
        Spacer()
      }
    }
  }
}

struct Bg: View {
  let isNight: Bool

  // ╔══════════╗
  // ║ Template ║
  // ╚══════════╝
  var body: some View {
    LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("blueLight")]), startPoint: .topLeading, endPoint: .bottomTrailing)
  }
}

#Preview {
  CWeather()
}
