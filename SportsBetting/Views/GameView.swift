//
//  GameView.swift
//  SwiftUI sports betting app
//
//  Created by Matthew Levy on 12/10/23.
//

import SwiftUI

struct GameView: View {
    let game: Game
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Game Details")
                    .font(.title)
                
                // Display other details about the game here
                
                // Display odds for each bookmaker in a vertical list
                ForEach(game.bookmakers.indices, id: \.self) { index in
                    let bookmaker = game.bookmakers[index]
                    let homeOutcome = bookmaker.markets[0].outcomes[0]
                    let awayOutcome = bookmaker.markets[0].outcomes[1]
                    
                    // Display bookmaker name with headline font
                    Text("Bookmaker: \(bookmaker.title)")
                        .font(.headline)
                        .padding(.bottom, 2)
                    
                    // Display odds for home team
                    Text("\(homeOutcome.name): \(String(format: "%.02f", homeOutcome.price))")
                    
                    // Display odds for away team
                    Text("\(awayOutcome.name): \(String(format: "%.02f", awayOutcome.price))")
                        .padding(.bottom, 4)
                    
                    
                    // Add separator between bookmakers
                    Divider()
                        .padding(.bottom, 8)
                }
            }
            .padding()
        }
    }
}

