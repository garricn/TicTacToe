//
//  ViewController.swift
//  TicTacToe-iOS
//
//  Created by Garric G. Nahapetian on 6/22/17.
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var positionButtons: [UIButton]!
    @IBOutlet weak var bottomLabel: UILabel!

    private var game = Game()

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }

    private func refresh() {
        positionButtons.forEach {
            if let player = game.markedPositions[$0.tag] {
                $0.setTitle(mark(for: player), for: .normal)
            }
        }
        bottomLabel.text = "Current Player: \(game.currentPlayer.mark)"
    }

    private func mark(for player: Player) -> String {
        if player == .notSet {
            return "_"
        } else {
            return player.mark
        }
    }

    private func setTitle(for button: UIButton) {
        if let player = game.markedPositions[button.tag] {
            button.setTitle(mark(for: player), for: .normal)
        }
    }

    @IBAction private func didTapPositionButton(_ sender: UIButton) {
        game.register(selected: sender.tag)
        setTitle(for: sender)

        let result = game.evaluateResult(for: game.currentPlayer)

        switch result {
        case .slatemate:
            bottomLabel.text = "Stalemate!"
            gameOver = true
        case .winner(let player):
            bottomLabel.text = "\(player.name) won!"
            gameOver = true
        case .onGoing:
            game.startNextMove()
            bottomLabel.text = "Current Player: \(game.currentPlayer.mark)"
        }
    }

    @IBAction func didTapRestartButton(_ sender: UIButton) {
        gameOver = false
        game = Game()
        refresh()
        enableButtons()
    }

    @IBOutlet weak var gameBoard: UIStackView!

    private var gameOver: Bool = false {
        didSet {
            if gameOver {
                disableButtons()
            }
        }
    }

    private func disableButtons() {
        positionButtons.forEach {
            $0.isUserInteractionEnabled = false
        }
    }

    private func enableButtons() {
        positionButtons.forEach {
            $0.isUserInteractionEnabled = true
        }
    }
}
