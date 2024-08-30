#!/bin/bash

echo "Installing dependencies..."
npm install

echo "Installing playwright browsers..."
npx -y playwright install --with-deps
