//
//  ContentView.swift
//  Memorize
//
//  Created by Jane Adrea on 2022/3/3.
//

import SwiftUI

/*
    "ContentView": name of the data structure
    ": View": the struct we created behaves like a View
 */
/*
 ": some View": the type of the variable
    If we return a Text here, we can use
    var body: Text
 Why use some View here? We may return complicated object here
 
 declare a variable of type Int -> "var a: Int"
 */
struct ContentView: View {
    // observe the viewModel changes
    @ObservedObject var viewModel: EmojiMemoryGame
    
    //var emojis: Array<String> = ["🌹", "🌸", "💐", "🌺", "🌷", "🌻", "🥀", "🌼"]
    //@State var emojiCount: Int = 8
    
    var body: some View {
        // use scrollView avoid affecting the button below
        /*
         Generic struct 'ForEach' requires that 'MemoryGame<String>.Card' conform to 'Hashable'
         -> make struct Card : Identifiable
         */
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                ForEach(viewModel.cards){ card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

/*
    All view is immutable in SwiftUI!!
    that's why we can't change isFaceUp inside the body
    -> use @State to isFaceUp
 */
/* var body: some View
    hiden return statement
    => return Text("Hello, world!")
    But here we use padding -> the return type is not Text!!
    =>Thus we use "some View" as return type here
 
    we can ignore the "return" here, since we only have one component here
    we can use {} instead of using content:{} as argument
 */
struct CardView: View{
    let card: MemoryGame<String>.Card
    /*
     REBUILD BODY IS EXPENSIVE!
     Avoid rebuild the whole body
     */
    var body: some View{
        ZStack(alignment: .center)  {
            // we can omit the type here
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                /*
                 use strokeBorder instead of stroke to avoid view cutting
                 */
                shape.strokeBorder(lineWidth: 3.0)
                Text(card.content).font(.largeTitle)
            }else if card.isMatch{
                shape.opacity(0)
            }else{
                shape.fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
