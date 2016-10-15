#!/bin/sh

clang -std=c99 "$1" -o /app/app
/app/app
