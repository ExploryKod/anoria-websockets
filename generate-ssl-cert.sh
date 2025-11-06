#!/bin/bash

# Script pour générer un certificat SSL auto-signé pour Traefik
# Usage: ./generate-ssl-cert.sh

CERT_DIR="./certs"
CERT_FILE="$CERT_DIR/cert.pem"
KEY_FILE="$CERT_DIR/key.pem"

echo "🔐 Génération du certificat SSL auto-signé..."

# Créer le dossier si nécessaire
mkdir -p "$CERT_DIR"

# Générer le certificat auto-signé (valide 365 jours)
# Inclure localhost pour les tests locaux ET l'IP du VPS pour la production
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$KEY_FILE" \
  -out "$CERT_FILE" \
  -subj "/C=FR/ST=State/L=City/O=Anoria/CN=localhost" \
  -addext "subjectAltName=IP:194.164.76.63,DNS:194.164.76.63,DNS:localhost,IP:127.0.0.1"

# Définir les permissions
chmod 600 "$KEY_FILE"
chmod 644 "$CERT_FILE"

echo "✅ Certificat généré :"
echo "   - Certificat: $CERT_FILE"
echo "   - Clé privée: $KEY_FILE"
echo ""
echo "⚠️  Note: C'est un certificat auto-signé. Les navigateurs afficheront un avertissement de sécurité."
echo "   Pour la production, utilisez un domaine avec Let's Encrypt."

