# User Stories — Booking System

Ce document detaille toutes les User Stories du projet **Booking System**, organisees par sprint.

---

## Personas

- **Client (Utilisateur Public)** : Souhaite reserver une ressource (salle, prestation, etc.) rapidement et simplement.
- **Administrateur** : Gere les ressources, les disponibilites et les reservations de son etablissement.

---

## Sprint 01 : Calendrier Public & Navigation

| ID | Persona | User Story | Priorite |
|:---|:---:|:---|:---:|
| **US.1.1** | Client | En tant que client, je veux visualiser les disponibilites sur un calendrier (mois/semaine/jour) afin de choisir une date qui me convient. | Haute |
| **US.1.2** | Client | En tant que client, je veux naviguer entre les periodes (mois suivant/precedent) et revenir a "Aujourd'hui" pour trouver facilement un creneau. | Haute |
| **US.1.3** | Client | En tant que client, je veux voir les creneaux horaires disponibles pour une ressource specifique afin d'eviter de tenter de reserver une heure deja prise. | Haute |

---

## Sprint 02 : Parcours de Reservation Client

| ID | Persona | User Story | Priorite |
|:---|:---:|:---|:---:|
| **US.2.1** | Client | En tant que client, je veux remplir un formulaire (nom, email, tel, notes) apres avoir choisi un creneau afin de finaliser ma reservation. | Haute |
| **US.2.2** | Client | En tant que client, je veux selectionner une ressource, une date de debut, une date de fin, une heure de debut et une heure de fin dans le formulaire de reservation. | Haute |
| **US.2.3** | Client | En tant que client, je veux recevoir un email de confirmation instantane avec les details de ma reservation pour etre sur qu'elle a bien ete enregistree. | Haute |
| **US.2.4** | Client | En tant que client, je veux pouvoir annuler ma reservation via un lien unique (token) recu par email si j'ai un empechement. | Haute |
| **US.2.5** | Client | En tant que client, je veux etre informe si le creneau choisi est deja pris (conflit 409) afin de choisir un autre horaire. | Haute |
| **US.2.6** | Client | En tant que client, je veux pouvoir cliquer sur un bouton "+ Nouvelle reservation" pour creer rapidement une reservation. | Haute |

---

## Sprint 03 : Dashboard Admin & Gestion des Ressources

| ID | Persona | User Story | Priorite |
|:---|:---:|:---|:---:|
| **US.3.1** | Admin | En tant qu'admin, je veux me connecter avec un identifiant et un mot de passe (JWT) pour acceder a l'interface de gestion securisee. | Haute |
| **US.3.2** | Admin | En tant qu'admin, je veux visualiser la liste de toutes les reservations avec des filtres (statut, ressource, periode, pagination) pour avoir une vue d'ensemble de mon planning. | Haute |
| **US.3.3** | Admin | En tant qu'admin, je veux pouvoir creer, modifier ou supprimer des ressources (nom, description, capacite, couleur) pour adapter le systeme a mon activite. | Haute |
| **US.3.4** | Admin | En tant qu'admin, je veux definir les plages horaires d'ouverture par defaut pour chaque ressource (jour de semaine, heure debut/fin, duree du creneau). | Haute |
| **US.3.5** | Admin | En tant qu'admin, je veux pouvoir creer, modifier et annuler une reservation manuellement depuis le dashboard. | Haute |
| **US.3.6** | Admin | En tant qu'admin, je veux acceder rapidement a la gestion des ressources via un bouton raccourci "Ressources". | Moyenne |

---

## Sprint 04 : Notifications & Indisponibilites

| ID | Persona | User Story | Priorite |
|:---|:---:|:---|:---:|
| **US.4.1** | Admin | En tant qu'admin, je veux bloquer manuellement des periodes (conges, travaux, fermeture) pour empecher toute reservation client sur ces creneaux. | Moyenne |
| **US.4.2** | Admin | En tant qu'admin, je veux gerer les blocs d'indisponibilite (creer, lister, supprimer) depuis une page dediee. | Moyenne |
| **US.4.3** | Admin | En tant qu'admin, je veux recevoir une notification par email a chaque nouvelle reservation client pour rester informe en temps reel. | Haute |
| **US.4.4** | Client | En tant que client, je veux recevoir un email de confirmation avec les details de ma reservation et un lien d'annulation. | Haute |

---

## Sprint 05 : Configuration & Integration

| ID | Persona | User Story | Priorite |
|:---|:---:|:---|:---:|
| **US.5.1** | Admin | En tant qu'admin, je veux personnaliser le nom de l'application, le logo (upload) et les couleurs depuis la page parametres. | Moyenne |
| **US.5.2** | Admin | En tant qu'admin, je veux configurer les parametres SMTP (hote, port, utilisateur, mot de passe, expediteur) directement depuis l'interface. | Moyenne |
| **US.5.3** | Admin | En tant qu'admin, je veux tester la configuration SMTP via un bouton "Test SMTP" pour verifier que les emails fonctionnent. | Moyenne |
| **US.5.4** | Admin | En tant qu'admin, je veux obtenir un code d'integration (iframe) pour afficher le calendrier de reservation sur mon site web existant. | Moyenne |
| **US.5.5** | Client | En tant que client, je veux recevoir un rappel par email 24h avant mon rendez-vous pour ne pas l'oublier. | Moyenne |
| **US.5.6** | Admin | En tant qu'admin, je veux que les rappels J-1 soient envoyes automatiquement chaque jour a 10h sans intervention manuelle (cron). | Moyenne |

---

## Sprint 06 : Calendrier Premium (Custom, 6 vues, Drag & Drop)

### 6.1 Nouvelles vues

| ID | Persona | User Story | Priorite |
|:---|:---:|:---|:---:|
| **US.6.1** | Client | En tant que client, je veux visualiser les reservations sur une vue Resource Timeline (axe horizontal = temps, une ligne par ressource) pour comparer les disponibilites. | Haute |
| **US.6.2** | Client | En tant que client, je veux visualiser les reservations sur une vue Resource DayGrid (une colonne par ressource, grille jour) pour voir toutes les ressources d'un coup. | Haute |
| **US.6.3** | Client | En tant que client, je veux visualiser les reservations sur une vue Resource TimeGrid (une colonne horaire par ressource) pour comparer les creneaux par ressource. | Haute |

### 6.2 Drag & Drop

| ID | Persona | User Story | Priorite |
|:---|:---:|:---|:---:|
| **US.6.4** | Client | En tant que client, je veux creer une reservation en cliquant-glissant sur des cellules vides du calendrier (drag-to-select) pour reserver rapidement. | Haute |
| **US.6.5** | Admin | En tant qu'admin, je veux deplacer un evenement en le glissant vers un autre horaire, jour ou ressource (drag-to-move) avec un element fantome (ghost). | Haute |
| **US.6.6** | Admin | En tant qu'admin, je veux etirer la duree d'un evenement en tirant son bord bas (drag-to-resize vertical) en vues semaine/jour. | Haute |
| **US.6.7** | Admin | En tant qu'admin, je veux etirer un evenement sur plusieurs jours en tirant son bord droit (drag-to-resize horizontal) en vue mois. | Haute |
| **US.6.8** | Client | En tant qu'utilisateur, je veux voir un element fantome (ghost) suivre mon curseur pendant le drag pour visualiser ou l'evenement sera place. | Haute |
| **US.6.9** | Client | En tant qu'utilisateur, je veux que le calendrier defile automatiquement quand je drag un evenement pres des bords de l'ecran (auto-scroll). | Moyenne |

### 6.3 Evenements avances

| ID | Persona | User Story | Priorite |
|:---|:---:|:---|:---:|
| **US.6.10** | Client | En tant que client, je veux voir les evenements multi-jours affiches avec des barres de continuation qui traversent les semaines. | Haute |
| **US.6.11** | Client | En tant que client, je veux que les evenements a la meme heure soient affiches cote a cote (overlap side-by-side) pour les distinguer. | Haute |
| **US.6.12** | Client | En tant que client, je veux voir un popover "+N more" quand il y a plus de 2 evenements par jour en vue mois, pour ne pas surcharger l'affichage. | Moyenne |
| **US.6.13** | Client | En tant que client, je veux que les evenements traversant minuit (overnight) soient correctement affiches sur le jour suivant. | Moyenne |
| **US.6.14** | Client | En tant que client, je veux voir les periodes d'indisponibilite affichees en zones hachees sur les vues semaine/jour pour les identifier clairement. | Moyenne |

### 6.4 Actions et UI

| ID | Persona | User Story | Priorite |
|:---|:---:|:---|:---:|
| **US.6.15** | Client | En tant qu'utilisateur, je veux cliquer sur l'icone Eye d'un evenement pour voir ses details dans une modale. | Haute |
| **US.6.16** | Admin | En tant qu'admin, je veux cliquer sur l'icone Pencil d'un evenement pour ouvrir le formulaire d'edition. | Haute |
| **US.6.17** | Admin | En tant qu'admin, je veux cliquer sur l'icone Trash d'un evenement pour le supprimer, avec une modale de confirmation personnalisee (pas de confirm natif). | Haute |
| **US.6.18** | Client | En tant que client, je veux que le calendrier defile automatiquement vers l'heure courante au chargement (scroll to now). | Moyenne |
| **US.6.19** | Client | En tant que client, je veux que la vue, la date et la ressource selectionnees soient persistees dans l'URL (?view=, ?date=, ?resource=) pour pouvoir partager un lien. | Moyenne |
| **US.6.20** | Admin | En tant qu'admin, je veux pouvoir imprimer le calendrier avec un rendu optimise (@media print). | Basse |

---

## Sprint 07 : Docker & Infrastructure

| ID | Persona | User Story | Priorite |
|:---|:---:|:---|:---:|
| **US.7.1** | Admin | En tant qu'admin, je veux demarrer toute l'application avec une seule commande `docker compose up` pour simplifier l'installation. | Haute |
| **US.7.2** | Admin | En tant qu'admin, je veux que la base de donnees PostgreSQL 16 soit provisionnee automatiquement via Docker avec volume persistant. | Haute |
| **US.7.3** | Admin | En tant qu'admin, je veux disposer de Mailpit (SMTP + Web UI) en developpement pour tester les emails sans serveur SMTP reel. | Moyenne |
| **US.7.4** | Admin | En tant qu'admin, je veux que le frontend soit servi par nginx Alpine en production pour des performances optimales. | Haute |
| **US.7.5** | Admin | En tant qu'admin, je veux disposer d'un Makefile avec toutes les commandes utilitaires (build, start, stop, seed, logs, etc.). | Moyenne |
| **US.7.6** | Admin | En tant qu'admin, je veux que le seed script charge des donnees de demonstration (28 reservations, 3 ressources, 1 bloc) pour tester rapidement. | Moyenne |
| **US.7.7** | Admin | En tant qu'admin, je veux que l'API demarre automatiquement apres que PostgreSQL soit healthy (depends_on + healthcheck). | Haute |
| **US.7.8** | Admin | En tant qu'admin, je veux que le seed s'execute automatiquement au premier demarrage sans ecraser les donnees existantes (--no-force). | Moyenne |

---

## Sprint 08 : Champs personnalisables & Scénarios métier

> **Objectif** : Permettre à chaque ressource d'avoir son propre formulaire de réservation avec des champs sur mesure. Un seul système, des dizaines de métiers.

### 8.1 Modèle de données

```
custom_fields:   id, resource_id, label, type, required, options (JSON), placeholder, sort_order
booking_values:  id, booking_id, field_id, value
```

Types de champs supportés : `text`, `textarea`, `number`, `select`, `date`, `email`, `tel`, `file`, `checkbox`

### 8.2 Administration des champs

| ID | Persona | User Story | Priorité |
|:---|:---:|:---|:---:|
| **US.8.1** | Admin | En tant qu'admin, je veux ajouter des champs personnalisés à une ressource (label, type, requis, options) pour adapter le formulaire à mon activité. | Haute |
| **US.8.2** | Admin | En tant qu'admin, je veux réorganiser l'ordre des champs personnalisés par glisser-déposer pour contrôler l'affichage du formulaire. | Moyenne |
| **US.8.3** | Admin | En tant qu'admin, je veux modifier ou supprimer un champ personnalisé existant. | Haute |
| **US.8.4** | Admin | En tant qu'admin, je veux définir des options prédéfinies pour les champs de type `select` (ex: "Coupe 30min 25€, Couleur 1h30 60€"). | Haute |
| **US.8.5** | Admin | En tant qu'admin, je veux qu'un champ de type `select` avec des prestations puisse auto-calculer la durée du créneau selon l'option choisie. | Haute |

### 8.3 Formulaire dynamique côté client

| ID | Persona | User Story | Priorité |
|:---|:---:|:---|:---:|
| **US.8.6** | Client | En tant que client, je veux que le formulaire de réservation affiche automatiquement les champs personnalisés de la ressource choisie. | Haute |
| **US.8.7** | Client | En tant que client, je veux que les champs requis soient validés avant la soumission. | Haute |
| **US.8.8** | Client | En tant que client, je veux pouvoir joindre un fichier (document, photo) si un champ `file` est configuré. | Moyenne |
| **US.8.9** | Admin | En tant qu'admin, je veux voir les valeurs des champs personnalisés dans la modale de détails (Eye) et dans le dashboard. | Haute |

### 8.4 Scénarios métier

#### Hôtel (Chambre Deluxe)

```
Champs personnalisés :
  - "Nombre d'adultes"    | type: number   | requis: oui | min: 1, max: 4
  - "Nombre d'enfants"    | type: number   | requis: non | min: 0, max: 3
  - "Petit-déjeuner"      | type: checkbox | requis: non
  - "Demandes spéciales"  | type: textarea | requis: non

Formulaire généré :
  ┌────────────────────────────────────┐
  │ Chambre Deluxe                     │
  │ [Date arrivée]    [Date départ]    │
  │ [Nb adultes: 2 ▼] [Nb enfants: 0] │
  │ [✓] Petit-déjeuner inclus         │
  │ [Demandes spéciales...         ]   │
  │ [Nom] [Email] [Téléphone]         │
  │         [Réserver]                 │
  └────────────────────────────────────┘
```

| ID | Persona | User Story | Priorité |
|:---|:---:|:---|:---:|
| **US.8.10** | Client | En tant que client d'hôtel, je veux sélectionner une date d'arrivée et une date de départ pour réserver plusieurs nuits. | Haute |
| **US.8.11** | Client | En tant que client d'hôtel, je veux indiquer le nombre d'adultes et d'enfants pour ma réservation. | Haute |
| **US.8.12** | Client | En tant que client d'hôtel, je veux cocher des options (petit-déjeuner, parking) lors de ma réservation. | Moyenne |

#### Coiffeur / Salon de beauté (Marie — Coloriste)

```
Champs personnalisés :
  - "Prestation"  | type: select | requis: oui
      Options :
        - "Coupe femme"    | durée: 30min | prix: 25€
        - "Couleur"        | durée: 1h30  | prix: 60€
        - "Mèches"         | durée: 2h    | prix: 80€
        - "Coupe + Couleur"| durée: 2h    | prix: 75€
  - "Notes"       | type: textarea | requis: non

Formulaire généré :
  ┌────────────────────────────────────┐
  │ Marie — Coloriste                  │
  │ [Prestation ▼ Coupe femme 25€   ]  │
  │   → Durée auto: 30 min            │
  │ [Date]  [Créneau disponible ▼]     │
  │ [Nom] [Email] [Téléphone]         │
  │ [Notes pour la coiffeuse...    ]   │
  │         [Réserver — 25€]           │
  └────────────────────────────────────┘
```

| ID | Persona | User Story | Priorité |
|:---|:---:|:---|:---:|
| **US.8.13** | Client | En tant que client coiffeur, je veux choisir une prestation dans une liste qui affiche le prix et la durée estimée. | Haute |
| **US.8.14** | Client | En tant que client coiffeur, je veux que la durée du créneau soit automatiquement ajustée selon la prestation choisie. | Haute |
| **US.8.15** | Client | En tant que client coiffeur, je veux voir le prix total avant de confirmer ma réservation. | Haute |

#### Médecin / Cabinet médical (Dr. Martin — Généraliste)

```
Champs personnalisés :
  - "Motif"             | type: select   | requis: oui
      Options : "Première visite", "Suivi", "Renouvellement ordonnance", "Urgence"
  - "Date de naissance"  | type: date     | requis: oui
  - "Numéro Sécu"        | type: text     | requis: non
  - "Documents"          | type: file     | requis: non
  - "Symptômes"          | type: textarea | requis: non

Formulaire généré :
  ┌────────────────────────────────────┐
  │ Dr. Martin — Généraliste           │
  │ [Motif ▼ Première visite        ]  │
  │ [Date] [Créneau ▼]                │
  │ [Nom] [Prénom] [Date naissance]    │
  │ [Email] [Téléphone]               │
  │ [N° Sécu]                          │
  │ [Symptômes à décrire...        ]   │
  │ [📎 Joindre un document]           │
  │         [Prendre rendez-vous]      │
  └────────────────────────────────────┘
```

| ID | Persona | User Story | Priorité |
|:---|:---:|:---|:---:|
| **US.8.16** | Client | En tant que patient, je veux indiquer le motif de consultation pour que le médecin prépare le rendez-vous. | Haute |
| **US.8.17** | Client | En tant que patient, je veux joindre des documents médicaux (ordonnance, résultats) à ma demande de rendez-vous. | Moyenne |
| **US.8.18** | Admin | En tant que médecin, je veux voir le motif et les documents joints dans la fiche de réservation. | Haute |

#### Salle de sport / Studio (Yoga du mardi 18h)

```
Champs personnalisés :
  - "Niveau"     | type: select   | requis: oui
      Options : "Débutant", "Intermédiaire", "Avancé"
  - "Tapis perso" | type: checkbox | requis: non

Formulaire généré :
  ┌────────────────────────────────────┐
  │ Yoga — Mardi 18h (8/12 places)    │
  │ [Niveau ▼ Débutant]               │
  │ [✓] J'apporte mon tapis           │
  │ [Nom] [Email]                      │
  │         [S'inscrire]               │
  └────────────────────────────────────┘
```

| ID | Persona | User Story | Priorité |
|:---|:---:|:---|:---:|
| **US.8.19** | Client | En tant que sportif, je veux voir le nombre de places restantes avant de m'inscrire à un cours. | Haute |
| **US.8.20** | Client | En tant que sportif, je veux que l'inscription soit refusée si le cours est complet. | Haute |
| **US.8.21** | Admin | En tant que gérant de salle, je veux définir une capacité maximale par ressource (cours). | Haute |

#### Espace de coworking (Bureau privé 4 places)

```
Champs personnalisés :
  - "Nombre de postes"  | type: number   | requis: oui | min: 1, max: 4
  - "Équipements"       | type: select   | requis: non | multiple
      Options : "Vidéoprojecteur", "Tableau blanc", "Visioconférence"
  - "Société"            | type: text     | requis: non

Formulaire généré :
  ┌────────────────────────────────────┐
  │ Bureau privé (4 places max)        │
  │ [Date début] [Heure début]         │
  │ [Date fin]   [Heure fin]           │
  │ [Nb postes: 2 ▼]                   │
  │ [Équipements ▼ Vidéoprojecteur ✓]  │
  │ [Société]                           │
  │ [Nom] [Email] [Téléphone]         │
  │         [Réserver]                 │
  └────────────────────────────────────┘
```

| ID | Persona | User Story | Priorité |
|:---|:---:|:---|:---:|
| **US.8.22** | Client | En tant que freelance, je veux réserver un espace pour une demi-journée ou journée entière avec les équipements nécessaires. | Haute |
| **US.8.23** | Admin | En tant que gérant coworking, je veux voir quels équipements ont été demandés pour préparer la salle. | Moyenne |

### 8.5 Récapitulatif Sprint 08

| Sous-section | Nombre US |
|---|---|
| Administration des champs | 5 |
| Formulaire dynamique | 4 |
| Scénario Hôtel | 3 |
| Scénario Coiffeur | 3 |
| Scénario Médecin | 3 |
| Scénario Salle de sport | 3 |
| Scénario Coworking | 2 |
| **Total Sprint 08** | **23** |

---

## Recapitulatif

| Sprint | Nom | Nombre US | Points |
|---|---|---|---|
| Sprint 01 | Calendrier public | 3 | 7 |
| Sprint 02 | Booking flow client | 6 | 8 |
| Sprint 03 | Dashboard admin | 6 | 8 |
| Sprint 04 | Notifications & indisponibilités | 4 | 6 |
| Sprint 05 | Configuration & intégration | 6 | 5 |
| Sprint 06 | Calendrier premium (drag & drop) | 20 | 13 |
| Sprint 07 | Docker & infrastructure | 8 | 5 |
| Sprint 08 | Champs personnalisables & scénarios métier | 23 | 15 |
| **Total** | | **76** | **67** |

### Métiers couverts

| Métier | Champs clés | Spécificités |
|---|---|---|
| Hôtel | Nb adultes/enfants, options | Réservation multi-nuits |
| Coiffeur | Prestation (durée + prix auto) | Calcul durée automatique |
| Médecin | Motif, documents, date naissance | Upload fichiers |
| Salle de sport | Niveau, capacité | Places limitées |
| Coworking | Nb postes, équipements | Multi-sélection |
| Consultant | Sujet, durée souhaitée | Flexible |
| Restaurant | Nb personnes, allergies | Capacité table |
| Photographe | Type (mariage, portrait), lieu | Champs libres |
