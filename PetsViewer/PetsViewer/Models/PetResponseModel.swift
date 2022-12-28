//
//  PetResponseModel.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import Foundation

// MARK: - PetResponseModel
struct PetResponseModel: Codable {
  let title: String
  let link: String
  let description: String
  let modified: String
  let generator: String
  let items: [Item]
  
}

// MARK: - Item
struct Item: Codable, Identifiable, Hashable {    
  let title: String
  let link: String
  let media: Media
  let dateTaken: String
  let itemDescription: String
  let published: String
  let author: String
  let authorID: String
  let tags: String
  let id = UUID()
  
  enum CodingKeys: String, CodingKey {
    case title, link, media
    case dateTaken = "date_taken"
    case itemDescription = "description"
    case published, author
    case authorID = "author_id"
    case tags
  }
  
  // MARK: - readableDate
  var readableDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    let date = dateFormatter.date(from: dateTaken) ?? Date()

    dateFormatter.dateFormat = "MM/dd/yy, h:mm a"
    dateFormatter.timeZone = TimeZone.current
    return dateFormatter.string(from: date)
  }
  
  // MARK: - 4 hashTags for main screen
  var fourTags: String {
    var hashT = ""
    let list = tags.components(separatedBy: " ")
    for (i, t) in list.enumerated() {
      guard i < 4 else { continue }
      hashT += "#\(t) "
    }
    return hashT
  }
  
  // MARK: - All hashTags for detail screen
  var hashTags: String {
    var hashT = ""
    let list = tags.components(separatedBy: " ")
    for t in list {
      hashT += "#\(t) "
    }
    return hashT
  }
  
  // MARK: - mock item for previews
  static let mock = Item(
    title: "High Key 12-16-22 (week50-52)",
    link: "https://www.flickr.com/photos/melename/52568312008/",
    media: Media(m: "https://live.staticflickr.com/65535/52568312008_74ac5fb29d_m.jpg"), dateTaken: "2022-12-16T15:22:55-08:00", itemDescription: "High Key 12-16-22 (week50-52)",
    published: "2022-12-16T22:42:36Z",
    author: "nobody@flickr.com",
    authorID: "66322040@N03",
    tags: "highkey yorkie dog puppy"
  )
}

// MARK: - Media
struct Media: Codable, Hashable {
  let m: String
}

