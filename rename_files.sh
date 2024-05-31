#!/bin/bash

# Si un argument est passé, l'utiliser comme répertoire, sinon utiliser le répertoire courant
DIRECTORY=${1:-$(pwd)}

# Vérifie si le répertoire existe
if [ ! -d "$DIRECTORY" ]; then
  echo "Le répertoire $DIRECTORY n'existe pas."
  exit 1
fi

# Aller dans le répertoire
cd "$DIRECTORY"

# Liste les fichiers, les trie par extension et les renomme
declare -A COUNTERS

for FILE in *; do
  if [ -f "$FILE" ]; then
    EXTENSION="${FILE##*.}"
    # Augmenter le compteur pour cette extension
    COUNTERS[$EXTENSION]=$((COUNTERS[$EXTENSION]+1))
    # Formater le nouveau nom
    NEW_NAME="${COUNTERS[$EXTENSION]}.$EXTENSION"
    # Renommer le fichier
    mv -n "$FILE" "$NEW_NAME"
    echo "Renommé: $FILE -> $NEW_NAME"
  fi
done
