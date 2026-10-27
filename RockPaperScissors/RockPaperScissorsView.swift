//
//  RockPaperScissorsView.swift
//  RockPaperScissors
//
//  WHAT THIS GAME DOES NOW
//  You pick rock, paper or scissors. The computer picks one at random.
//  The app shows both moves and decides who wins each round.
//  NEW: It keeps a score. The first player to reach winningScore wins the game.
//  NEW: When the game is over, the move buttons stop working and a
//  "Play again" button appears. It starts a fresh game.
//  NEW: The result text changes colour: green for a win, red for a loss.
//  NEW: testNumber can fix the computer's move so tests give the same result every time.
//

import SwiftUI

// The picture for each move. These are emoji, so they are just text.
// TRY: Change these to other emoji to give the game a new theme.
let rockEmoji: String = "🪨"
let paperEmoji: String = "📄"
let scissorsEmoji: String = "✂️"

// How many round wins a player needs to win the whole game.
let winningScore: Int = 3

// For testing only. 0 means the computer picks at random.
// Set it to 1 (Rock), 2 (Paper) or 3 (Scissors) to make the computer always pick that move.
let testNumber: Int = 0

// The game itself: what it remembers, what it shows on the screen,
// and what it does when you click a button.
struct RockPaperScissorsView: View {

    // MARK: - Stored properties

    // Each @State variable is something the game remembers.
    // When one of them changes, the screen updates by itself.

    // The name of each move, such as "Rock", and the emoji that shows it.
    // Before the first round, nobody has picked a move yet.
    @State var playerMove: String = "No move yet"
    @State var playerEmoji: String = "❓"
    @State var computerMove: String = "No move yet"
    @State var computerEmoji: String = "❓"

    // What happened in the last round.
    @State var result: String = "Let's play!"

    // The colour of the result text. It changes with each result.
    @State var resultColor: Color = Color.primary

    // How many rounds have been played.
    @State var roundsPlayed: Int = 0

    // How many rounds the player has won in this game.
    @State var playerScore: Int = 0

    // How many rounds the computer has won in this game.
    @State var computerScore: Int = 0

    // True once someone has reached winningScore. The move buttons stop working.
    @State var gameOver: Bool = false

    // MARK: - Computed properties

    var body: some View {
        VStack(spacing: 24) {

            // The title at the top of the screen.
            Text("Rock Paper Scissors")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(Color.teal)
                // Shrink the title a little if it does not fit on one line.
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            // The score and the goal.
            Text("You \(playerScore) - \(computerScore) Computer")
                .font(.title2)
                .bold()
            Text("First to \(winningScore) wins")
                .font(.subheadline)
                .foregroundStyle(Color.secondary)

            Spacer()

            // The two moves, side by side.
            HStack {
                VStack(spacing: 8) {
                    Label("You", systemImage: "person.fill")
                        .font(.headline)
                    Text(playerEmoji)
                        .font(.system(size: 90))
                    Text(playerMove)
                        .font(.title3)
                }
                .frame(maxWidth: .infinity)

                Text("vs")
                    .font(.title)
                    .foregroundStyle(Color.secondary)

                VStack(spacing: 8) {
                    Label("Computer", systemImage: "desktopcomputer")
                        .font(.headline)
                    Text(computerEmoji)
                        .font(.system(size: 90))
                    Text(computerMove)
                        .font(.title3)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical)
            .background(Color.teal.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 24))

            // The result of the round.
            Text(result)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(resultColor)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            Spacer()

            // One button for each move the player can make.
            // The code inside the braces runs when that button is clicked.
            Text("Choose your move")
                .font(.headline)
                .foregroundStyle(Color.secondary)

            HStack(spacing: 12) {
                Button {
                    chooseRock()
                } label: {
                    VStack {
                        Text(rockEmoji)
                            .font(.system(size: 44))
                        Text("Rock")
                    }
                    .frame(maxWidth: .infinity)
                }

                Button {
                    choosePaper()
                } label: {
                    VStack {
                        Text(paperEmoji)
                            .font(.system(size: 44))
                        Text("Paper")
                    }
                    .frame(maxWidth: .infinity)
                }

                Button {
                    chooseScissors()
                } label: {
                    VStack {
                        Text(scissorsEmoji)
                            .font(.system(size: 44))
                        Text("Scissors")
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.bordered)
            .font(.headline)
            // TRY: Change teal to another colour. Change it in the title and the moves box too.
            .tint(Color.teal)
            // The buttons cannot be clicked when the game is over.
            .disabled(gameOver)

            // This button only appears when the game is over.
            if gameOver {
                Button("Play again") {
                    resetGame()
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.teal)
            }

            Text("Rounds played: \(roundsPlayed)")
                .font(.headline)
                .foregroundStyle(Color.secondary)
        }
        .padding(32)
        .fontDesign(.rounded)
        // How big the game's window is on the Mac. It can be made taller or wider.
        .frame(minWidth: 520, minHeight: 640)
    }

    // MARK: - Functions

    // The player picked rock.
    func chooseRock() {
        playerMove = "Rock"
        playerEmoji = rockEmoji
        playRound()
    }

    // The player picked paper.
    func choosePaper() {
        playerMove = "Paper"
        playerEmoji = paperEmoji
        playRound()
    }

    // The player picked scissors.
    func chooseScissors() {
        playerMove = "Scissors"
        playerEmoji = scissorsEmoji
        playRound()
    }

    // The computer picks its move at random.
    func chooseComputerMove() {

        // Pick 1, 2 or 3. Each number stands for one move.
        var randomNumber: Int = Int.random(in: 1...3)

        // When testing, testNumber replaces the random number.
        if testNumber >= 1 && testNumber <= 3 {
            randomNumber = testNumber
        }

        if randomNumber == 1 {
            computerMove = "Rock"
            computerEmoji = rockEmoji
        } else if randomNumber == 2 {
            computerMove = "Paper"
            computerEmoji = paperEmoji
        } else {
            computerMove = "Scissors"
            computerEmoji = scissorsEmoji
        }
    }

    // Decides who wins a round. It gives back "player", "computer" or "tie".
    // player and computer are the names of the two moves, such as "Rock".
    func decideWinner(player: String, computer: String) -> String {
        if player == computer {
            return "tie"
        } else if (player == "Rock" && computer == "Scissors")
                    || (player == "Scissors" && computer == "Paper")
                    || (player == "Paper" && computer == "Rock") {
            return "player"
        } else {
            return "computer"
        }
    }

    // Plays one round, once the player has picked a move.
    func playRound() {
        chooseComputerMove()
        roundsPlayed += 1

        let winner: String = decideWinner(player: playerMove, computer: computerMove)

        if winner == "tie" {
            // TRY: Change what the game says when there is a tie.
            result = "It's a tie!"
            resultColor = Color.secondary
        } else if winner == "player" {
            playerScore += 1
            result = "You win this round!"
            resultColor = Color.green
        } else {
            computerScore += 1
            result = "Computer wins this round!"
            resultColor = Color.red
        }

        // Check whether someone has reached the winning score.
        if playerScore >= winningScore || computerScore >= winningScore {
            gameOver = true
            if playerScore >= winningScore {
                result = "You won the game! 🎉"
            } else {
                result = "The computer won the game."
            }
        }
    }

    // Starts a brand new game. Everything goes back to how it was at the start.
    func resetGame() {
        playerMove = "No move yet"
        playerEmoji = "❓"
        computerMove = "No move yet"
        computerEmoji = "❓"
        result = "Let's play!"
        resultColor = Color.primary
        roundsPlayed = 0
        playerScore = 0
        computerScore = 0
        gameOver = false
    }
}

#Preview {
    RockPaperScissorsView()
}
