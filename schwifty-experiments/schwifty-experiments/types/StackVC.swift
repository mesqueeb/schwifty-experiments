import SwiftUI

struct StackCache {
  let fullPath: [StackPath]
}

class StackVC: ObservableObject {
  @Published public var currentRoot: StackRoot? {
    didSet {
      print("currentRoot:", currentRoot ?? "nil")
      if let currentRoot, currentRoot != oldValue {
        if let oldValue {
          rootCacheDic[oldValue] = StackCache(fullPath: fullPath)
        }
        fullPath = rootCacheDic[currentRoot]?.fullPath ?? []
      }
    }
  }

  @Published public var fullPath: [StackPath] = [] {
    didSet {
      print("fullPath:", fullPath)
    }
  }

  public var currentPath: StackPath? { fullPath.last }

  /// cache per root
  private var rootCacheDic: [StackRoot: StackCache]

  public func back() {
    fullPath.removeLast()
  }

  public func replace(path: StackPath) {
    fullPath.removeLast()
    fullPath.append(path)
  }

  public func pushTo(parent: StackPath, path: StackPath) {
    while fullPath.last != parent, !fullPath.isEmpty {
      fullPath.removeLast()
    }
    fullPath.append(path)
  }

  init(initialRoot: StackRoot, initialRootCacheDic: [StackRoot: StackCache]) {
    self.currentRoot = initialRoot
    self.rootCacheDic = initialRootCacheDic
    let stackCache = initialRootCacheDic[initialRoot]
    self.fullPath = stackCache?.fullPath ?? []
  }
}
