#!/bin/bash

# Docker Stack Control Script
# Manage individual services in the docker-compose stack

set -e

COMPOSE_FILE="docker-compose.yml"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Available services
SERVICES=("mysql" "postgres" "redis" "rabbitmq" "mongodb" "elasticsearch")

# Function to print usage
usage() {
    echo "Usage: $0 <command> [service]"
    echo ""
    echo "Commands:"
    echo "  start [service]    - Start a specific service or all services"
    echo "  stop [service]     - Stop a specific service or all services"
    echo "  restart [service]  - Restart a specific service or all services"
    echo "  status [service]   - Show status of a specific service or all services"
    echo "  logs [service]     - Show logs of a specific service"
    echo "  list               - List all available services"
    echo ""
    echo "Examples:"
    echo "  $0 start mysql"
    echo "  $0 stop postgres"
    echo "  $0 logs redis"
    echo "  $0 status"
}

# Function to check if service exists
service_exists() {
    local service=$1
    for s in "${SERVICES[@]}"; do
        if [ "$s" == "$service" ]; then
            return 0
        fi
    done
    return 1
}

# Function to execute docker-compose command
execute_compose() {
    local cmd=$1
    local service=$2
    
    cd "$SCRIPT_DIR"
    
    if [ -z "$service" ]; then
        docker-compose -f "$COMPOSE_FILE" $cmd
    else
        if service_exists "$service"; then
            docker-compose -f "$COMPOSE_FILE" $cmd "$service"
        else
            echo -e "${RED}Error: Service '$service' not found!${NC}"
            echo "Available services: ${SERVICES[*]}"
            exit 1
        fi
    fi
}

# Main script logic
if [ $# -eq 0 ]; then
    usage
    exit 1
fi

COMMAND=$1
SERVICE=$2

case $COMMAND in
    start)
        echo -e "${GREEN}Starting${NC} ${SERVICE:-all services}..."
        execute_compose "up -d" "$SERVICE"
        echo -e "${GREEN}✓ Started successfully${NC}"
        ;;
    stop)
        echo -e "${YELLOW}Stopping${NC} ${SERVICE:-all services}..."
        execute_compose "stop" "$SERVICE"
        echo -e "${GREEN}✓ Stopped successfully${NC}"
        ;;
    restart)
        echo -e "${BLUE}Restarting${NC} ${SERVICE:-all services}..."
        execute_compose "restart" "$SERVICE"
        echo -e "${GREEN}✓ Restarted successfully${NC}"
        ;;
    status)
        echo -e "${BLUE}Status of${NC} ${SERVICE:-all services}:"
        execute_compose "ps" "$SERVICE"
        ;;
    logs)
        if [ -z "$SERVICE" ]; then
            echo -e "${RED}Error: Please specify a service for logs${NC}"
            echo "Usage: $0 logs <service>"
            exit 1
        fi
        execute_compose "logs -f" "$SERVICE"
        ;;
    list)
        echo -e "${BLUE}Available services:${NC}"
        for service in "${SERVICES[@]}"; do
            echo "  - $service"
        done
        ;;
    *)
        echo -e "${RED}Unknown command: $COMMAND${NC}"
        usage
        exit 1
        ;;
esac

