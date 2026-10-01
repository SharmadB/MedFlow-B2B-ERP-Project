#!/bin/bash

PROJECT_DIR="$HOME/edublitz-b2b-medical-erp"

echo "🚀 Starting Edublitz Medical ERP services..."

start_service() {
    SERVICE=$1
    PORT=$2

    if lsof -i:$PORT >/dev/null 2>&1; then
        echo "✅ $SERVICE already running on port $PORT"
        return
    fi

    echo "▶ Starting $SERVICE on port $PORT..."

    cd "$PROJECT_DIR/$SERVICE" || exit 1

    export $(grep -v '^#' .env | xargs)

    nohup mvn spring-boot:run > "$PROJECT_DIR/$SERVICE.log" 2>&1 &

    echo "   Started $SERVICE"
}

start_service "user-service" 8081
start_service "product-service" 8082
start_service "order-service" 8083

echo ""
echo "⏳ Services are starting..."
echo "Use the following to check health:"
echo ""
echo "curl http://localhost:8081/api/v1/actuator/health"
echo "curl http://localhost:8082/api/v1/actuator/health"
echo "curl http://localhost:8083/api/v1/actuator/health"
