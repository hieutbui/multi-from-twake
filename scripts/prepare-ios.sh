#!/usr/bin/env bash
flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
flutter pub get
# Use alternate beautifier
brew install xcbeautify
cd ios
pod install && pod update
