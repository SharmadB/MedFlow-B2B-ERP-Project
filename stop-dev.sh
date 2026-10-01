#!/bin/bash

echo "🛑 Stopping Edublitz Medical ERP services..."

for PORT in 8081 8082 8083
do
    PID=$(lsof -ti:$PORT)

    if [ -n "$PID" ]; then
        echo "Stopping process on port $PORT..."
        kill $PID
    else
        echo "Nothing running on port $PORT"
    fi
done

echo "✅ Services stopped."
