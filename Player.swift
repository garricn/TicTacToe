//
//  Player.swift
//  TicTacToe
//
//  Created by Garric G. Nahapetian on 6/21/17.
//
//

import Foundation

enum Player: Int {
    case o = 0
    case x = 1
    case notSet = -1

    var mark: String {
        switch self {
        case .o:
            return "O"
        case .x:
            return "X"
        case .notSet:
            return " "
        }
    }

    var name: String {
        return "Player \(self.mark)"
    }

    var swapped: Player {
        switch self {
        case .o:
            return .x
        case .x:
            return .o
        case .notSet:
            fatalError()
        }
    }
}

