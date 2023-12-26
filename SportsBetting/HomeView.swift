//
//  HomeView.swift
//  MLB_Betting
//
//  Created by Matthew Levy on 7/19/23.
//

import SwiftUI

enum Sport : String {
    case NCAAF = "americanfootball_ncaaf"
    case NFL = "americanfootball_nfl"
    case NBA = "basketball_nba"
}

struct HomeView: View {
    @State private var games: [Game] = []
    @State private var isSettingsPresented = false
    @State private var sportSelection = Sport.NFL.rawValue
    let dateFormatter = DateFormatter()
    func getDate(_ date : Date) -> String {
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: date)
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $sportSelection) {
                    Text("NCAAF")
                        .tag(Sport.NCAAF.rawValue)
                    Text("NFL")
                        .tag(Sport.NFL.rawValue)
                    Text("NBA")
                        .tag(Sport.NBA.rawValue)
                    
                }
                .onChange(of: sportSelection) { newValue in
                    fetchData()
                }
                if games.isEmpty {
                    ProgressView()
                } else {
                    List(games) { game in
                        NavigationLink(destination: GameView(game: game)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(game.homeTeam)
                                    Text(game.awayTeam)
                                }
                                Spacer()
                                Text(getDate(game.commenceTime))
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
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }
    }
    
    func fetchData() {
        
        print("Starting Fetch ToDos")
        let API_KEY = "0dc43c2b159a9a895f510afd0d163eb0"
        let BASE_URL = "https://api.the-odds-api.com/v4/sports/\(sportSelection)/odds/"
        let REGIONS = "us"
        let MARKETS = "h2h"
        let ODDS_FORMAT = "decimal"
        let DATE_FORMAT = "iso"
        
        let urlString = "\(BASE_URL)?api_key=\(API_KEY)&regions=\(REGIONS)&markets=\(MARKETS)&oddsFormat=\(ODDS_FORMAT)&dateFormat=\(DATE_FORMAT)"
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


