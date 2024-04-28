# 🗨️  Anonymous Group Chat

Anonymous Group Chat - app for chatting with people without knowing the identities.

##  Description

The App is a simple flutter app with a custom backend for authentication and chatting service with websockets.

### Installation

- Install Flutter. [Documentation](https://docs.flutter.dev/get-started/install)

- Install [Dart Frog](https://pub.dev/packages/dart_frog)

- Get the depedencies for the app. Open terminal in the root of your project and run:

    ```bash
        flutter pub get
    ```

- Get the depedencies for the api. Open terminal in the folder `api` and run:

    ```bash
        dart pub get
    ```

- Add `.env` file within `api` folder and fill your data:

    ```bash
        PROJECT_ID=anonymous-chat-hackathon
        SECRET_KEY=USE_YOUR_KEY
    ```
    
- Add folder `env` inside folder `api/lib` and create there a file `env.dart` with such code:

    ```bash
        import 'package:envied/envied.dart';

        part 'env.g.dart';

        @Envied()
        abstract class Env {
            @EnviedField()
            static String PROJECT_ID = _Env.PROJECT_ID;

            @EnviedField()
            static String SECRET_KEY = _Env.SECRET_KEY;
        }
    ```

- Generate all enviroment variables. In the terminal of the folder `api` run:

    ```bash
        dart run build_runner build

- Start the server. In the terminal of the folder `api` run:

    ```bash
        dart_frog dev
    ```

- Run the app on Android emulator with combination `fn` + `F5`. Or open terminal in the root of your project and start the app:

    ```bash
        flutter run
    ```

#### License
[MIT](https://choosealicense.com/licenses/mit/)
