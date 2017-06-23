
// MARK: - Program
let controller = CommandLineInterfaceController(game: Game())

// Move 1
controller.start()
controller.register(move: controller.askForMove())
controller.evaluateResult(for: controller.currentPlayer)

// Move 2
controller.startNextMove()
controller.register(move: controller.askForMove())
controller.evaluateResult(for: controller.currentPlayer)

// Move 3
controller.startNextMove()
controller.register(move: controller.askForMove())
controller.evaluateResult(for: controller.currentPlayer)

// Move 4
controller.startNextMove()
controller.register(move: controller.askForMove())
controller.evaluateResult(for: controller.currentPlayer)

// Move 5
controller.startNextMove()
controller.register(move: controller.askForMove())
controller.evaluateResult(for: controller.currentPlayer)

// Move 6
controller.startNextMove()
controller.register(move: controller.askForMove())
controller.evaluateResult(for: controller.currentPlayer)

// Move 7
controller.startNextMove()
controller.register(move: controller.askForMove())
controller.evaluateResult(for: controller.currentPlayer)

// Move 8
controller.startNextMove()
controller.register(move: controller.askForMove())
controller.evaluateResult(for: controller.currentPlayer)

// Move 9
controller.startNextMove()
controller.register(move: controller.askForMove())
controller.evaluateResult(for: controller.currentPlayer)
