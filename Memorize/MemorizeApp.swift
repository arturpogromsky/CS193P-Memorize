//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Артур Погромский on 04.10.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
  let game = EmojiMemoryGame()
  var body: some Scene {
    WindowGroup {
      EmojiMemoryGameView(game: game)
    }
  }
}
