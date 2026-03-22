# pokedex


## About
The app allows users to load, view and favourite pokemons.

## Tech Stack

### Core Framework

- **Flutter 3.41.4**
- **Dart 3.11.1**

## State Management & Architecture

- **BLoC**
- **equatable**

### Authenetication

- **Firebase Auth**

### Data and Storage

- **Dio**: Http client
- **Hive**: Local storage
- **catched_network_imaege**: for image chaching

## Navigation and Routing

- **go_router**

## Architecture 

1. **Presentation Layer (Views)**
    - UI
    - BLoc 

2. **Business Logic Layer (BLoCs)**
   - `AuthBloc`
   - `HomeBloc`
   - `ThemeBloc`
   - `PokemonDetailsBloc`
   - `FavouriteBloc`

3. **Services Later**

   - `AuthService`
   - `ApiService`
   - `LocalStorageService`

4. **Data layer **
   
   - Hive: Local storage and caching
   - PokeAPI: Remote datashourse


## Getting Started

### Prerequisites

- **Flutter SDK** 3.42.1 or higher
- **Dart SDK**: 3.11.1
- **Android SDK** install Android Studio
- **Xcode**: For IOS testing
- **Firebase Project**: Firebase project that has email/password authentication enabled

### Installation Steps

1. **Clone repository**

2. **Install Dependencies**
```bash 
flutter pub get
```
3. **Configure Firebase**

   **Use FlutterFire CLI (Recommended)**
   ```bash
   flutter pub global activate flutterfire_cli
   flutterfire configure
   ```
4. **Run the App**

  **For Android**
  ```bash
  flutter run android
  ```

  **For IOS**
  ```bash
  flutter run ios
  ```

  **For web**
  ```bash
  flutter run web
  ```

  **Happy Coding!!**

  link to screen recording video: https://drive.google.com/file/d/1rHxJ6LNkFT3lgXWKcNZ0g-KO87zUv_MM/view?usp=sharing






