//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Артур Погромский on 04.10.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var game: EmojiMemoryGame
  var body: some View {
    VStack(alignment: .center) {
      HStack(alignment: .firstTextBaseline) {
        Text("Score: " + game.score)
        Spacer()
        Text(game.theme.name)
          .font(.title2)
          .fontWeight(.bold)
        Spacer()
        MenuView(viewModel: game)
      }
      .font(.headline)
      GeometryReader { _ in
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            ForEach(game.cards) { card in
              CardView(card: card)
                .onTapGesture { game.choose(card) }
                .aspectRatio(2/3, contentMode: .fill)
            }
          }
        .foregroundColor(game.theme.color)
      }
    }
    .font(.largeTitle)
    .padding(.horizontal)
  }
//
//  func calculateMinimumWidth(for sizeOfContainer: CGSize) -> CGFloat {
//    var minSizeOfCard: CGFloat = 0.0
//
//  }
}

struct CardView: View {
  let card: EmojiMemoryGame.Card
  var body: some View {
    ZStack {
      let cornerRadius: CGFloat = 15
      let roundedRectangle = RoundedRectangle(cornerRadius: cornerRadius)
      if card.isFaceUp {
        roundedRectangle
          .strokeBorder(lineWidth: 3)
          .background(Color.white)
          .cornerRadius(15)
        Text(card.content)
      } else if card.isMatched {
        roundedRectangle
          .opacity(0)
      } else {
        roundedRectangle
      }
    }
  }
}

struct MenuView: View {
  let viewModel: EmojiMemoryGame
  var body: some View {
    Menu("New game") {
      ForEach(Theme.themes) { theme in
        Button {
          viewModel.startNewGame(theme: theme)
        } label: {
          Text(theme.name)
        }
      }
      Divider()
      Button {
        viewModel.startNewGame()
      } label: {
        Text("Generate random theme")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      let game = EmojiMemoryGame()
      EmojiMemoryGameView(game: game)
    }
  }
}
