#!/bin/bash
set -e

echo "=== Checking if Jekyll builds locally ==="
echo "Installing gems..."
gem install bundler 2>/dev/null
bundle install 2>&1 | tail -20

echo -e "\n=== Building site ==="
bundle exec jekyll build 2>&1 | head -30

echo -e "\n=== Checking _site directory ==="
ls -la _site/ 2>&1 | head -15
echo -e "\n=== _site/index.html exists? ==="
ls -lh _site/index.html 2>&1 || echo "NOT FOUND"

echo -e "\n=== First 20 lines of index.html ==="
head -20 _site/index.html 2>&1 || echo "Cannot read"
