#! /bin/bash

source ~/.bash_profile

flutter clean

flutter pub get

flutter pub run build_runner watch --delete-conflicting-outputs