//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Артур Погромский on 06.11.2021.
//

import Foundation
import SwiftUI


class EmojiMemoryGame: ObservableObject {
  static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCardsToShow) { pairIndex in
      theme.emojis[pairIndex]
    }
  }
  
  @Published private var model: MemoryGame<String>
  
  var cards: Array<MemoryGame<String>.Card> {
    model.cards
  }
  
  private(set) var theme: Theme
  
  var score: String {
    String(model.score)
  }
  
  init() {
    theme = Theme.themes.randomElement() ?? Theme()
    model = EmojiMemoryGame.createMemoryGame(with: theme)
  }
  
  //MARK: - Intent(s)
  func choose(_ card: MemoryGame<String>.Card) {
    model.choose(card)
  }
  
  func startNewGame(theme: Theme? = nil) {
    let theme = theme ?? Theme()
    self.theme = theme
    model = EmojiMemoryGame.createMemoryGame(with: self.theme)
  }
}
