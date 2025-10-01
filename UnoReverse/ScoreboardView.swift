import SwiftUI

struct ScoreboardView: View {
    @Bindable var game: Game

    @Environment(\.dismiss) var dismiss

    @State private var roundWinner: Player?
    @State private var points: Int?
    @FocusState private var focusedOnPointsField: Bool

    var cannotProceed: Bool {
        roundWinner == nil || points == nil || points! <= 0
    }

    var gameWouldEnd: Bool {
        if let roundWinner, let points {
            if game.scores[roundWinner, default: 0] + points >= game.scoreLimit {
                return true
            }
        }
        return false
    }

    var buttonLabel: String {
        gameWouldEnd ? "End Game" : "End Round"
    }

    var buttonIcon: String {
        gameWouldEnd ? "stop.circle.fill" : "forward.circle.fill"
    }

    var body: some View {
        NavigationStack {
            List(selection: $roundWinner) {
                Section {
                    ForEach(game.scoreboard, id: \.0) { (player, score) in
                        HStack {
                            ScoreProgressRing(score: score, scoreLimit: game.scoreLimit)
                                .frame(width: 50)
                                .padding(.trailing, 4)
                                .animation(.linear, value: score)
                                .font(.callout.bold())
                            Text(player.name)
                                .font(.largeTitle.weight(.light))
                            if player == roundWinner {
                                Spacer()
                                Image(systemName: "crown.fill")
                                    .foregroundStyle(.blue)
                                    .font(.title)
                            }
                            if player == game.winner {
                                Spacer()
                                Image(systemName: "party.popper.fill")
                                    .foregroundStyle(.blue)
                                    .font(.title)
                            }
                        }
                        .tag(player)
                        .selectionDisabled(game.isOver)
                        .onChange(of: roundWinner) {
                            focusedOnPointsField = true
                        }
                    }
                }

                Section("Tap the winner above...") {
                    TextField("...and enter their points", value: $points.animation(), format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focusedOnPointsField)

                    Button(buttonLabel, systemImage: buttonIcon, action: endRound)
                        .disabled(cannotProceed)
                }

                if game.isOver {
                    Button("Rematch", systemImage: "memories", action: rematch)
                }
            }
            .navigationTitle("First to \(game.scoreLimit) wins")
        }
    }

    func endRound() {
        withAnimation(.easeInOut) {
            game.endRound(winner: roundWinner!, points: points!)
            roundWinner = nil
            points = nil
        } completion: {
            if !game.isOver {
                dismiss()
            }
        }
    }

    func rematch() {
        withAnimation {
            game.reset()
        } completion: {
            dismiss()
        }
    }
}

#Preview {
    let players = [
        Player(name: "Ryan"),
        Player(name: "Jo")
    ]
    let game = Game(scoreLimit: 500, players: players)
    game.endRound(winner: players[0], points: 69)
    game.endRound(winner: players[1], points: 420)
    return ScoreboardView(game: game)
}
