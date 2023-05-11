# geteat

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## localisation 
https://medium.com/@fernnandoptr/how-to-get-users-current-location-address-in-flutter-geolocator-geocoding-be563ad6f66a#:~:text=To%20query%20the%20current%20location,%3BPosition%20position%20%3D%20await%20Geolocator.

# release the android version
**link** : https://docs.flutter.dev/deployment/android
## Change icons
```
flutter pub run flutter_launchers_icons
```
## Change app name
```
flutter pub global run rename --bundleId app.get-eat.get-eat
flutter pub global run rename --appname Geteat
```

## Signing the app
create a new file in the android folder named key.properties
write in the this file:
```
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=upload
storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks or C:\\Users\\<user name>\\upload-keystore.jks>
```
**Add this file in the .gitignore**

## Create a new keystore
```
keytool -genkey -v -keystore %userprofile%\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
Put the generated file in android/app folder \
Change the `storeFile` property by `../app/upload-keystore.jks` \
**Add this file in the .gitignore**

## configure signing in gradle
https://docs.flutter.dev/deployment/android#configure-signing-in-gradle \
Commands:
```
flutter clean
flutter build appbundle
```




