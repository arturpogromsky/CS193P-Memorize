//
//  MemoryGame.swift
//  Memorize
//
//  Created by Артур Погромский on 06.11.2021.
//

import Foundation


struct MemoryGame<CardContent> {
  private(set) var cards: [Card]
  
  func choose(_ card: Card) {
    // TODO
  }
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = Array<Card>()
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = createCardContent(pairIndex)
      cards.append(Card(content: content))
      cards.append(Card(content: content))
    }
  }
  
  struct Card {
    var isFaceUp = false
    var isMatched = false
    let content: CardContent
  }
}
