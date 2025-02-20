# README.md

## Acroisie42 Token

### Introduction
Ce projet implémente un token ERC20 nommé **Acroisie42**. Deux versions sont disponibles :
- **Acroisie42.sol** : Version de base avec gestion via Ownable.
- **Acroisie42bonus.sol** : Version avancée intégrant un système multisignature (multisig) pour sécuriser les transferts depuis la trésorerie.

### Arborescence du dépôt
- **README.md** : Présentation du projet.
- **code/** : Contrats Solidity.
- **documentation/** : Documentation technique et instructions de déploiement.
- **deployment/** : Scripts et outils pour déployer le token sur Sepolia.

### Déploiement
#### 1. Cloner le dépôt
```bash
git clone <URL_DU_DEPOT>
```
#### 2. Installer les dépendances (ex. Hardhat)
```bash
npm install
```
#### 3. Déployer le contrat
```bash
npx hardhat run scripts/deploy.js --network sepolia
```

### Remarques
- Le nom du token contient bien "42" (Acroisie42 ou Acroisie42b).
- Aucune information sensible (clé API, mot de passe) n'est incluse dans ce dépôt.
- La documentation et les scripts de déploiement sont fournis pour faciliter l'utilisation sur Sepolia.