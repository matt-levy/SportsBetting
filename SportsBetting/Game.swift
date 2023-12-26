//
//  Game.swift
//  Sports_Betting
//
//  Created by Matthew Levy on 11/2/23.
//

import Foundation

struct Outcome: Decodable {
    let name: String
    let price: Double
}

struct Market: Decodable {
    let key: String
    let lastUpdate: Date
    let outcomes: [Outcome]

    enum CodingKeys: String, CodingKey {
        case key, lastUpdate = "last_update", outcomes
    }
}

struct Bookmaker: Decodable {
    let key: String
    let title: String
    let lastUpdate: Date
    let markets: [Market]

    enum CodingKeys: String, CodingKey {
        case key, title, lastUpdate = "last_update", markets
    }
}

struct Game: Identifiable, Decodable {
    let id: String
    let sportKey: String
    let sportTitle: String
    let commenceTime: Date
    let homeTeam: String
    let awayTeam: String
    let bookmakers: [Bookmaker]

    enum CodingKeys: String, CodingKey {
        case id, sportKey = "sport_key", sportTitle = "sport_title", commenceTime = "commence_time", homeTeam = "home_team", awayTeam = "away_team", bookmakers
    }
}

