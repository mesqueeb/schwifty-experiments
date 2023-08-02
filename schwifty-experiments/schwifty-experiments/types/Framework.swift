
struct Framework: Identifiable, DocProtocol {
  let id: String
  let name: String
  let imageName: String
  let url: String
  let description: String
  init(name: String, imageName: String, url: String, description: String) {
    self.id = name
    self.name = name
    self.imageName = imageName
    self.url = url
    self.description = description
  }
}
