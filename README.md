# Student Grade Tracker App

## Overview

Student Grade Tracker is a Flutter application that allows students to manage their academic subjects, enter marks, calculate grades automatically, and view an overall performance summary. The application is built using Flutter and Provider for state management, following a clean and organized project structure.

---

## Features

* Add new subjects with marks
* Automatic grade calculation
* View a list of all subjects
* Display result summary
* Light and Dark theme support
* Responsive user interface
* Provider state management

---

## Project Structure

```text
student_grade_tracker/
├── pubspec.yaml
├── README.md
└── lib/
    ├── main.dart
    ├── subject.dart
    ├── subject_provider.dart
    ├── theme_provider.dart
    ├── navigation_provider.dart
    ├── add_subject_screen.dart
    ├── subject_list_screen.dart
    └── summary_screen.dart
```

---

## Technologies Used

* Flutter
* Dart
* Provider
* Material Design

---

## Grade Calculation

|    Marks | Grade |
| -------: | :---: |
| 80 - 100 |   A   |
|  65 - 79 |   B   |
|  50 - 64 |   C   |
| Below 50 |   F   |


## How to Run

### Clone the repository

```bash
git clone https://github.com/your-sumaiya-akter-runa/student_grade_tracker.git
```

### Navigate to the project directory

```bash
cd student_grade_tracker
```

### Install dependencies

```bash
flutter pub get
```

### Run the application

```bash
flutter run
```

---

## Screens

* Subject List Screen
* Add Subject Screen
* Result Summary Screen

---

## Future Improvements

* Edit subject information
* Delete subjects
* Store data using Hive or SQLite
* Search and filter subjects
* Export result as PDF
* Cloud synchronization


