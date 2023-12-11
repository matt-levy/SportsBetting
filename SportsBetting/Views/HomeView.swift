//
//  HomeView.swift
//  MLB_Betting
//
//  Created by Matthew Levy on 7/19/23.
//

import SwiftUI

struct HomeView: View {
    @State private var games: [Game] = []
    @State private var isSettingsPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                if games.isEmpty {
                    ProgressView()
                } else {
                    List(games) { game in
                        NavigationLink(destination: GameView(game: game)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Sport: \(game.sportTitle)")
                                    Text("Home: \(game.homeTeam)")
                                    Text("Away: \(game.awayTeam)")
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    
                }
            }
            .onAppear {
                fetchData()
            }
            .navigationTitle("Game Odds")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        isSettingsPresented = true
                    }) {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $isSettingsPresented) {
                Text("Hello")
            }
        }
    }
    
    func fetchData() {
        
        print("Starting Fetch ToDos")
        let API_KEY = "0dc43c2b159a9a895f510afd0d163eb0"
        let BASE_URL = "https://api.the-odds-api.com/v4/sports/americanfootball_ncaaf/odds/"
        let SPORT = "americanfootball_ncaaf"
        let REGIONS = "us"
        let MARKETS = "h2h"
        let ODDS_FORMAT = "decimal"
        let DATE_FORMAT = "iso"
        
        let urlString = "\(BASE_URL)?api_key=\(API_KEY)&sport=\(SPORT)&regions=\(REGIONS)&markets=\(MARKETS)&oddsFormat=\(ODDS_FORMAT)&dateFormat=\(DATE_FORMAT)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        print("1")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                print("2")
                print(urlString)
                // Decode the JSON data into an array of Game objects
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // Assuming the date is in ISO8601 format
                let games = try decoder.decode([Game].self, from: data)
                
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    print("Games: \(games)")
                    self.games = games
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


