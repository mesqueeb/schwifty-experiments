import SwiftUI

struct InterpolateEnum<T: RawRepresentable>: View where T.RawValue == String {
  let targetEnum: T

  var body: some View {
    Text(targetEnum.rawValue)
  }
}

struct InterpolateEnumArray<T: RawRepresentable>: View where T.RawValue == String {
  let targetEnumArray: [T]

  var body: some View {
    VStack {
      ForEach(targetEnumArray, id: \.self.rawValue) { targetEnum in
        InterpolateEnum(targetEnum: targetEnum)
      }
    }
  }
}

#Preview {
  let path = [StackPath.pageAccount, StackPath.pageWeather]
  return InterpolateEnumArray(targetEnumArray: path)
}
