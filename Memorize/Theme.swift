//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by Артур Погромский on 13.11.2021.
//

import Foundation

// Тема игры
struct Theme: Identifiable {
  
  static let themes = [
    Theme(name: "Orange vehicles", emojis: EmojiStore.vehicles, numberOfPairsOfCardsToShow: 9, color: .orange),
    Theme(name: "Purple vehicles", emojis: EmojiStore.vehicles, numberOfPairsOfCardsToShow: 24, color: .purple),
    Theme(name: "Orange fruits", emojis: EmojiStore.fruits, numberOfPairsOfCardsToShow: 18, color: .orange),
    Theme(name: "Purple fruits", emojis: EmojiStore.fruits, numberOfPairsOfCardsToShow: 10, color: .purple),
    Theme(name: "Orange flags", emojis: EmojiStore.flags, numberOfPairsOfCardsToShow: 10, color: .orange),
    Theme(name: "Purple flags", emojis: EmojiStore.flags, color: .purple)
  ]
  
  let name: String
  let emojis: [String]
  var numberOfPairsOfCardsToShow: Int 
  let color: Theme.Color
  let id = UUID()
  
  init() {
    self.init(name: "Random theme",
              emojis: EmojiStore.allEmojis.randomElement()!,
              numberOfPairsOfCardsToShow: Int.random(in: 4...20),
              color: Color.allCases.randomElement()!)
  }
  
  init(name: String, emojis: [String], numberOfPairsOfCardsToShow: Int = Int.max, color: Color) {
    self.name = name
    self.color = color
    let emojisToShow = Set(emojis)
    self.numberOfPairsOfCardsToShow = numberOfPairsOfCardsToShow > emojisToShow.count ? emojisToShow.count : numberOfPairsOfCardsToShow
    if self.numberOfPairsOfCardsToShow <= 0 {
      self.numberOfPairsOfCardsToShow = Int.random(in: 0...emojisToShow.count)
    }
    self.emojis = Array(emojisToShow.shuffled()[0..<self.numberOfPairsOfCardsToShow])
  }
  
  private struct EmojiStore {
    static let vehicles = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚙", "🚝"] // 24 emojis
    static let fruits = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍈", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥝"] // 17 emojis
    static let flags = ["🏳️‍⚧️", "🇺🇳", "🇦🇿", "🇧🇾", "🇧🇪", "🇧🇴", "🇧🇷", "🇬🇧", "🇨🇦", "🇺🇸", "🇺🇦", "🇨🇭", "🇰🇷", "🇷🇺", "🇸🇪", "🇨🇿", "🇯🇵"] // 17 emojis
    static var allEmojis: [[String]] {
      [vehicles, fruits, flags]
    }
  }

  enum Color: CaseIterable {
    case purple, orange, yellow, blue, gray, green, red
  }
}


