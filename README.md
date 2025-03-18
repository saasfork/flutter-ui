# ClickPay

ClickPay est une solution de paiement pour applications SaaS.

## Prérequis

- Node.js (version 14 ou supérieure)
- Un compte Firebase avec un projet créé

## Installation

1. Clonez le dépôt
```bash
git clone <url-du-repo>
cd clickpay
```

2. Installez les dépendances
```bash
npm install
```

## Configuration

### Configuration Firebase

1. Créez un fichier `.firebaserc` à la racine du projet avec le contenu suivant:

```json
{
  "projects": {
    "default": "ID_PROJECT"
  }
}
```

Remplacez `ID_PROJECT` par l'ID de votre projet Firebase.

2. Configurez les variables d'environnement en créant un fichier `.env` dans le dossier `app/assets/` selon le modèle `.env.example`

```
FIREBASE_API_KEY=STRING
FIREBASE_AUTH_DOMAIN=STRING
FIREBASE_PROJECT_ID=STRING
FIREBASE_STORAGE_BUCKET=STRING
FIREBASE_MESSAGING_SENDER_ID=STRING
FIREBASE_APP_ID=STRING
```