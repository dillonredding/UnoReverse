import Testing
@testable import UnoReverse

struct GameTests {
    let game = Game(scoreLimit: 500)

    let players = [
        Player(name: "Jo"),
        Player(name: "Ryan")
    ]

//    @Test func creatingGame() {
//        #expect(game.players.isEmpty)
//        #expect(game.rounds.isEmpty)
//        #expect(game.scoreboard.isEmpty)
//        #expect(game.hasBegun == false)
//        #expect(game.isOver == false)
//        #expect(game.winner == nil)
//    }
//
//    @Test func addingPlayers() {
//        game.players += players
//        #expect(game.players.count == 2)
//        #expect(game.hasBegun == false)
//    }
//
//    @Test func beginningGame() throws {
//        game.players += players
//        game.begin()
//        #expect(game.hasBegun == true)
//        let round1 = try #require(game.rounds.first)
//        #expect(round1.winner == nil)
//        #expect(round1.points == nil)
//        #expect(game.scoreboard.count == players.count)
//        for player in players {
//            #expect(game.scoreboard[player] == 0)
//        }
//    }
//
//    @Test func endingRound() {
//        game.players += players
//        game.begin()
//        game.endRound(winner: players[0], points: 69)
//        let round1 = game.rounds[0]
//        #expect(round1.winner == players[0])
//        #expect(round1.points == 69)
//        let round2 = game.rounds[1]
//        #expect(round2.winner == nil)
//        #expect(round2.points == nil)
//    }
//
//    @Test func scoreboard() {
//        game.players += players
//        game.begin()
//        game.endRound(winner: players[0], points: 69)
//        game.endRound(winner: players[1], points: 420)
//        game.endRound(winner: players[0], points: 31)
//        #expect(game.scoreboard[players[0]] == 100)
//        #expect(game.scoreboard[players[1]] == 420)
//    }
//
//    @Test func endingGame() {
//        game.players += players
//        game.begin()
//        game.endRound(winner: players[0], points: 100)
//        game.endRound(winner: players[1], points: 200)
//        game.endRound(winner: players[0], points: 300)
//        game.endRound(winner: players[1], points: 400)
//        #expect(game.isOver == true)
//        #expect(game.winner == players[1])
//    }
//
//    @Test func resettingGame() {
//        game.players += players
//        game.begin()
//        game.endRound(winner: players[0], points: game.scoreLimit)
//        game.reset()
//        #expect(game.hasBegun == true)
//        #expect(game.rounds.count == 1)
//        #expect(game.rounds[0].winner == nil)
//        #expect(game.rounds[1].points == nil)
//        #expect(game.isOver == false)
//        #expect(game.winner == nil)
//        for player in players {
//            #expect(game.scoreboard[player] == 0)
//        }
//    }
}
