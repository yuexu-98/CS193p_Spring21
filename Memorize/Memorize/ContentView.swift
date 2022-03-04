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
struct ContentView: View {
    /*
     ": some View": the type of the variable
        If we return a Text here, we can use
        var body: Text
     Why use some View here? We may return complicated object here
     
     declare a variable of type Int -> "var a: Int"
     */
    
    var emojis: Array<String> = ["🌹", "🌸", "💐", "🌺", "🌷", "🌻", "🥀", "🌼"]
    @State var emojiCount: Int = 8
    
    var body: some View {
        VStack{
            // use scrollView avoid affecting the button below
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(emojis[0..<emojiCount], id: \.self){ emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            // spacer will take all the available space in default
            Spacer()
            HStack{
                remove
                Spacer()
                add
            }
            .padding(.horizontal)
            .font(.largeTitle)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button(action: {
            if emojiCount > 1{
                emojiCount -= 1
            }
            
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    
    var add: some View {
        Button(action: {
            if emojiCount < emojis.count{
                emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
}

/*
    All view is immutable in SwiftUI!!
    that's why we can't change isFaceUp inside the body
    -> use @State to isFaceUp
 */
struct CardView: View{
    /*
        hiden return statement
        => return Text("Hello, world!")
        But here we use padding -> the return type is not Text!!
        =>Thus we use "some View" as return type here
     
        we can ignore the "return" here, since we only have one component here
        we can use {} instead of using content:{} as argument
     */

    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View{
        ZStack(alignment: .center)  {
            // we can omit the type here
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                /*
                 use strokeBorder instead of stroke to avoid view cutting
                 */
                shape.strokeBorder(lineWidth: 3.0)
                Text(content).font(.largeTitle)
            }else{
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
    

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portraitUpsideDown)
        ContentView()
            .preferredColorScheme(.light)
    }
}
