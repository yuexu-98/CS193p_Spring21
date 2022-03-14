//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jane Adrea on 2022/3/8.
//

// Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    // this function will modify the members
    mutating func choose(_ card: Card){
        
        // MARK: - Why not using &&?
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatch
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                /*
                 DOES NOT WORK: cards[chosenIndex].content == cards[potentialMatchIndex].content
                 content is dont care type
                 */
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatch = true
                    cards[potentialMatchIndex].isMatch = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            }else{
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        
        
        /*
         var chosenCard = cards[chosenIndex]
            this statement make a copy of the card instead of working on the origin copy
         
         we want the view reflect the changes in model
            -> make EmojiMemoryGame : ObservableObject
        */
    }
    
    /* return type Optional
    func index(of card: Card)-> Int?{
        for index in 0..<cards.count{
            if cards[index].id == card.id{
                return index
            }
        }
        return nil
    }
    */
    
    // pass a function to the init, the function would return the content
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        
        // add numberOfPairsOfCards * 2 to the array
        for pairIndex in 0..<numberOfPairsOfCards{
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        /* struct inside a struct
            Card in the memory game
         */
        var isFaceUp: Bool = false
        var isMatch: Bool = false
        var content: CardContent // don't care
        var id: Int
    }
}
