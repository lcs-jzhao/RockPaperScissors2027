# Magic Duel

A magic-themed Rock Paper Scissors: you duel the computer with a Dragon, a Spellbook and a Wand. The first to win 3 rounds wins the duel, and the screen keeps the score, the ties, and your winning streaks. Win the duel and a trophy pops up!

## How to play

1. Click Dragon, Spellbook or Wand.
2. Dragon beats Wand, Wand beats Spellbook, and Spellbook beats Dragon.
3. The first to win 3 rounds is the Grand Wizard.
4. Click "New duel" to play again.

## What I added

- **Pick the winner:** `decideWinner` works out who wins each round using `&&` and `||`.
- **Colour the result:** `resultColor` holds a `Color`. The result text is green for a win, red for a loss and grey for a tie.
- **Best of five, with the score:** the first player to win 3 rounds wins the match. The screen shows both scores and how many rounds were ties. The move buttons turn off with `.disabled`, and a "New duel" button appears to start again.
- **Magic theme:** the moves are now Dragon, Spellbook and Wand. The names, emoji, title and main colour are constants at the top of the file, so the whole theme can be changed in one place.
- **Streaks:** the screen shows my current winning streak and my best streak. The function `updateStreak(won:)` adds 1 for a win, goes back to 0 for a loss, and updates the best streak with an `if`.
- **Victory effect:** when I win the duel, a 🏆 pops up over the duel with a bouncy animation and the box turns gold. `showVictory` is a `Bool` that turns it on, and "New duel" turns it off.
- **Testing switch:** the constant `testNumber` makes the computer always pick the same move, so my tests give the same result every time.

## How it works

I'll explain my streak idea, because it uses the most of what we have learned.

**Constants and variables:** The streak uses two variables, `currentStreak` and `bestStreak`. Both are `Int` because a streak is a whole number, and both are `var` because they change during the game. The function has one parameter, `won`, which is a `Bool` because a round is either won or lost. Streaks work together with `winningScore`, which is a `let` because the number of wins needed never changes during a game.

**What does the work:** When I win a round, `playRound` calls `updateStreak(won: true)`. The function adds 1 to `currentStreak` with `+= 1`. Then an `if` checks whether `currentStreak > bestStreak`. If it is, `bestStreak` is set to the new, longer streak. When I lose, `updateStreak(won: false)` sets `currentStreak` back to 0 in the `else` part. A tie doesn't call the function at all, so a tie does not change the streak.

**Why I chose these tools:**
- I used a function with a parameter instead of writing the streak code in both the win branch and the loss branch. The streak rules are in one place, so if I want to change them I only fix one spot.
- I made the move names (`rockName`, `paperName`, `scissorsName`) constants instead of typing "Dragon", "Spellbook" and "Wand" in several places. `decideWinner`, the buttons and the computer's move all use them, so I can change the whole theme by changing one line at the top.
- In `decideWinner` I used `&&` and `||` in one `else if` instead of three `else if`s. `&&` means both things are true, like I picked Dragon and the computer picked Wand. `||` means any one of the three ways to win is enough. This way all the ways to win are in one spot and the code is shorter.

## Testing

For these tests I set `testNumber` to the number shown, so the computer always plays the same move. Afterwards I set it back to 0.

| Test | Chosen input | Should happen | Did happen |
|---|---|---|---|
| Dragon beats Wand | `testNumber` 3 (Wand). I choose Dragon. | "Your magic wins!" in green; my score and my streak each go up by 1. |  Pass. "Your magic wins!" in green; You 1 - 0 Computer; streak 1. |
| A loss | `testNumber` 3. I choose Spellbook. | "The computer's magic wins!" in red; the computer's score goes up by 1, and my streak goes back to 0. |  Pass. "The computer's magic wins!" in red; You 0 - 1 Computer; streak 0. |
| A tie after a win | `testNumber` 3. I choose Dragon, then Wand. | After Wand: "The spells cancel out!" in grey; Ties goes up by 1, both scores stay the same, and my streak stays at 1. |  Pass. "The spells cancel out!" in grey; Ties 1; still You 1 - 0 Computer; streak stayed 1. |
| Ties are counted | `testNumber` 3. I choose Wand three times. | Ties shows 3; both scores stay at 0, and the duel does not end. |  Pass. Ties 3; You 0 - 0 Computer; the duel did not end. |
| One win short of the duel | `testNumber` 3. I choose Dragon twice. | Score is You 2 - 0 Computer; streak 2; the buttons still work and "New duel" does not appear. |  Pass. You 2 - 0 Computer; streak 2; buttons still work, no "New duel". |
| Winning the duel | The same, then Dragon once more. | Score is You 3 - 0 Computer; "You are the Grand Wizard! 🎉"; the move buttons turn off and "New duel" appears; best streak is 3. |  Pass. You 3 - 0 Computer; "You are the Grand Wizard! 🎉"; buttons off and "New duel" appeared; best streak 3. |
| New duel keeps the best streak | After the last test, I click New duel, then Dragon once. | Scores, ties and rounds go back to 0, then score is You 1 - 0 Computer; streak is 1, but best streak stays 3. |  Pass. Everything went back to 0 except best streak 3; then You 1 - 0 Computer, streak 1, best still 3. |
| The computer wins the duel | `testNumber` 3. I choose Spellbook three times. | Score is You 0 - 3 Computer; "The computer wins the duel."; the move buttons turn off and "New duel" appears. |  Pass. You 0 - 3 Computer; "The computer wins the duel."; buttons off and "New duel" appeared. |
| The computer one win short | `testNumber` 3. I choose Spellbook twice. | Score is You 0 - 2 Computer; the buttons still work and "New duel" does not appear. | Pass. You 0 - 2 Computer; buttons still work, no "New duel". |
| Victory effect | `testNumber` 3. I choose Dragon three times. | No trophy after 2 wins. After the 3rd win, the 🏆 pops up and the box turns gold. | Pass. No trophy at 2 - 0; at 3 - 0 the trophy popped up and the box turned gold. |
| No victory effect when I lose | `testNumber` 3. I choose Spellbook three times. | "The computer wins the duel." and no trophy. | Pass. No trophy. |
| New duel hides the trophy | After the Victory effect test, I click New duel. | The trophy goes away and the box is purple again. | Pass. Trophy gone, box back to purple. |
| Wand beats Spellbook | `testNumber` 2 (Spellbook). I choose Wand. | "Your magic wins!" in green; my score goes up by 1. |  Pass. "Your magic wins!" in green; You 1 - 0 Computer. |
| Spellbook beats Dragon | `testNumber` 1 (Dragon). I choose Spellbook. | "Your magic wins!" in green; my score goes up by 1. |  Pass. "Your magic wins!" in green; You 1 - 0 Computer. |

## Credits

- The starting game was written by Mr. Gordon.
- Gemeni and Claude helped me with giving inspirations and correcting errors.
