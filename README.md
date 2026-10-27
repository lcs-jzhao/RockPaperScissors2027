# Rock Paper Scissors
 
You against the computer. Click a move, and the computer picks one at random.
 
## What I added

- **Pick the winner:** `decideWinner` works out who wins each round using `&&` and `||`.
- **Colour the result:** `resultColor` holds a `Color`. The result text is green for a win, red for a loss and grey for a tie.
- **Best of five:** the first player to win 3 rounds wins the match. The move buttons turn off with `.disabled`, and a "New duel" button appears to start again.
- **Magic theme:** the moves are now Dragon, Spellbook and Wand. The names, emoji, title and main colour are constants at the top of the file, so the whole theme can be changed in one place.
- **Streaks:** the screen shows my current winning streak and my best streak. The function `updateStreak(won:)` adds 1 for a win, goes back to 0 for a loss, and updates the best streak with an `if`.
- **Testing switch:** the constant `testNumber` makes the computer always pick the same move, so my tests give the same result every time.

## How to play

1. Click Dragon, Spellbook or Wand.
2. Dragon beats Wand, Wand beats Spellbook, and Spellbook beats Dragon.
3. The first to win 3 rounds is the Grand Wizard.
4. Click "New duel" to play again.
## How it works

I'll explain my streak idea, because it uses the most of what we have learned.

**Constants and variables:** The streak uses two variables, `currentStreak` and `bestStreak`. Both are `Int` because a streak is a whole number, and both are `var` because they change during the game. The function has one parameter, `won`, which is a `Bool` because a round is either won or lost. Streaks work together with `winningScore`, which is a `let` because the number of wins needed never changes during a game.

**What does the work:** When I win a round, `playRound` calls `updateStreak(won: true)`. The function adds 1 to `currentStreak` with `+= 1`. Then an `if` checks whether `currentStreak > bestStreak`. If it is, `bestStreak` is set to the new, longer streak. When I lose, `updateStreak(won: false)` sets `currentStreak` back to 0 in the `else` part. A tie doesn't call the function at all, so a tie does not change the streak.

**Why I chose these tools:**
- I used a function with a parameter instead of writing the streak code in both the win branch and the loss branch. The streak rules are in one place, so if I want to change them I only fix one spot.
- I made the move names (`rockName`, `paperName`, `scissorsName`) constants instead of typing "Dragon", "Spellbook" and "Wand" in several places. `decideWinner`, the buttons and the computer's move all use them, so I can change the whole theme by changing one line at the top.
- In `decideWinner` I used


