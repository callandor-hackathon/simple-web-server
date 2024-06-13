#!/bin/bash

REPOSITORY=$1

# Load Bash Profile
source ~/.bashrc

# Navigate to Repository
cd $REPOSITORY

# Pull Changes from GitHub
git pull origin main

# Create Virtual Environment
python3 -m venv venv

# Activate Virtual Environment
source venv/bin/activate

# Install Requirements
pip install -r requirements.txt

# Terminate Existing Process
sudo pm2 stop all

# Run Application
sudo pm2 start main.py --interpreter venv/bin/python
# sudo pm2 "venv/bin/flask --app main.py run --host=0.0.0.0 --port=80"