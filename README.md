# image_in_text

A new Flutter package that creates image in text effect. 

## Getting Started
In the pubspec.yaml of your flutter project, add the following dependency:
```
dependencies:
  ...
  image_in_text: "1.0.0"
```
In your library add the following import:
```
import 'package:image_in_text/image_in_text.dart';';
```
Initialize the library with a TTF file:
```
    await init("assets/Roboto-Regular.ttf", isAsset: true);
```
#### Note: If you are calling `init` from `main`, remember to add this line before calling `init`:
```
WidgetsFlutterBinding.ensureInitialized();
```
Now You can just use the widget `ImageInText`:
```dart
    Center(
      child: ImageInText(
        text: "LAZY",
        boxFit: BoxFit.contain,
        image:  AssetImage(
            "assets/bg.jpg"
        ),
      ),
    ),
```

And it would look something like this:
![Screenshot](screenshot.png)