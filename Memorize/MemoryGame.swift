//
//  MemoryGame.swift
//  Memorize
//
//  Created by Артур Погромский on 06.11.2021.
//

import Foundation


struct MemoryGame<CardContent: Equatable> {
  
  private(set) var cards: [Card]
  
  private var indexOfFirstSelectedCard: Int? //Индекс первой выбранной карты
  
  var score = 0
  
  var timeOfLastSelection: Date? //Время с последнего касания
  
  ///Функция, которая вызывается при нажатии на карту. Реализует игровую логику
  mutating func choose(_ card: Card) {
    if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
       cards[chosenIndex].isFaceUp == false,
       cards[chosenIndex].isMatched == false
    {
      if let selectedCard = indexOfFirstSelectedCard { // Одна карта уже выбрана, выбрать вторую и сравнить с первой
        if cards[selectedCard].content == cards[chosenIndex].content {
          cards[selectedCard].isMatched = true
          cards[chosenIndex].isMatched = true
          // score += 2
          if let timeOfLastSelection = timeOfLastSelection {
            let currentTime = Date()
            let timeDistance = Int(timeOfLastSelection.distance(to: currentTime))
            score += 2 * max(1, 10 - timeDistance)
            print("Added \(max(1, 10 - timeDistance)) to score")
          } else {
            score += 2
          }
        } else {
          if cards[selectedCard].wasSeen {
            score -= 1
          }
          if cards[chosenIndex].wasSeen {
            score -= 1
          }
        }
        self.indexOfFirstSelectedCard = nil
      } else { // Карта либо еще не выбрана, либо выбраны уже 2 карты.
        for cardIndex in cards.indices {
          if cards[cardIndex].isFaceUp {
            cards[cardIndex].wasSeen = true
          }
          cards[cardIndex].isFaceUp = false
        }
        self.indexOfFirstSelectedCard = chosenIndex
      }
      cards[chosenIndex].isFaceUp.toggle()
      timeOfLastSelection = Date()
    }
  }
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = Array<Card>()
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = createCardContent(pairIndex)
      cards.append(Card(content: content, id: pairIndex * 2))
      cards.append(Card(content: content, id: pairIndex * 2 + 1))
    }
    cards.shuffle()
  }
  
  struct Card: Identifiable {
    var isFaceUp = false
    var isMatched = false
    var wasSeen = false
    let content: CardContent
    let id: Int
  }
}


