//
//  RockPaperScissorsView.swift
//  RockPaperScissors
//
//  WHAT THIS GAME DOES NOW
//  You pick a move. The computer picks one at random.
//  The app shows both moves and decides who wins each round.
//  It keeps a score. The first player to reach winningScore wins the game.
//  When the game is over, the move buttons stop working and a
//  button appears to start a fresh game.
//  The result text changes colour: green for a win, red for a loss.
//  testNumber can fix the computer's move so tests give the same result every time.
//  NEW: Magic theme. The moves are Dragon (rock), Spellbook (paper) and Wand (scissors).
//  The names, emoji, title and colour are constants at the top of the file.
//  NEW: Streaks. The screen shows your current winning streak and your best streak.
//  NEW: Ties are counted too, and shown beside the two scores.
//  NEW: Victory effect. When you win the duel, a trophy pops up over the
//  duel and the box glows gold. It goes away when a new duel starts.
//  NEW: Trash talk. After every round the computer teases you with a funny line.
//

import SwiftUI

// The theme: the name and the picture for each move.
// Dragon plays the part of rock, Spellbook of paper, and Wand of scissors.
// TRY: Change these to give the game a new theme.
let rockName: String = "Dragon"
let paperName: String = "Spellbook"
let scissorsName: String = "Wand"
let rockEmoji: String = "🐉"
let paperEmoji: String = "📖"
let scissorsEmoji: String = "🪄"

// The title and the main colour of the game.
let gameTitle: String = "Magic Duel"
let themeColor: Color = Color.purple

// How many round wins a player needs to win the whole game.
let winningScore: Int = 3

// For testing only. 0 means the computer picks at random.
// Set it to 1 (Dragon), 2 (Spellbook) or 3 (Wand) to make the computer always pick that move.
let testNumber: Int = 0

// The game itself: what it remembers, what it shows on the screen,
// and what it does when you click a button.
struct RockPaperScissorsView: View {

    // MARK: - Stored properties

    // Each @State variable is something the game remembers.
    // When one of them changes, the screen updates by itself.

    // The name of each move, such as "Dragon", and the emoji that shows it.
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

    // How many rounds in this game ended in a tie.
    @State var tieCount: Int = 0

    // True once someone has reached winningScore. The move buttons stop working.
    @State var gameOver: Bool = false

    // True when the player has won the duel. It turns on the victory effect.
    @State var showVictory: Bool = false

    // The funny line the computer says to tease the player.
    @State var computerSpeech: String = "Ready to lose, little wizard? 😏"

    // How many rounds in a row the player has won right now.
    @State var currentStreak: Int = 0

    // The longest winning streak the player has had since the app opened.
    @State var bestStreak: Int = 0

    // MARK: - Computed properties

    var body: some View {
        VStack(spacing: 24) {

            // The title at the top of the screen.
            Text(gameTitle)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(themeColor)
                // Shrink the title a little if it does not fit on one line.
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            // The score and the goal.
            Text("You \(playerScore) - \(computerScore) Computer")
                .font(.title2)
                .bold()
            Text("Ties: \(tieCount)")
                .font(.headline)
                .foregroundStyle(Color.secondary)
            Text("First to \(winningScore) wins")
                .font(.subheadline)
                .foregroundStyle(Color.secondary)

            // The player's winning streaks.
            Text("Streak: \(currentStreak) 🔥   Best: \(bestStreak) ⭐️")
                .font(.headline)

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
            // The box glows gold when the player wins the duel.
            .background(showVictory ? Color.yellow.opacity(0.35) : themeColor.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            // The victory effect: a trophy that pops up over the duel.
            .overlay {
                if showVictory {
                    VStack(spacing: 4) {
                        Text("🏆")
                            .font(.system(size: 110))
                        Text("✨ Victory! ✨")
                            .font(.title)
                            .bold()
                            .foregroundStyle(Color.orange)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.yellow.opacity(0.85))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    // It grows from small to full size as it appears.
                    .transition(.scale(scale: 0.1).combined(with: .opacity))
                }
            }

            // The result of the round.
            Text(result)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(resultColor)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            // What the computer says, in a speech bubble.
            Text("💬 Computer: \(computerSpeech)")
                .font(.title3)
                .italic()
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.secondary.opacity(0.15))
                .clipShape(Capsule())

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
                        Text(rockName)
                    }
                    .frame(maxWidth: .infinity)
                }

                Button {
                    choosePaper()
                } label: {
                    VStack {
                        Text(paperEmoji)
                            .font(.system(size: 44))
                        Text(paperName)
                    }
                    .frame(maxWidth: .infinity)
                }

                Button {
                    chooseScissors()
                } label: {
                    VStack {
                        Text(scissorsEmoji)
                            .font(.system(size: 44))
                        Text(scissorsName)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.bordered)
            .font(.headline)
            .tint(themeColor)
            // The buttons cannot be clicked when the game is over.
            .disabled(gameOver)

            // This button only appears when the game is over.
            if gameOver {
                Button("New duel") {
                    resetGame()
                }
                .buttonStyle(.borderedProminent)
                .tint(themeColor)
            }

            Text("Rounds played: \(roundsPlayed)")
                .font(.headline)
                .foregroundStyle(Color.secondary)
        }
        .padding(32)
        .fontDesign(.rounded)
        // How big the game's window is on the Mac. It can be made taller or wider.
        .frame(minWidth: 520, minHeight: 700)
    }

    // MARK: - Functions

    // The player picked the rock move (Dragon).
    func chooseRock() {
        playerMove = rockName
        playerEmoji = rockEmoji
        playRound()
    }

    // The player picked the paper move (Spellbook).
    func choosePaper() {
        playerMove = paperName
        playerEmoji = paperEmoji
        playRound()
    }

    // The player picked the scissors move (Wand).
    func chooseScissors() {
        playerMove = scissorsName
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
            computerMove = rockName
            computerEmoji = rockEmoji
        } else if randomNumber == 2 {
            computerMove = paperName
            computerEmoji = paperEmoji
        } else {
            computerMove = scissorsName
            computerEmoji = scissorsEmoji
        }
    }

    // Decides who wins a round. It gives back "player", "computer" or "tie".
    // player and computer are the names of the two moves, such as "Dragon".
    // Dragon beats Wand, Wand beats Spellbook, Spellbook beats Dragon.
    func decideWinner(player: String, computer: String) -> String {
        if player == computer {
            return "tie"
        } else if (player == rockName && computer == scissorsName)
                    || (player == scissorsName && computer == paperName)
                    || (player == paperName && computer == rockName) {
            return "player"
        } else {
            return "computer"
        }
    }

    // Picks the funny line the computer says after a round.
    // winner is "player", "computer" or "tie". round is the number of rounds played.
    // The remainder of round % 3 is 0, 1 or 2, so the three lines for each result take turns.
    func computerSays(winner: String, round: Int) -> String {
        let pick: Int = round % 3

        if winner == "player" && pick == 0 {
            return "Beginner's luck! 😤"
        } else if winner == "player" && pick == 1 {
            return "My wand slipped. Totally not my fault. 🙄"
        } else if winner == "player" {
            return "I let you win that one. 😅"
        } else if winner == "computer" && pick == 0 {
            return "Too easy! 😎"
        } else if winner == "computer" && pick == 1 {
            return "Have you tried... being better? 🤭"
        } else if winner == "computer" {
            return "Go back to wizard school! 🏫"
        } else if pick == 0 {
            return "Hey, stop copying me! 😠"
        } else if pick == 1 {
            return "Great minds think alike. 🤔"
        } else {
            return "Jinx! You owe me a potion. 🧪"
        }
    }

    // Updates the streaks after a round that was won or lost (not after a tie).
    // won is true if the player won the round, and false if the player lost.
    func updateStreak(won: Bool) {
        if won {
            currentStreak += 1
            // A new record? Then the best streak grows too.
            if currentStreak > bestStreak {
                bestStreak = currentStreak
            }
        } else {
            currentStreak = 0
        }
    }

    // Plays one round, once the player has picked a move.
    func playRound() {
        chooseComputerMove()
        roundsPlayed += 1

        let winner: String = decideWinner(player: playerMove, computer: computerMove)
        computerSpeech = computerSays(winner: winner, round: roundsPlayed)

        if winner == "tie" {
            // A tie does not change the streak, but it is counted.
            tieCount += 1
            result = "The spells cancel out!"
            resultColor = Color.secondary
        } else if winner == "player" {
            playerScore += 1
            updateStreak(won: true)
            result = "Your magic wins!"
            resultColor = Color.green
        } else {
            computerScore += 1
            updateStreak(won: false)
            result = "The computer's magic wins!"
            resultColor = Color.red
        }

        // Check whether someone has reached the winning score.
        if playerScore >= winningScore || computerScore >= winningScore {
            gameOver = true
            if playerScore >= winningScore {
                result = "You are the Grand Wizard! 🎉"
                computerSpeech = "Nooo! I demand a rematch! 😭"
                // Turn on the victory effect, with a bouncy animation.
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                    showVictory = true
                }
            } else {
                result = "The computer wins the duel."
                computerSpeech = "Bow before the new Grand Wizard! 👑"
            }
        }
    }

    // Starts a brand new game. Everything goes back to how it was at the start,
    // except bestStreak, which is a record that lasts until the app is closed.
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
        tieCount = 0
        gameOver = false
        showVictory = false
        computerSpeech = "Ready to lose, little wizard? 😏"
        currentStreak = 0
    }
}

#Preview {
    RockPaperScissorsView()
}
