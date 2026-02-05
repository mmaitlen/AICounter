# AICounter

A simple Flutter counter application that demonstrates basic increment/decrement functionality with customizable step values, utilizing the `bloc` and `flutter_bloc` packages for state management.

## Functionality

The application provides the following features:

*   **Counter Display:** Shows the current value of the counter.
*   **Increment/Decrement:** Buttons to increase and decrease the counter's value.
*   **Custom Step Value:** A slide-in menu (drawer) allows the user to define a custom step amount by which the counter increments or decrements.
*   **State Management with BLoC:** The application uses the `bloc` and `flutter_bloc` packages to manage the application's state in a predictable and testable way, following the MVVM architecture principles.

## Target Platforms

This application is built to run on:

*   Android
*   iOS
*   Web
*   macOS

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK installed.
*   A configured IDE (VS Code, Android Studio, etc.) with Flutter and Dart plugins.

### Installation

1.  Clone the repository:
    ```bash
    git clone <repository_url>
    cd aicounter
    ```
2.  Install dependencies:
    ```bash
    flutter pub get
    ```

### Running the Application

To run the application on a connected device or emulator (or browser), use the following command. Replace `<device>` with your target device ID (e.g., `chrome`, `emulator-5554`, `macos`).

```bash
flutter run -d <device>
```

For example, to run on Chrome:

```bash
flutter run -d chrome
```

## Project Structure (Clean Architecture - Post-Refactor)

*(Note: This section describes the project structure after an initial refactoring to a Clean Architecture pattern, which is recorded in `SPECIFICATION.md`)*

The project follows a Clean Architecture approach to ensure separation of concerns, testability, and maintainability:

*   **`lib/core`**: Contains core functionalities and cross-cutting concerns (e.g., dependency injection setup, common error handling).
*   **`lib/features/counter`**: Dedicated module for the counter functionality, further divided into:
    *   **`data`**:
        *   `datasources`: Implementations for retrieving and storing data (e.g., `CounterLocalDataSource`).
        *   `repositories`: Implementations of domain repository interfaces.
    *   **`domain`**:
        *   `entities`: Core business objects (`Counter`).
        *   `repositories`: Abstract definitions of data contracts (`CounterRepository`).
        *   `usecases`: Business logic operations (`IncrementCounter`, `DecrementCounter`, `GetCounter`).
    *   **`presentation`**:
        *   `bloc`: UI-specific state management using the `bloc` package.
        *   `pages`: UI screens (`CounterPage`).
        *   `widgets`: Reusable UI components.

## Testing

Widget tests are provided to ensure the core functionality of the counter, including incrementing, decrementing, and changing the step value.

To run the tests:

```bash
flutter test
```