# rick_morty_character

    Flutter version : 3.38.8
    Dart version : 3.10.7

    Table of Contents
        Project Structure
        Setup Instructions
        State Management
        Storage Approach
        Known Limitations
        Project Structure

    The project follows a Clean Architecture pattern:

        lib/
        ├── core/                  # Constants, network utilities, themes, and error handling
        ├── data/                  # Data sources (remote/local), models, repository implementations
        ├── domain/                # Entities, repository contracts, and use cases
        ├── presentation/          # UI layer: controllers, pages, bindings
        └── main.dart              # App entry point

    Key points:

           1. Controllers manage state using GetX and communicate with repositories.
           2. Bindings handle dependency injection for pages.
           3. Hive is used for local storage (e.g., favorites).
           4. Remote data source fetches character data from the Rick & Morty API.

    Setup Instructions
           Clone the repository
               git clone https://github.com/Nazmul2957/rick_morty_character.git
               
           Install dependencies
               flutter pub get
           Generate Hive type adapters
               flutter packages pub run build_runner build --delete-conflicting-outputs
           Run the app
               flutter run
           Optional: Build release APK
               flutter build apk --release

    State Management

       GetX is used for state management.

    Reasoning:
       *     Lightweight and reactive, suitable for small to medium apps.
       *     Eliminates boilerplate compared to other solutions like Provider or Bloc.
       *     Simplifies dependency injection via Bindings.

    Usage:
       * Controllers (CharacterController, FavouritesController) manage reactive variables using .obs.
       * Pages use Obx widgets to reactively update UI when data changes.


    Storage Approach

    Hive is used for local storage:

    Reasoning:
      * Fast, lightweight key-value database for Flutter.
      * Works offline and supports storing custom objects via type adapters.
    Usage:
        *  Favorites are stored in a Hive box (CharacterHiveModel).
        *   Data persists across app launches.
    Initialization:
       await Hive.initFlutter();
       Hive.registerAdapter(CharacterHiveModelAdapter());
       await Hive.openBox<CharacterHiveModel>('favorites');
