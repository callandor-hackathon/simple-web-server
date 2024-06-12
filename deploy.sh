
REPOSITORY=$1

# Navigate to Repository
cd $REPOSITORY

# Pull Changes from GitHub
git pull origin main

# Activate Virtual Environment
python3 -m venv venv

source venv/bin/activate

# Install Requirements
pip install -r requirements.txt

# Terminate Existing Process
pkill -f main.py

# Run Application
nohup python main.py
