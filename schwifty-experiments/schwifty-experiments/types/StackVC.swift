import SwiftUI

/// `StackVC` is a class that manages the navigation state of the application.
///
/// It provides functions and properties to navigate through different stacks of views,
/// and to query the current navigation state.
@Observable class StackVC {
  // ╔═══════╗
  // ║ State ║
  // ╚═══════╝
  public var sidenavShown: NavigationSplitViewVisibility = .all
  public var rootIndex: Int {
    didSet {
      Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
        self.restoreStacksIfNeeded()
      }
    }
  }

  /// Non-dynamic! (should only be ever set up on initialisation)
  public var stackPathPerRootIndex: [StackPath]

  public var stacks0: [StackPath] = []
  public var stacks1: [StackPath] = []
  public var stacks2: [StackPath] = []
  public var stacks3: [StackPath] = []

  init(initialRootIndex: Int, _ stackPathPerRootIndex: [StackPath]) {
    self.rootIndex = initialRootIndex
    self.stackPathPerRootIndex = stackPathPerRootIndex
  }

  // ╔══════════╗
  // ║ Computed ║
  // ╚══════════╝
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
  /// This computed property will include the currentRootStack if this is visible.
  public var openBookStacks: ArraySlice<StackPath> {
    let lastTwoStacks = currentStacks.wrappedValue.suffix(2)
    return lastTwoStacks.count < 2 ? [currentRootStack] + lastTwoStacks : lastTwoStacks
  }

  // ╔═════════╗
  // ║ Methods ║
  // ╚═════════╝
  /// Removes the last view from the current navigation stack.
  ///
  /// This function performs a backward navigation action, equivalent to pressing a back button.
  public func back() {
    withAnimation(.smooth(duration: 0.25)) { currentStacks.wrappedValue.removeLast() }
  }

  /// Removes all open stacks, goes back to the root
  public func backToRoot() {
    withAnimation(.smooth(duration: 0.25)) { currentStacks.wrappedValue.removeAll() }
  }

  /// Replaces the last view in the current navigation stack with a new one.
  public func replace(path: StackPath) {
    withAnimation(.smooth(duration: 0.25)) {
      currentStacks.wrappedValue.removeLast()
      currentStacks.wrappedValue.append(path)
    }
  }

  /// Navigates to a new view that will be shown directly after a given parent view.
  ///
  /// It will remove any other paths until it finds the target parent and put the new path on top.
  public func pushTo(_ parent: StackPath, _ path: StackPath) {
    withAnimation(.smooth(duration: 0.25)) {
      while currentStacks.wrappedValue.last != parent, !currentStacks.wrappedValue.isEmpty {
        currentStacks.wrappedValue.removeLast()
      }
      currentStacks.wrappedValue.append(path)
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

  /// the stack is currently visible: EITHER the current root path, the leading or trailing stack
  public func isVisibleStack(_ path: StackPath) -> Bool {
    openBookStacks.contains(path)
  }

  // ╔═════════════╗
  // ║ WORKAROUNDS ║
  // ╚═════════════╝
  /// See `backupAndResetStacks`
  private var stackBackupsPerIndex: [[StackPath]] = [[], [], [], []]
  /// See `backupAndResetStacks`
  private var stacksRestoredPerIndex: [Bool] = [true, true, true, true]
  /// See `backupAndResetStacks`
  private func restoreStacksIfNeeded() {
    if !stacksRestoredPerIndex[rootIndex] {
      switch rootIndex {
      case 0:
        stacks0 = stackBackupsPerIndex[0]
      case 1:
        stacks1 = stackBackupsPerIndex[1]
      case 2:
        stacks2 = stackBackupsPerIndex[2]
      case 3:
        stacks3 = stackBackupsPerIndex[3]
      default:
        fatalError("Invalid rootIndex")
      }
      stacksRestoredPerIndex[rootIndex] = true
    }
  }

  /// This fixes an issue when changing from WIDE to COMPACT view (on iPad) where the current stack should stay open but on compact only an empty navigation destination screen is shown
  public func backupAndResetStacks() {
    stackBackupsPerIndex = [stacks0, stacks1, stacks2, stacks3]
    stacksRestoredPerIndex = [false, false, false, false]
    stacks0 = []
    stacks1 = []
    stacks2 = []
    stacks3 = []
    Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
      self.restoreStacksIfNeeded()
    }
  }

  // ╔═══════════════╗
  // ║ Private stuff ║
  // ╚═══════════════╝
}
