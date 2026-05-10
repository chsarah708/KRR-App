#!/bin/bash
set -e

# Install dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Install gunicorn for production
pip install gunicorn

# Collect static files (if needed)
echo "Build completed successfully!"