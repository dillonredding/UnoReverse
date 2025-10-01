import Foundation

struct Player: Comparable, Hashable {
    var name: String
    
    static func < (lhs: Player, rhs: Player) -> Bool {
        lhs.name < rhs.name
    }
}

@Observable
class Game {
    var scoreLimit: Int
    private(set) var scores = [Player: Int]()
    private(set) var winner: Player?

    init(scoreLimit: Int = 500, players: [Player]) {
        self.scoreLimit = scoreLimit
        for player in players {
            scores[player] = 0
        }
    }

    var scoreboard: [(Player, Int)] {
        scores.sorted(by: {
            let (player1, score1) = $0
            let (player2, score2) = $1
            return if score1 != score2 {
                score1 > score2
            } else {
                player1 < player2
            }
        })
    }

    var isOver: Bool { winner != nil }

    func endRound(winner: Player, points: Int) {
        let updatedScore = points + scores[winner, default: 0]
        scores[winner] = updatedScore
        if updatedScore >= scoreLimit {
            self.winner = winner
        }
    }

    func reset() {
        for (player, _) in scores {
            scores[player] = 0
        }
        winner = nil
    }
}
