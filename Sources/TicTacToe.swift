import Foundation

enum Player: String {
    case x = "X"
    case o = "O"
    case notSet = "_"

    var name: String {
        return "Player \(self.rawValue)"
    }
}

var availableMoves: [Int] = [1,2,3,4,5,6,7,8,9]

var currentPlayer: Player = .notSet

var currentBoardMoves: [Int: Player] = [:] {
    didSet {
        if currentPlayer == .notSet {
            currentPlayer = .o
        } else {
            currentPlayer = currentPlayer == .o ? .x : .o
        }
    }
}

currentBoardMoves = [1,2,3,4,5,6,7,8,9].reduce([:]) { result, int in
    var newResult = result
    newResult[int] = .notSet
    return newResult
}

var currentBoard: String {
    let one = currentBoardMoves[1]!
    let two = currentBoardMoves[2]!
    let three = currentBoardMoves[3]!
    let four = currentBoardMoves[4]!
    let five = currentBoardMoves[5]!
    let six = currentBoardMoves[6]!
    let seven = currentBoardMoves[7]!
    let eight = currentBoardMoves[8]!
    let nine = currentBoardMoves[9]!
    return
        "Current Board\n" +
        " ---|---|---\n" +
        "  \(one.rawValue)   \(two.rawValue)   \(three.rawValue) \n" +
        " ---|---|---\n" +
        "  \(four.rawValue)   \(five.rawValue)   \(six.rawValue) \n" +
        " ---|---|---\n" +
        "  \(seven.rawValue)   \(eight.rawValue)   \(nine.rawValue) \n"
}

let referenceBoard = "Reference Board\n" +
    "  ---|---|---\n" +
    "   1   2   3 \n" +
    "  ---|---|---\n" +
    "   4   5   6 \n" +
    "  ---|---|---\n" +
    "   7   8   9  \n"

func askForMove() -> Int {
    print("Available moves: \(availableMoves)")
    print("\(currentPlayer.name), make your move:")

    let move = readLine()

    while move == nil {
        return askForMove()
    }

    let int = Int(move!)

    while int == nil {
        return askForMove()
    }

    while !availableMoves.contains(int!) {
        return askForMove()
    }

    let string = "\n\n================\n\n" + "\(currentPlayer.name) picked: \(int!)\n"
    print(string)
    return int!
}

func startGame() {
    print(referenceBoard)
    print(currentBoard)
}

func handlePossibleWin(for player: Player) {
    let possibeWinner: [(Int, Int, Int)] = possibleWins.reduce([]) { (result, tuple) in
        let playerForMove0 = currentBoardMoves[tuple.0]
        let playerForMove1 = currentBoardMoves[tuple.1]
        let playerForMove2 = currentBoardMoves[tuple.2]

        let matched = [playerForMove0, playerForMove1, playerForMove2].filter({
            return $0 == player && $0 != Player.notSet
        }).flatMap({ $0 })

        if matched.count == 3 {
            return [tuple]
        } else {
            return result + []
        }
    }

    if !possibeWinner.isEmpty {
        print("\(player.name) won!")
        print(currentBoard)
        exit(0)
    }
}

func register(move: Int) {
    let _currentPlayer = currentPlayer
    // Mark players move onto board
    currentBoardMoves[move] = _currentPlayer
    // Remove move from available moves
    availableMoves = availableMoves.filter { $0 != move }

    handlePossibleWin(for: _currentPlayer)
}

func startNextMove() {
    startGame()
}

let possibleWins: [(Int, Int, Int)] = [
    (1,2,3),
    (1,4,7),
    (1,5,9),
    (4,5,6),
    (7,8,9),
    (2,5,8),
    (3,6,9),
    (3,5,7),
]

// MARK: - Program

// Move 1
startGame()
register(move: askForMove())

// Move 2
startNextMove()
register(move: askForMove())

// Move 3
startNextMove()
register(move: askForMove())

// Move 4
startNextMove()
register(move: askForMove())

// Move 5
startNextMove()
register(move: askForMove())

// Move 6
startNextMove()
register(move: askForMove())

// Move 7
startNextMove()
register(move: askForMove())

// Move 8
startNextMove()
register(move: askForMove())

// Move 9
startNextMove()
register(move: askForMove())
