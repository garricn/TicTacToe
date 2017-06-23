//
//  ViewController.swift
//  TicTacToe-macOS
//
//  Created by Garric G. Nahapetian on 6/23/17.
//
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet private weak var button1: NSButton!
    @IBOutlet private weak var button2: NSButton!
    @IBOutlet private weak var button3: NSButton!
    @IBOutlet private weak var button4: NSButton!
    @IBOutlet private weak var button5: NSButton!
    @IBOutlet private weak var button6: NSButton!
    @IBOutlet private weak var button7: NSButton!
    @IBOutlet private weak var button8: NSButton!
    @IBOutlet private weak var button9: NSButton!

    private var positionButtons: [NSButton] {
        return [
            button1,
            button2,
            button3,
            button4,
            button5,
            button6,
            button7,
            button8,
            button9,
        ]
    }

    @IBOutlet weak var bottomLabel: NSTextField!

    private var game = Game()

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }

    @IBAction func didPushPositionButton(_ sender: NSButton) {
        game.register(selected: sender.tag)
        setTitle(for: sender)

        let result = game.evaluateResult(for: game.currentPlayer)

        switch result {
        case .slatemate:
            bottomLabel.stringValue = "Stalemate!"
            gameOver = true
        case .winner(let player):
            bottomLabel.stringValue = "\(player.name) won!"
            gameOver = true
        case .onGoing:
            game.startNextMove()
            bottomLabel.stringValue = "Current Player: \(game.currentPlayer.mark)"
        }
    }

    private func refresh() {
        positionButtons.forEach {
            if let player = game.markedPositions[$0.tag] {
                $0.title = mark(for: player)
            }
        }
        bottomLabel.stringValue = "Current Player: \(game.currentPlayer.mark)"
    }

    private func mark(for player: Player) -> String {
        if player == .notSet {
            return "_"
        } else {
            return player.mark
        }
    }

    private func setTitle(for button: NSButton) {
        if let player = game.markedPositions[button.tag] {
            button.title = mark(for: player)
        }
    }

    @IBAction func didPushRestartButton(_ sender: NSButton) {
        gameOver = false
        game = Game()
        refresh()
        enableButtons()
    }

    private var gameOver: Bool = false {
        didSet {
            if gameOver {
                disableButtons()
            }
        }
    }

    private func disableButtons() {
        positionButtons.forEach {
            $0.isEnabled = false
        }
    }

    private func enableButtons() {
        positionButtons.forEach {
            $0.isEnabled = true
        }
    }
}

