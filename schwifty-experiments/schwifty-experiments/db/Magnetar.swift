import Foundation
import SwiftUI

protocol DocProtocol {
  var id: String { get }
}

@Observable final class Doc<T> {
  private(set) var data: T
  private let onUpdate: (T) -> Void

  init(data: T, onUpdate: @escaping (T) -> Void) {
    self.data = data
    self.onUpdate = onUpdate
  }

  public func replace(_ doc: T) {
    data = doc
    onUpdate(doc)
  }
}

/// # Example usage
/// ```swift
/// struct MyDocument: DocProtocol {
///   let id: String
///   let name: String
/// }
///
/// let doc1 = MyDocument(id: "1", name: "Document 1")
/// let doc2 = MyDocument(id: "2", name: "Document 2")
///
/// // Create a collection with initial data
/// let collection = Collection(initialData: [doc1, doc2])
///
/// // Retrieve a document by its id
/// if let document = collection.doc("1") {
///   // Manipulate the document as needed
///   print(document.data.name) // Output: Document 1
///
///   // Replace the doc data
///   let newData = MyDocument(id: "2", name: "Doc2!!!!")
///   document.replace(newData)
///
///   if let updatedDoc = collection.doc("1") {
///     print(updatedDoc.data.name) // Output: Doc2!!!!
///   }
/// }
///
/// // Access all values in the collection
/// let allDocs = collection.values
/// ```
@Observable final class Collection<T: DocProtocol> {
  private let fetchFn: () async throws -> [T]

  init(fetchFn: @escaping () async throws -> [T]) {
    self.fetchFn = fetchFn
  }

  private var docMap: [String: T] = [:]

  public var data: [String: T] {
    docMap
  }

  public var values: [T] {
    Array(docMap.values)
  }

  public func doc(_ id: String?) -> Doc<T>? {
    guard let id = id else { return nil }
    guard let docData = docMap[id] else { return nil }
    return Doc<T>(data: docData) { self.docMap[id] = $0 }
  }

  public func fetch() async {
    do {
      let results = try await fetchFn()
      docMap = results.reduce(into: [String: T]()) { $0[$1.id] = $1 }
    } catch {
      toasts.show(error.localizedDescription)
    }
  }
}
