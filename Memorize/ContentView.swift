//
//  ContentView.swift
//  Memorize
//
//  Created by Артур Погромский on 04.10.2021.
//

import SwiftUI

struct ContentView: View {
  @State var emojis = EmojiStore.vehicles
  @State var emojiCount = 16
  var body: some View {
    VStack(alignment: .center) {
      Text("Memorize!")
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
          ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
            CardView(content: emoji)
          }
        }
      }
      .foregroundColor(.orange)
      Spacer()
      ThemeChoser(emojiCount: $emojiCount, emojis: $emojis)
    }
    .font(.largeTitle)
    .padding(.horizontal)
  }
  
  var plusButton: some View {
    Button {
      if emojiCount < emojis.count {
        emojiCount += 1
      }
    } label: {
      Image(systemName: "plus.circle")
        .font(.largeTitle)
    }
  }
  
  var minusButton: some View {
    Button {
      if emojiCount > 1 {
        emojiCount -= 1
      }
    } label: {
      Image(systemName: "minus.circle")
        .font(.largeTitle)
    }
  }
}


struct CardView: View {
  let content: String
  @State private var isFaceUp = false
  var body: some View {
    ZStack {
      let cornerRadius: CGFloat = 15
      let roundedRectangle = RoundedRectangle(cornerRadius: cornerRadius)
      roundedRectangle
        .strokeBorder(lineWidth: 3)
        .background(Color.white)
        .cornerRadius(15)
      Text(content)
      if isFaceUp {
        roundedRectangle
      }
    }
    .onTapGesture { isFaceUp.toggle() }
    .aspectRatio(2/3, contentMode: .fill)
  }
}


///HStack with 3 ThemeChoserButton's
struct ThemeChoser: View {
  @Binding var emojiCount: Int
  @Binding var emojis: [String]
  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      ThemeChoserButton(emojiCount: $emojiCount, emojis: $emojis, selectedEmojis: EmojiStore.vehicles, imageName: "car", description: "Vehicles")
      Spacer()
      ThemeChoserButton(emojiCount: $emojiCount, emojis: $emojis, selectedEmojis: EmojiStore.flags, imageName: "flag", description: "Flags")
        .padding(.trailing)
      Spacer()
      ThemeChoserButton(emojiCount: $emojiCount, emojis: $emojis, selectedEmojis: EmojiStore.fruits, imageName: "circle.fill", description: "Fruits")
    }
  }
}

///Button with label made of VStack-ed SF symbol and short text description
struct ThemeChoserButton: View {
  @Binding var emojiCount: Int
  @Binding var emojis: [String]
  var selectedEmojis: [String]
  var imageName, description: String
  var body: some View {
    Button {
      emojis = selectedEmojis.shuffled()
      emojiCount = Int.random(in: 4...16)
    } label: {
      VStack {
        Image(systemName: imageName)
        Text(description)
          .font(.subheadline)
          .foregroundColor(.accentColor)
      }
    }
  }
}


struct EmojiStore {
  static let vehicles = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🚙", "🚝"]
  static let fruits = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍈", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥝"]
  static let flags = ["🏳️‍⚧️", "🇺🇳", "🇦🇿", "🇧🇾", "🇧🇪", "🇧🇴", "🇧🇷", "🇬🇧", "🇨🇦", "🇺🇸", "🇺🇦", "🇨🇭", "🇰🇷", "🇷🇺", "🇸🇪", "🇨🇿", "🇯🇵"]
}








struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
        .previewInterfaceOrientation(.landscapeRight)
      ContentView()
    }
  }
}


