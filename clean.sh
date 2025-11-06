#!/bin/bash
echo "Hard reset --- Wiping all chain data..."
#rm -rf data config vc .env
docker-compose down -v
echo "Done."
