import SwiftUI

struct NewGameView: View {
    var onCreate: (Game) -> Void

    @Environment(\.dismiss) var dismiss

    @State private var scoreLimit = 500
    @State private var playerNames = [String]()
    @State private var newPlayerName = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Score Limit") {
                    Stepper(
                        "\(scoreLimit)",
                        value: $scoreLimit,
                        in: 250...1000,
                        step: 250
                    )
                }

                Section("Players or Teams") {
                    ForEach(playerNames, id: \.self) {
                        Text($0)
                    }
                    .onDelete(perform: removePlayers)

                    HStack {
                        TextField("Name", text: $newPlayerName)
                        Button(action: addPlayer) {
                            Image(systemName: "plus.circle")
                        }
                        .disabled(newPlayerName.isEmpty)
                    }
                }

                Button("Start Game", systemImage: "play.circle.fill", action: createGame)
                    .disabled(playerNames.count < 2)
            }
            .navigationTitle("New Game")
        }
    }

    func addPlayer() {
        playerNames.append(newPlayerName)
        newPlayerName = ""
    }

    func removePlayers(at offsets: IndexSet) {
        playerNames.remove(atOffsets: offsets)
    }

    func createGame() {
        let players = playerNames.map { Player(name: $0) }
        let game = Game(scoreLimit: scoreLimit, players: players)
        onCreate(game)
        dismiss()
    }
}

#Preview {
    NewGameView { _ in }
}
