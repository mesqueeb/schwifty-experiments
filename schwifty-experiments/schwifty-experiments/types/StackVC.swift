import SwiftUI

/// `RootVC` manages the currently active root view and a dictionary of `PathVC` instances for each root.
///
/// Example usage:
/// ```
/// let rootVC = RootVC(initialRoot: .rootWeather)
/// let pathVC = PathVC(initialStacks: [.portfolioFeed], rootVC: rootVC)
/// rootVC.registerPathVC(root: .rootWeather, pathVC: pathVC)
/// ```
@Observable class RootVC {
  /// The currently active root view.
  public var currentRoot: StackRoot

  /// Creates a new RootVC with the specified initial root view.
  init(initialRoot: StackRoot) {
    self.currentRoot = initialRoot
  }

  /// A dictionary mapping each root view to its corresponding PathVC instance.
  public var rootPathVCDic: [StackRoot: PathVC] = [:]

  /// Registers a PathVC instance for the specified root view.
  public func registerPathVC(root: StackRoot, pathVC: PathVC) {
    rootPathVCDic[root] = pathVC
  }
}

/// `PathVC` manages the navigation stack for a particular root view.
///
/// Example instantiation usage:
/// ```
/// let rootVC = RootVC(initialRoot: .rootWeather)
///
/// // Pass `rootVC` to any `PathVC` instance
/// let pathVC = PathVC(initialStacks: [], rootVC: rootVC)
///
/// // Register `pathVC` back to the `RootVC` instance
/// rootVC.registerPathVC(root: .rootWeather, pathVC: pathVC)
/// ```
/// Example usage:
/// ```
/// pathVC.pushAfter(parent: .portfolioFeed, path: .publicPortfolio)
/// ```
@Observable class PathVC {
  /// The navigation stack for this root view.
  public var stacks: [StackPath]
  /// The RootVC instance that manages this PathVC.
  private var rootVC: RootVC

  
}
