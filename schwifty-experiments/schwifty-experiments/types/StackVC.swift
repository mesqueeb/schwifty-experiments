import SwiftUI

class StackVC: ObservableObject {
  @Published public var sidenavShown: NavigationSplitViewVisibility = .all
  @Published public var rootIndex: Int

  private var stackPathPerRootIndex: [StackPath]

  @Published public var stacks0: [StackPath] = []
  @Published public var stacks1: [StackPath] = []
  @Published public var stacks2: [StackPath] = []
  @Published public var stacks3: [StackPath] = []

  public var currentRootStack: StackPath {
    return stackPathPerRootIndex[rootIndex]
  }

  public var currentStacks: Binding<[StackPath]> {
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

  /// Only for non-compact. Up to 2 stacks are shown at the same time.
  public var openBookStacks: ArraySlice<StackPath> {
    let lastTwoStacks = currentStacks.wrappedValue.suffix(2)
    return lastTwoStacks.count < 2 ? [currentRootStack] + lastTwoStacks : lastTwoStacks
  }

  public func back() { currentStacks.wrappedValue.removeLast() }

  public func backToRoot() { currentStacks.wrappedValue.removeAll() }

  public func replace(path: StackPath) {
    currentStacks.wrappedValue.removeLast()
    currentStacks.wrappedValue.append(path)
  }

  public func pushTo(_ parent: StackPath, _ path: StackPath) {
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

  /// is "TOP level stack" no matter wether there are stacks open next to / on top of it
  public func isRootStack(_ path: StackPath) -> Bool {
    path == currentRootStack
  }

  /// is "LEFT side stack" when looking at an open book
  public func isLeadingStack(_ path: StackPath) -> Bool {
    path == openBookStacks.first && openBookStacks.count == 2
  }

  /// is "RIGHT side stack" when looking at an open book
  public func isTrailingStack(_ path: StackPath) -> Bool {
    path == openBookStacks.last && openBookStacks.count == 2
  }

  /// the current open stack: EITHER the trailing stack or the open root stack
  public func isCurrentStack(_ path: StackPath) -> Bool {
    isTrailingStack(path) || (openBookStacks.count == 1 && path == openBookStacks.first)
  }

  init(initialRootIndex: Int, _ stackPathPerRootIndex: [StackPath]) {
    self.rootIndex = initialRootIndex
    self.stackPathPerRootIndex = stackPathPerRootIndex
  }
}
