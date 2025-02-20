# Documentation Technique - Acroisie42 Token

## Fonctionnalités

### Version de Base (Acroisie42.sol)
- **Mint vers la trésorerie** : `mintTokensToTreasury(uint256 amount)` (accessible par le propriétaire).
- **Burn de tokens** : `burnTokens(address account, uint256 amount)`.
- **Transfert depuis la trésorerie** : `transferFromTreasury(address to, uint256 amount)`.
- **Consultation des soldes** : `myBalance()` et `treasuryBalance()`.

### Version Multisig (Acroisie42bonus.sol)
- **Proposer une transaction** : `proposeTransaction(address to, uint256 amount, TransactionType txType)`.
- **Approbation multisig** : `approveTransaction(uint256 txId)` — l'action (TRANSFER, MINT, ou BURN) s'exécute dès que le nombre d'approbations requis est atteint.
- **Consultation des soldes** : `myBalance()` et `treasuryBalance()`.

## Système Multisig
- **Objectif** : Sécuriser les opérations sensibles en exigeant plusieurs approbations.
- **Fonctionnement** :
  - Un signataire propose une transaction.
  - Les autres signataires approuvent via `approveTransaction`.
  - Une fois le seuil d'approbations atteint, l'opération est exécutée automatiquement.
- **Configuration** : Le nombre de signataires et le nombre d'approbations requises sont définis lors du déploiement.

## Déploiement
- **Pré-requis** : Configuration du réseau (ex. Sepolia) dans Hardhat ou Remix.
- **Procédure** : Utilisez les scripts dans le dossier `deployment` pour déployer le contrat.

## Sécurité et Optimisations
- **Validation des entrées** : Adresses valides, montants > 0.
- **Contrôle d'accès** : Ownable dans la version de base et multisig dans la version bonus.
- **Optimisations** : Usage de variables immuables et boucles optimisées pour réduire les frais de gaz.

