//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jane Adrea on 2022/3/8.
//

// Model

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    func choose(_ card: Card){
        
    }
    
    // pass a function to the init, the function would return the content
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        // add numberOfPairsOfCards * 2 to the array
        for pairIndex in 0..<numberOfPairsOfCards{
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        /* struct inside a struct
            Card in the memory game
         */
        var isFaceUp: Bool = false
        var isMatch: Bool = false
        var content: CardContent // don't care
    }
}
