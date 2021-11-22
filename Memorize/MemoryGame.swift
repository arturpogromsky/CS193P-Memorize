//
//  MemoryGame.swift
//  Memorize
//
//  Created by Артур Погромский on 06.11.2021.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
  
  private(set) var cards: [Card]
  
  //Индекс первой выбранной карты
  private var indexOfFirstSelectedCard: Int? {
    get {
      let faceUpCardsIndices = cards.indices.filter { cards[$0].isFaceUp }
      return faceUpCardsIndices.count == 1 ? faceUpCardsIndices.first! : nil
    }
    set {
      for cardIndex in cards.indices {
        if cards[cardIndex].isFaceUp {
          cards[cardIndex].wasSeen = true
        }
        cards[cardIndex].isFaceUp = false
      }
    }
  }
  
  var score = 0
  

  
  ///Функция, которая вызывается при нажатии на карту. Реализует игровую логику
  mutating func choose(_ card: Card) {
    guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
       cards[chosenIndex].isFaceUp == false,
       cards[chosenIndex].isMatched == false
    else { return }
    cards[chosenIndex].timeOfLastSelection = Date()
    if let selectedCard = indexOfFirstSelectedCard { // Одна карта уже выбрана, выбрать вторую и сравнить с первой
      if cards[selectedCard].content == cards[chosenIndex].content {
        cards[selectedCard].isMatched = true
        cards[chosenIndex].isMatched = true
        calculateScoreForCardIndices(selectedCard, chosenIndex, matched: true)
      } else {
        calculateScoreForCardIndices(selectedCard, chosenIndex, matched: false)
      }
    } else {
      // Карта либо еще не выбрана, либо выбраны уже 2 карты.
      self.indexOfFirstSelectedCard = chosenIndex
    }
    cards[chosenIndex].isFaceUp.toggle()
  }
  
  mutating func calculateScoreForCardIndices(_ firstCardIndex: Int, _ secondCardIndex: Int, matched: Bool) {
    if matched {
      let timeDistance = Int(cards[firstCardIndex]
                              .timeOfLastSelection.distance(to: cards[secondCardIndex].timeOfLastSelection))
      score += 2 * max(1, 10 - timeDistance)
      print("Added \(max(1, 10 - timeDistance)) to score")
    } else {
      if cards[firstCardIndex].wasSeen {
        score -= 1
      }
      if cards[secondCardIndex].wasSeen {
        score -= 1
      }
    }
  }
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    cards = []
    // Добавить numberOfPairsOfCards x 2 в массив карт
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
    let content: CardContent
    let id: Int
    var wasSeen = false
    var timeOfLastSelection: Date!
  }
}
