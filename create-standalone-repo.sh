#!/bin/bash

# Script pour créer un repository standalone du serveur WebSocket
# Usage: ./create-standalone-repo.sh /chemin/vers/nouveau-repo

set -e

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$1"

if [ -z "$TARGET_DIR" ]; then
    echo "❌ Erreur: Veuillez spécifier le chemin du nouveau repository"
    echo "Usage: $0 /chemin/vers/nouveau-repo"
    exit 1
fi

echo "🚀 Création du repository standalone..."
echo "Source: $SOURCE_DIR"
echo "Destination: $TARGET_DIR"
echo ""

# Créer le répertoire de destination
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# Fichiers à copier
FILES=(
    "websocket-server.js"
    "rooms-server.js"
    "package.json"
    "package-lock.json"
    "Dockerfile"
    "docker-compose.yml"
    ".dockerignore"
    ".gitignore"
    "ecosystem.config.js"
    "test-websocket.html"
    "test-server.js"
    "README.md"
    "README_STANDALONE.md"
    "README_DOCKER.md"
    "README_TEST.md"
)

echo "📋 Copie des fichiers..."
for file in "${FILES[@]}"; do
    if [ -f "$SOURCE_DIR/$file" ]; then
        cp "$SOURCE_DIR/$file" "$TARGET_DIR/"
        echo "  ✅ $file"
    else
        echo "  ⚠️  $file (non trouvé, ignoré)"
    fi
done

# Créer le dossier logs
mkdir -p logs
touch logs/.gitkeep
echo "  ✅ logs/.gitkeep"

# Initialiser Git si pas déjà fait
if [ ! -d ".git" ]; then
    echo ""
    echo "📦 Initialisation Git..."
    git init
    echo "  ✅ Repository Git initialisé"
fi

# Créer .gitignore si nécessaire
if [ ! -f ".gitignore" ]; then
    cat > .gitignore << EOF
/node_modules
/logs
*.log
.env
.DS_Store
EOF
    echo "  ✅ .gitignore créé"
fi

echo ""
echo "✅ Repository standalone créé avec succès!"
echo ""
echo "📝 Prochaines étapes:"
echo "  1. cd $TARGET_DIR"
echo "  2. npm install"
echo "  3. npm start  (pour tester)"
echo "  4. git add ."
echo "  5. git commit -m 'Initial commit: Serveur WebSocket Anoria standalone'"
echo ""
echo "🐳 Pour Docker:"
echo "  docker compose up -d"
echo ""

