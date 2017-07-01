//
//  CommandLineGame.swift
//  TicTacToe
//
//  Created by Garric G. Nahapetian on 6/21/17.
//
//

import Foundation

final class CommandLineInterfaceController {

    // MARK: - UI Elements

    private let referenceBoard: String = ""
        + "\nReference Board\n\n"
        + "  ---|---|---\n"
        + "   1   2   3 \n"
        + "  ---|---|---\n"
        + "   4   5   6 \n"
        + "  ---|---|---\n"
        + "   7   8   9\n"

    private var currentBoard: String {
        let positions = game.markedPositions
        let one = positions[1]!.mark
        let two = positions[2]!.mark
        let three = positions[3]!.mark
        let four = positions[4]!.mark
        let five = positions[5]!.mark
        let six = positions[6]!.mark
        let seven = positions[7]!.mark
        let eight = positions[8]!.mark
        let nine = positions[9]!.mark
        let string = ""
            + " Current Board\n\n"
            + "  ---|---|---\n"
            + "   \(one)   \(two)   \(three) \n"
            + "  ---|---|---\n"
            + "   \(four)   \(five)   \(six) \n"
            + "  ---|---|---\n"
            + "   \(seven)   \(eight)   \(nine) \n"
        return string
    }

    private let divider = "\n================\n"

    private let game: Game

    private var currentPlayer: Player {
        return game.currentPlayer
    }

    init(game: Game = Game()) {
        self.game = game
    }

    func startGame() {
        print("START!")

        while game.evaluateResult(for: currentPlayer) == .onGoing {
            print(divider)
            print(referenceBoard)
            print(currentBoard)
            register(move: askForMove())
            evaluateResult(for: currentPlayer)
            game.startNextMove()
        }

        print(divider)
        evaluateResult(for: currentPlayer)
    }

    private func askForMove() -> Int {
        let openPositions = game.openPositions.sorted()
        let playerName = currentPlayer.name
        print("Open positions: \(openPositions)\n")
        print("\(playerName), make your move:\n")

        let move = readLine()

        while move == nil {
            return askForMove()
        }

        let int = Int(move!)

        while int == nil {
            return askForMove()
        }

        while !openPositions.contains(int!) {
            return askForMove()
        }

        let string = "\n\(playerName) picked: \(int!)\n"
        print(string)
        return int!
    }

    private func register(move: Move) {
        game.register(selected: move)
    }

    private func evaluateResult(for player: Player) {
        let result = game.evaluateResult(for: player)
        switch result  {
        case .slatemate:
            print(currentBoard.replacingOccurrences(of: "Current Board", with: "Stalemate Board!"))
            exit(0)
        case .winner(player):
            print("\(player.name) won!\n")
            print(currentBoard)
            exit(0)
        default: break
        }
    }
}
