#!/bin/bash

REPOSITORY=$1

# Navigate to Repository
cd $REPOSITORY

# Pull Changes from GitHub
git fetch --all
git reset --hard origin/main

# Create Virtual Environment
python3 -m venv venv

# Activate Virtual Environment
source venv/bin/activate

# Install Requirements
pip install -r requirements.txt

# Run Application
pm2 restart ecosystem.config.js