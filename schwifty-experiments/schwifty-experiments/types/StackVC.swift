import SwiftUI

struct StackCache {
  let stacks: [StackPath]
}

class StackVC: ObservableObject {
  @Published public var currentRoot: StackRoot? {
    didSet {
      print("currentRoot:", currentRoot ?? "nil")
      if let currentRoot, currentRoot != oldValue {
        if let oldValue {
          rootCacheDic[oldValue] = StackCache(stacks: stacks)
        }
        stacks = rootCacheDic[currentRoot]?.stacks ?? []
      }
    }
  }

  @Published public var stacks: [StackPath] = [] {
    didSet {
      print("stacks:", stacks)
    }
  }

//  public var currentPath: StackPath { stacks.last ?? StackPath._404 }

  /// cache per root
  private var rootCacheDic: [StackRoot: StackCache]

  public func back() { stacks.removeLast() }

  public func backToRoot() { stacks.removeAll() }

  public func replace(path: StackPath) {
    stacks.removeLast()
    stacks.append(path)
  }

  public func pushTo(parent: StackPath, path: StackPath) {
    while stacks.last != parent, !stacks.isEmpty {
      stacks.removeLast()
    }
    stacks.append(path)
  }

  init(initialRoot: StackRoot, initialRootCacheDic: [StackRoot: StackCache]) {
    print("initialRoot:", initialRoot)
    self.currentRoot = initialRoot
    self.rootCacheDic = initialRootCacheDic
    let stackCache = initialRootCacheDic[initialRoot]
    self.stacks = stackCache?.stacks ?? []
  }
}
