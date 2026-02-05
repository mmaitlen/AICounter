# Application Specification: AICounter

This document outlines the specification for a Flutter application called "AICounter". The purpose of this document is to provide a clear set of requirements and development steps so that another AI agent can recreate the project.

## 1. Requirements

### 1.1. App Name

AICounter

### 1.2. Description

A simple counter application that demonstrates the use of the `bloc` and `flutter_bloc` packages for state management.

### 1.3. Core Functionality

*   Increment a counter.
*   Decrement a counter.
*   Allow the user to specify the increment/decrement step amount.

### 1.4. State Management

*   Use the `bloc` and `flutter_bloc` packages for state management, following a MVVM architecture.

### 1.5. User Interface

*   A simple, clean interface with a centered counter display.
*   Two floating action buttons for incrementing and decrementing the counter.
*   A slide-in menu (drawer) to contain the "step" input field.
*   An app bar with a title and a menu icon to open the drawer.

### 1.6. Target Platforms

*   Android
*   iOS
*   Web
*   macOS

### 1.7. Version Control

*   Use a local Git repository to track changes.

## 2. Development Steps

### 2.1. Project Setup

1.  **Initialize Git:**
    ```bash
    git init
    ```
2.  **Create Flutter Project:**
    ```bash
    flutter create --platforms=android,ios,web,macos .
    ```
3.  **Add Dependencies:**
    ```bash
    flutter pub add bloc flutter_bloc
    ```

### 2.2. Initial Implementation

1.  **Replace `lib/main.dart` with the initial UI:**
    *   The initial UI should contain a counter display and two floating action buttons for increment and decrement.
    *   Use the `bloc` and `flutter_bloc` packages to manage the counter state.

2.  **Commit the initial version:**
    ```bash
    git add .
    git commit -m "Initial commit"
    ```

### 2.3. Add "Step" Feature

1.  **Add a `TextField`:**
    *   Add a `TextField` to the UI to allow the user to input the step amount.
    *   Update the `CounterBloc` to handle the step value.
    *   Update the increment and decrement logic to use the step value.

2.  **Commit the "step" feature:**
    ```bash
    git commit -m "feat: Add step text field"
    ```

### 2.4. Move "Step" Field to Drawer

1.  **Add a `Drawer`:**
    *   Add a `Drawer` to the `Scaffold`.
    *   Move the "step" `TextField` into the `Drawer`.
    *   Add a menu icon to the `AppBar` to open the drawer.

2.  **Commit the drawer feature:**
    ```bash
    git commit -m "feat: Move step field to slide-in menu"
    ```

### 2.5. Add Widget Tests

1.  **Create a test file:**
    *   Create `test/widget_test.dart`.
2.  **Write widget tests:**
    *   Write tests for the increment, decrement, and step change functionality.
    *   Use the `flutter_test` and `bloc_test` packages.

3.  **Commit the tests:**
    ```bash
    git commit -m "test: Add widget tests"
    ```
