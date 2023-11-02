# Overlay Menu

The widget is designed to enhance navigation on Flutter application by providing a distinctive top and bottom menu overlay.

This widget proves particularly beneficial when developing a viewer that demands minimal interaction, with the menu remaining hidden until explicitly requested. Additionally, it is designed to automatically fade away if the user remains inactive for a period of time.

Ths widget can be used with any content viewer let it be image / text or even other interactive content.

## Features

# Content
Enable either or both top and bottom menu.  All the interaction is through MenuItem, which is an icon with optional label. 

### Scroll Response
When the content is scrolled up or swiped upwards, the menu disappears. Conversely, when scrolled down, it reappears.

### Auto-Hide
set the parameter timeout to enable auto-hide with given duration specificied by timeout. if timeout == Duration.zero, auto hide is disabled. In this scenario, you may add a button to manually close.

### Add the package to your `pubspec.yaml` file

```bash
flutter pub add overlay_menu
```

### Add riverpod

This package uses Riverpod to manage state.

```bash
flutter pub add flutter_riverpod
```

As required by riverpod, wrap the entire application in a "ProviderScope" widget.

```dart
  void main() {
    runApp(
      ProviderScope(
        child: MyApp(),
      ),
    );
  }
```

### Use the widget

```dart
import 'package:overlay_menu/overlay_menu.dart';
```

Use the Widget

```dart
    OverlayMenu(
          topMenuItems: [
            MenuItem("Begin", Icons.arrow_upward, onTap: () {}),
            MenuItem("End", Icons.arrow_downward, onTap: () {}),
          ],
          topMenuItemSpecialLeft: MenuItem("Back", Icons.arrow_upward,
              onTap: () {}, showLabel: false),
          bottomMenuItems: [
            MenuItem("Home", Icons.home, onTap: () {}),
            MenuItem("Settings", Icons.settings, onTap: () {}),
            MenuItem("Style", Icons.style, onTap: () {})
          ],
          timeout: const Duration(seconds: 3),
          child: <Your widget>
        ),
```

## Usage

* Refer the provided example. 
* Don't add more items that won't fit into the given area. Recommended to use upto 5 Menu Items in top and bottom each. Lesser is better.

## Support

If you face any issues or have any enhancement suggestions, create an [issue on GitHub](https://github.com/cloudonlanapps/overlay_menu/issues) or contact me at cloudonlanapps (at) gmail (dot) com.

You may also send your pull request if you want to contribute.
