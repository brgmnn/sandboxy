#!/bin/sh

mv "$1" /app/App.java && javac /app/App.java && java App
