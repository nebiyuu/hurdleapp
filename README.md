# HurdleApp

A Wordle-like game built with Flutter.

## Features

- Guess the 5-letter word in 6 attempts.
- Interactive on-screen keyboard.
- Visual feedback for correct and incorrect letters.
- Play again after winning or losing.

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart SDK (comes with Flutter)
- An editor like VS Code or Android Studio

### Installation

1. Clone this repository:
   ```sh
   git clone <your-repo-url>
   cd firstapp
   ```
2. Get dependencies:
   ```sh
   flutter pub get
   ```

### Running the App

- For Android/iOS:
  ```sh
  flutter run
  ```
- For Web:
  ```sh
  flutter run -d chrome
  ```
- For Desktop (Windows/Linux/macOS):
  ```sh
  flutter run -d <windows|linux|macos>
  ```

## Project Structure

- `lib/main.dart`: Entry point of the app.
- `lib/page/homepage.dart`: Main game UI.
- `lib/page/keyboard_view.dart`: On-screen keyboard widget.
- `lib/page/wordleview.dart`: Widget for displaying each letter.
- `lib/state/providee.dart`: Game state management.
- `lib/state/support.dart`: Popup dialogs for win/lose.
- `lib/state/wordle.dart`: Wordle letter model.

## How to Play

1. Use the on-screen keyboard to enter a 5-letter word.
2. Press "submit" to check your guess.
3. The board will show which letters are correct or incorrect.
4. You have 6 attempts to guess the word.
5. After the game ends, you can play again.

## License

This project is for educational purposes.
