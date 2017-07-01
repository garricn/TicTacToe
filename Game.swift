//
//  Game.swift
//  TicTacToe
//
//  Created by Garric G. Nahapetian on 6/21/17.
//
//

import Foundation

typealias Position = Int
typealias Positions = [Position]

typealias Move = Position
typealias PossibleWin = (firstMove: Move, secondMove: Move, thirdMove: Move)
typealias PossibleWins = [PossibleWin]

class Game {

    private(set) var currentPlayer: Player = .o

    private(set) var markedPositions: [Position: Player] = [1,2,3,4,5,6,7,8,9].reduce([:]) { result, int in
        var newResult = result
        newResult[int] = .notSet
        return newResult
    }

    var openPositions: Set<Position> {
        let foo: Positions = markedPositions.flatMap { position, player in
            if player == .notSet {
                return position
            } else {
                return nil
            }
        }
        return Set(foo)
    }

    private let possibleWins: PossibleWins = [
        (1,2,3),
        (1,4,7),
        (1,5,9),
        (4,5,6),
        (7,8,9),
        (2,5,8),
        (3,6,9),
        (3,5,7),
        ]

    private var currentPossibleWins: PossibleWins {
        return possibleWins.filter { win in
            let players = [win.firstMove, win.secondMove, win.thirdMove].flatMap { markedPositions[$0] }
            return !(players.contains(.o) && players.contains(.x))
        }
    }

    func startNextMove() {
        currentPlayer = currentPlayer.swapped
    }

    func register(selected position: Position) {
        markedPositions[position] = currentPlayer
    }

    func evaluateResult(for player: Player) -> Game.Result {
        let possibeWinner: PossibleWins = currentPossibleWins.filter { tuple in
            let playerForMove0 = markedPositions[tuple.0]
            let playerForMove1 = markedPositions[tuple.1]
            let playerForMove2 = markedPositions[tuple.2]

            return playerForMove0 == playerForMove1
                && playerForMove1 == playerForMove2
                && playerForMove0 != nil
                && playerForMove0 != .notSet
        }

        if !possibeWinner.isEmpty {
            return .winner(player)
        }

        if currentPossibleWins.isEmpty {
            return .slatemate
        }

        if currentPossibleWins.count == 1 {
            let win = currentPossibleWins[0]
            let moves = [win.firstMove, win.secondMove, win.thirdMove]
            let players = moves.flatMap { markedPositions[$0] }.filter { $0 != .notSet }

            if players.count == 2,
                players[0] != players[1]
                    || players[0] != currentPlayer.swapped {
                return .slatemate
            }
        }

        return .onGoing
    }

    enum Result: Equatable {
        case winner(Player)
        case slatemate
        case onGoing

        static func ==(lhs: Result, rhs: Result) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }

        var hashValue: Int {
            switch self {
            case .winner:
                return 0
            case .slatemate:
                return 1
            case .onGoing:
                return 2
            }
        }
    }
}
