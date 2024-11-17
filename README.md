# purple_planet_packaging

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

## Run before running the application
```flutter pub run build_runner build ```




Here's a possible addition to the README file:

**Known Issues**

* When a user is not logged in, their cart data is not saved locally or on the server.
* Loading a new product for a category clears the cart.


# Added to the settings.json
hide all generated files from the view
```  
"files.exclude": {
"**/*.freezed.dart": true,
"**/*.g.dart": true
    },

```



A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
