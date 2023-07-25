import SwiftUI

class StackVC: ObservableObject {
  @Published public var rootIndex: Int {
    willSet {
      print("willSet rootIndex:", rootIndex)
    }
    didSet {
      print("didSet rootIndex:", rootIndex)
    }
  }

  @Published public var stacks0: [StackPath] = []
  @Published public var stacks1: [StackPath] = []
  @Published public var stacks2: [StackPath] = []
  @Published public var stacks3: [StackPath] = []

  var currentStacks: Binding<[StackPath]> {
    switch rootIndex {
    case 0:
      return Binding<[StackPath]>(
        get: { self.stacks0 },
        set: { self.stacks0 = $0 }
      )
    case 1:
      return Binding<[StackPath]>(
        get: { self.stacks1 },
        set: { self.stacks1 = $0 }
      )
    case 2:
      return Binding<[StackPath]>(
        get: { self.stacks2 },
        set: { self.stacks2 = $0 }
      )
    case 3:
      return Binding<[StackPath]>(
        get: { self.stacks3 },
        set: { self.stacks3 = $0 }
      )
    default:
      fatalError("Invalid root index")
    }
  }

  public func back() { currentStacks.wrappedValue.removeLast() }

  public func backToRoot() { currentStacks.wrappedValue.removeAll() }

  public func replace(path: StackPath) {
    currentStacks.wrappedValue.removeLast()
    currentStacks.wrappedValue.append(path)
  }

  public func pushTo(parent: StackPath, path: StackPath) {
    while currentStacks.wrappedValue.last != parent, !currentStacks.wrappedValue.isEmpty {
      currentStacks.wrappedValue.removeLast()
    }
    currentStacks.wrappedValue.append(path)
  }

  /// This fixes an issue when changing from WIDE to COMPACT view where the current stack stayed but the screen becomes blank
  public func backupAndResetStacks() {
    let stacksBackup = currentStacks.wrappedValue
    currentStacks.wrappedValue = []
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
      self.currentStacks.wrappedValue = stacksBackup
    }
  }

  init(initialRootIndex: Int) {
    self.rootIndex = initialRootIndex
  }
}
