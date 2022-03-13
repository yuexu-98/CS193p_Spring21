//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jane Adrea on 2022/3/8.
//


/* View Model
    The gate keeper of a model
 */

import SwiftUI



class EmojiMemoryGame{
    
    static let emojis: Array<String> = ["🌹", "🌸", "💐", "🌺", "🌷", "🌻", "🥀", "🌼"]
    /*
     If we want to access this in an instance function, we need to specify the class name
     */
    static func createMemoryGame() -> MemoryGame<String>{
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    /* protect this from modifying this by View
       private(set): can look at this but can not modify this
     */
    /*
     Error: "Cannot use instance member 'emojis' within property initializer; property initializers run before 'self' is available"
     -> we can not call emoji during property initializers
     -> Solution1: use init
     -> Solution2: make emojis as global variable instead of a class variable
     -> Solution3: use 'static'
     */
    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
}
