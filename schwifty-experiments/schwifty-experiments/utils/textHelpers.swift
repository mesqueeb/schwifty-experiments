func textIf<T>(_ optionalValue: T?, transform: (T) -> String) -> String {
  if let value = optionalValue {
    return transform(value)
  } else {
    return ""
  }
}
