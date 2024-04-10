#!/bin/bash

echo "Installing dependencies..."
npm install

echo "Installing playwright browsers..."
npx -y playwright install --with-deps

echo "Start application, so it is available in port 8000"
npm start
