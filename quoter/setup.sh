#! /bin/bash

source ~/.bash_profile

flutter clean

flutter pub get

flutter pub run build_runner build --delete-conflicting-outputs

if [ "$1" = true ]; then
  flutter run
fi