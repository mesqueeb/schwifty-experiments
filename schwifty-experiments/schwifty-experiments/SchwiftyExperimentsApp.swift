//
//  schwifty_experimentsApp.swift
//  schwifty-experiments
//
//  Created by Luca Ban on 2023/07/08.
//

import SwiftUI

@main
struct SchwiftyExperimentsApp: App {
//  @StateObject private var safariVM = SafariVM()

  var body: some Scene {
    WindowGroup {
      AppLayout()
//        .environmentObject(safariVM)
      // #if os(macOS)
      //   .frame(minWidth: 600, minHeight: 450)
      // #endif
    }
  }
}
