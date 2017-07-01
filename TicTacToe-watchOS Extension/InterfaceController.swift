//
//  InterfaceController.swift
//  TicTacToe-watchOS Extension
//
//  Created by Garric G. Nahapetian on 6/23/17.
//
//

import WatchKit
import Foundation

final class InterfaceController: WKInterfaceController {

    @IBOutlet private var button1: WKInterfaceButton!
    @IBOutlet private var button2: WKInterfaceButton!
    @IBOutlet private var button3: WKInterfaceButton!
    @IBOutlet private var button4: WKInterfaceButton!
    @IBOutlet private var button5: WKInterfaceButton!
    @IBOutlet private var button6: WKInterfaceButton!
    @IBOutlet private var button7: WKInterfaceButton!
    @IBOutlet private var button8: WKInterfaceButton!
    @IBOutlet private var button9: WKInterfaceButton!

    typealias PositionButton = (button: WKInterfaceButton, tag: Int)
    private var positionButtons: [PositionButton] {
        return [
            (button1, 1),
            (button2, 2),
            (button3, 3),
            (button4, 4),
            (button5, 5),
            (button6, 6),
            (button7, 7),
            (button8, 8),
            (button9, 9),
        ]
    }

    @IBOutlet var bottomLabel: WKInterfaceLabel!

    private var game = Game()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        refresh()
    }

    private func refresh() {
        positionButtons.forEach {
            if let player = game.markedPositions[$0.tag] {
                $0.button.setTitle(mark(for: player))
            }
        }
        bottomLabel.setText("Current Player: \(game.currentPlayer.mark)")
        enableButtons()
    }

    private func mark(for player: Player) -> String {
        if player == .notSet {
            return "        "
        } else {
            return "  \(player.mark)    "
        }
    }

    private func setTitle(for positionButton: PositionButton) {
        if let player = game.markedPositions[positionButton.tag] {
            positionButton.button.setTitle(mark(for: player))
        }
    }

    private func didTap(positionButton: PositionButton) {
        let position = positionButton.tag

        guard game.openPositions.contains(position) else {
            return
        }

        game.register(selected: position)
        setTitle(for: positionButton)

        switch game.evaluateResult(for: game.currentPlayer) {
        case .slatemate:
            bottomLabel.setText("Stalemate!")
            gameOver = true
        case .winner(let player):
            bottomLabel.setText("\(player.name) won!")
            gameOver = true
        case .onGoing:
            game.startNextMove()
            bottomLabel.setText("Current Player: \(game.currentPlayer.mark)")
        }
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
            $0.button.setEnabled(false)
        }
    }

    private func enableButtons() {
        positionButtons.forEach {
            $0.button.setEnabled(true)
        }
    }

    @IBAction func didTapButton1() {
        didTap(positionButton: positionButtons[0])
    }

    @IBAction func didTapButton2() {
        didTap(positionButton: positionButtons[1])
    }

    @IBAction func didTapButton3() {
        didTap(positionButton: positionButtons[2])
    }

    @IBAction func didTapButton4() {
        didTap(positionButton: positionButtons[3])
    }

    @IBAction func didTapButton5() {
        didTap(positionButton: positionButtons[4])
    }

    @IBAction func didTapButton6() {
        didTap(positionButton: positionButtons[5])
    }

    @IBAction func didTapButton7() {
        didTap(positionButton: positionButtons[6])
    }

    @IBAction func didTapButton8() {
        didTap(positionButton: positionButtons[7])
    }

    @IBAction func didTapButton9() {
        didTap(positionButton: positionButtons[8])
    }

    @IBAction func didTapRestart() {
        gameOver = false
        game = Game()
        refresh()
        enableButtons()
    }
}
