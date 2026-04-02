#!/bin/bash
# Usage: ./deploy.sh [staging|prod]

STAGING_SITE="5aed47ac-f35a-4249-92e4-e7aa2be1ba3c"
PROD_SITE="d097be82-9a5e-4260-8b05-42687b30434a"
TOKEN="nfp_KrfYaCry4fKo3FUcBwJ9nD1hjbJAMCsu7bbb"
SOURCE="/Users/adamyoung/Documents/Claude/Geo/france_cities.html"
DEPLOY_DIR="/tmp/netlify-deploy"

TARGET=${1:-staging}

if [ "$TARGET" = "prod" ]; then
  SITE_ID=$PROD_SITE
  LABEL="PRODUCTION (atlasquest.io)"
elif [ "$TARGET" = "staging" ]; then
  SITE_ID=$STAGING_SITE
  LABEL="STAGING (staging.atlasquest.io)"
else
  echo "Usage: ./deploy.sh [staging|prod]"
  exit 1
fi

echo "Deploying to $LABEL..."

mkdir -p "$DEPLOY_DIR"
cp "$SOURCE" "$DEPLOY_DIR/index.html"
printf "/*\n  Content-Type: text/html; charset=UTF-8\n" > "$DEPLOY_DIR/_headers"
cd "$DEPLOY_DIR" && zip -q -r deploy.zip index.html _headers

RESULT=$(curl -s -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/zip" \
  --data-binary @deploy.zip \
  "https://api.netlify.com/api/v1/sites/$SITE_ID/deploys")

STATE=$(echo "$RESULT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('state','error'))")

if [ "$STATE" = "uploaded" ] || [ "$STATE" = "ready" ]; then
  echo "Done. Deployed to $LABEL"
else
  echo "Something went wrong. Response: $RESULT"
  exit 1
fi
