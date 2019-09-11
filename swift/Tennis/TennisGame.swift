import Foundation

protocol TennisGame {
    init(player1: String, player2: String)
    func wonPoint(_ playerName: Players)
    var score: String? { get }
}
