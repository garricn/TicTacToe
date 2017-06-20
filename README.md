# TicTacToe
Swift CommandLine TicTacToe. Created and Exported with [Marathon](https://github.com/JohnSundell/Marathon).

# Installation

## On macOS

### Make

```
$ git clone https://github.com/garricn/TicTacToe.git
$ cd TicTacToe
$ make
```

### Swift Package Manager

```
$ git clone https://github.com/garricn/TicTacToe.git
$ cd TicTacToe
$ swift build -c release -Xswiftc -static-stdlib
$ cp -f .build/release/TicTacToe /usr/local/bin/tictactoe
```

### On Linux

**Note**: Swift is required. Follow the instructions [here](https://swift.org/getting-started/#installing-swift) for installing Swift on Linux.

```
$ git clone https://github.com/garricn/TicTacToe.git
$ cd TicTacToe
$ swift build -c release
$ cp -f .build/release/TicTacToe /usr/local/bin/tictactoe
```

# Usage

Run `tictactoe` from anywhere on Command Line.
