#!/bin/sh

mv "$1" /app/main.c
clang -std=c99 /app/main.c -o /app/app
/app/app
