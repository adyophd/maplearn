#!/bin/bash
# Usage: ./deploy.sh [staging|prod]

STAGING_SITE="5aed47ac-f35a-4249-92e4-e7aa2be1ba3c"
PROD_SITE="d097be82-9a5e-4260-8b05-42687b30434a"
# Set NETLIFY_TOKEN in your shell profile (e.g. ~/.zshrc):
#   export NETLIFY_TOKEN="nfp_..."
TOKEN="${NETLIFY_TOKEN:?NETLIFY_TOKEN is not set. Add it to your shell profile.}"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
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
cp "$SOURCE_DIR/index.html"         "$DEPLOY_DIR/index.html"
cp "$SOURCE_DIR/practice.html"      "$DEPLOY_DIR/practice.html"
cp "$SOURCE_DIR/challenge.html"     "$DEPLOY_DIR/challenge.html"
printf "/*\n  Content-Type: text/html; charset=UTF-8\n" > "$DEPLOY_DIR/_headers"
cd "$DEPLOY_DIR" && zip -q -r deploy.zip index.html practice.html challenge.html _headers

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
