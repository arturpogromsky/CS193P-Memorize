//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Артур Погромский on 06.11.2021.
//

import Foundation


class EmojiMemoryGame {
  static let emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚙", "🚝"]
  static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 6) { pairIndex in
      emojis[pairIndex]
    }
  }
  private(set) var model = createMemoryGame()
  var cards: Array<MemoryGame<String>.Card> {
    model.cards
  }
}
