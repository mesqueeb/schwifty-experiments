
import Foundation

struct Appetizer: Decodable, Identifiable, DocProtocol {
  let id: String
  let name: String
  let description: String
  let price: Double
  let imageURL: String
  let calories: Int
  let protein: Int
  let carbs: Int

  // Define the coding keys corresponding to the JSON keys
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case price
    case imageURL
    case calories
    case protein
    case carbs
  }

  // Custom initializer to handle the decoding
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    // Decode the id as an integer, then convert it to a string
    let idInt = try container.decode(Int.self, forKey: .id)
    id = String(idInt) // Convert the integer id to a string

    // Decode the other properties normally
    name = try container.decode(String.self, forKey: .name)
    description = try container.decode(String.self, forKey: .description)
    price = try container.decode(Double.self, forKey: .price)
    imageURL = try container.decode(String.self, forKey: .imageURL)
    calories = try container.decode(Int.self, forKey: .calories)
    protein = try container.decode(Int.self, forKey: .protein)
    carbs = try container.decode(Int.self, forKey: .carbs)
  }
}
