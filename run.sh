#!/bin/bash
set -e

echo "=== Setting up Metro Map ==="

# Build frontend if not already built
if [ ! -d "static" ]; then
    echo "Building frontend..."
    cd frontend
    npm install
    npm run build
    cd ..
    mv frontend/dist static
    echo "Frontend built!"
fi

# Install backend dependencies
echo "Installing backend dependencies..."
cd backend
if [ ! -d ".venv" ]; then
    python -m venv .venv
fi
source .venv/bin/activate
python -m pip install -e .

# Run the backend
echo "Starting server on port 8080..."
exec uvicorn app.main:app --host 0.0.0.0 --port 8080
