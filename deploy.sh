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

# Load Bash Profile
source ~/.bashrc

# Terminate Existing Process
pm2 stop all

# Run Application
pm2 start main.py --interpreter venv/bin/python
# pm2 "venv/bin/flask --app main.py run --host=0.0.0.0 --port=80"