# BOOKING SYSTEM — Cahier des Charges Technique

**Systeme de reservation multi-ressources — Vue.js 3 + Node.js/Express + PostgreSQL**

| | |
|---|---|
| **Produit** | Booking System |
| **Stack** | Vue.js 3 + Pinia + Tailwind v4 / Node.js + Express + PostgreSQL |
| **Auteur** | Denis — AmazScript (contact@amazscript.com) |
| **Version** | V1.1 — Avril 2026 |
| **Prix cible** | $69 — ByteSproutLab & CodeCanyon |
| **Statut** | Developpe — Sprints 01 a 10 termines |

> **Proposition de valeur** : Un systeme de reservation cle en main, installable en 10 minutes via Docker, sans commission par reservation, avec calendrier 100% custom (pas de FullCalendar), personnalisable aux couleurs du client, vendu en one-shot a $69.

---

## 1. Contexte et Objectifs

### 1.1 Probleme

Les hotels, salons de coiffure, cabinets medicaux, salles de sport et prestataires de services independants ont besoin d'un systeme de reservation simple, integrable a leur site existant, sans dependre d'une plateforme tierce (Calendly, Doctolib) qui preleve des commissions.

### 1.2 Solution

Booking System est une application fullstack autonome : frontend Vue.js 3 avec calendrier 100% custom + API REST Node.js/Express + PostgreSQL. Elle s'installe via Docker en une commande (`docker compose up`) et gere les ressources (salles, praticiens, equipements), les creneaux horaires, les reservations clients, les indisponibilites et les notifications email.

### 1.3 Cibles

- Hotels et maisons d'hotes — reservation de chambres et services
- Salons de coiffure et instituts de beaute — creneaux par praticien
- Cabinets medicaux et paramedicaux — prise de rendez-vous
- Salles de sport et studios — reservation de cours et equipements
- Prestataires independants — consultants, coaches, formateurs

### 1.4 Perimetre V1.0

- Frontend Vue.js 3 avec calendrier custom (6 vues), drag & drop complet
- API REST Node.js / Express avec PostgreSQL
- Gestion multi-ressources (salles, praticiens, equipements)
- Calendrier : vues Mois, Semaine, Jour, Resource Timeline, Resource DayGrid, Resource TimeGrid
- Reservation en ligne avec formulaire client + detection de conflits
- Dashboard admin : gestion des reservations, ressources, creneaux, indisponibilites
- Notifications email SMTP (confirmation, notification admin, rappel J-1)
- Page parametres (nom, logo, couleurs, SMTP, widget iframe)
- Infrastructure Docker complete (PostgreSQL, Mailpit, API, Frontend nginx)
- 13 langues (EN, FR, DE, ES, IT, PT, NL, PL, RU, AR, JA, ZH, TR)
- 19 types de champs personnalises dynamiques (texte, fichier/image, adresse, video, etc.)
- Upload fichiers vers MinIO (S3-compatible) avec preview et controles de taille
- Design responsive mobile-first (hamburger menu, bottom sheet, swipe, tap-to-create)
- Support tactile tablette (drag & drop touch)
- **Hors perimetre V1.1** : paiement en ligne, application mobile native

---

## 2. Fonctionnalites

### 2.1 Vue d'ensemble

| Module | Fonctionnalite | Sprint |
|---|---|---|
| Calendrier | Vue mois / semaine / jour des disponibilites | Sprint 01 |
| Calendrier | Navigation entre periodes, bouton Aujourd'hui | Sprint 01 |
| Calendrier | Vues Resource Timeline, Resource DayGrid, Resource TimeGrid | Sprint 06 |
| Calendrier | Drag-to-select (creer reservation par selection de cellules vides) | Sprint 06 |
| Calendrier | Drag-to-move (deplacer evenements entre heures/jours/ressources avec ghost element) | Sprint 06 |
| Calendrier | Drag-to-resize vertical (etirer duree en vues semaine/jour) | Sprint 06 |
| Calendrier | Drag-to-resize horizontal (etirer sur plusieurs jours en vue mois) | Sprint 06 |
| Calendrier | Evenements multi-jours avec barres de continuation inter-semaines | Sprint 06 |
| Calendrier | Overlap side-by-side quand meme heure | Sprint 06 |
| Calendrier | Popover "+N more" quand >2 evenements/jour (vue mois) | Sprint 06 |
| Calendrier | Evenements overnight (traversee de minuit, affichage jour suivant) | Sprint 06 |
| Calendrier | Zones hachees pour blocs/indisponibilites (vues semaine/jour) | Sprint 06 |
| Calendrier | Auto-scroll vers l'heure courante au chargement | Sprint 06 |
| Calendrier | Persistance URL params (?view=, ?date=, ?resource=) | Sprint 06 |
| Calendrier | Optimisation impression (@media print) | Sprint 06 |
| Reservation | Formulaire de reservation client (nom, email, tel, notes) | Sprint 02 |
| Reservation | Selection ressource + creneau + confirmation | Sprint 02 |
| Reservation | Annulation par lien unique (token email) | Sprint 02 |
| Reservation | Detection de conflits (erreur 409 si chevauchement) | Sprint 02 |
| Reservation | Bouton "+ Nouvelle reservation" | Sprint 02 |
| Admin | Dashboard avec liste reservations + filtres | Sprint 03 |
| Admin | CRUD ressources (nom, description, capacite, couleur) | Sprint 03 |
| Admin | Gestion des creneaux horaires par ressource | Sprint 03 |
| Admin | Bouton raccourci "Ressources" | Sprint 03 |
| Admin | Gestion des blocs/indisponibilites | Sprint 04 |
| Notifications | Email confirmation client (SMTP) | Sprint 04 |
| Notifications | Email notification admin a chaque reservation | Sprint 04 |
| Notifications | Email rappel J-1 automatique (cron quotidien 10h) | Sprint 05 |
| Config | Page parametres : nom, logo upload, couleurs, SMTP | Sprint 05 |
| Config | Test SMTP depuis l'interface | Sprint 05 |
| Config | Widget embarquable (code iframe) | Sprint 05 |
| UI | Actions evenement : Eye (details modal), Pencil (edit), Trash (suppression) | Sprint 06 |
| UI | Composant EventActions reutilisable | Sprint 06 |
| UI | Ghost element suivant le curseur pendant le drag | Sprint 06 |
| UI | Modal de confirmation personnalisee (pas de confirm/alert natif) | Sprint 06 |
| UI | Auto-scroll quand drag pres des bords de l'ecran | Sprint 06 |
| Infra | Docker Compose : PostgreSQL 16, Mailpit, API, Frontend nginx | Sprint 07 |
| Infra | Makefile avec toutes les commandes | Sprint 07 |
| Infra | Seed script avec donnees de demo (28 bookings, 3 ressources, 1 bloc) | Sprint 07 |
| i18n | Support 13 langues (EN, FR, DE, ES, IT, PT, NL, PL, RU, AR, JA, ZH, TR) | Sprint 08 |
| Custom Fields | 19 types de champs personnalises dynamiques par ressource | Sprint 08 |
| Upload | Upload fichiers/images vers MinIO avec preview et controles taille | Sprint 08 |
| Responsive | Design mobile-first : hamburger menu, bottom sheet, tap-to-create | Sprint 09 |
| Responsive | Swipe navigation, vues adaptees mobile, touch drag tablette | Sprint 09 |
| Blocks | Edition des blocs (PUT), affichage hachures dans toutes les vues | Sprint 10 |
| Blocks | Support blocs multi-jours avec clipping par jour | Sprint 10 |
| Admin | Pagination API (bookings, blocks, resources) avec persistance URL | Sprint 11 |
| Admin | Recherche ressources par nom (iLike) | Sprint 11 |
| Admin | Bouton Restore (retablir reservation annulee) | Sprint 11 |
| Admin | Suppression permanente reservation (booking + values + fichiers MinIO) | Sprint 11 |

### 2.2 Parcours client (booking flow)

1. Le client accede au calendrier public
2. Il selectionne une ressource (ou la ressource est unique)
3. Il choisit une date puis un creneau disponible (ou drag-to-select sur le calendrier)
4. Il remplit le formulaire : nom, email, telephone, notes optionnelles
5. Le systeme verifie les conflits (409 si chevauchement sur la meme ressource)
6. Il recoit un email de confirmation avec lien d'annulation (token unique)
7. L'admin recoit une notification email
8. La veille du rendez-vous, le client recoit un rappel automatique (cron 10h)

### 2.3 Parcours administrateur

1. L'admin se connecte via login/mot de passe (JWT 24h)
2. Il visualise le dashboard : reservations avec filtres (statut, ressource, periode)
3. Il gere les ressources : creation, modification, suppression (CRUD complet)
4. Il definit les creneaux horaires par ressource (jour de semaine, heure debut/fin, duree)
5. Il bloque des periodes (conges, fermeture) via la gestion des blocs
6. Il peut creer/modifier/annuler une reservation manuellement
7. Il personnalise l'application (nom, logo, couleurs, SMTP)
8. Il genere un code iframe pour integrer le calendrier sur un site existant

---

## 3. Stack Technique

### 3.1 Frontend

| Technologie | Version | Role |
|---|---|---|
| Vue.js | 3.4+ | Framework UI, Composition API |
| Pinia | 2.x | State management |
| Vue Router | 4.x | Navigation SPA, routes protegees (meta requiresAuth) |
| Axios | 1.x | Client HTTP pour appels API REST |
| Tailwind CSS | v4 | Styles utilitaires, responsive |
| Vite | 5.x | Build tool, serveur de developpement |

> **Calendrier 100% custom** : Aucune dependance a FullCalendar ou librairie tierce. Le composant calendrier est entierement developpe sur mesure, licence MIT, avec 6 vues et drag & drop complet.

### 3.2 Backend (Node.js / Express / PostgreSQL)

| Technologie | Version | Role |
|---|---|---|
| Node.js | 20 LTS | Runtime JavaScript backend |
| Express | 4.x | Framework API REST |
| PostgreSQL | 16 | Base de donnees relationnelle |
| Sequelize | 6.x | ORM (modeles, migrations, associations) |
| pg / pg-hstore | 8.x / 2.x | Driver PostgreSQL pour Sequelize |
| JWT (jsonwebtoken) | 9.x | Authentification admin sans session (expiration 24h) |
| bcryptjs | 2.x | Hashage des mots de passe |
| Nodemailer | 6.x | Envoi emails SMTP (confirmation, rappels, notifications) |
| node-cron | 3.x | Taches planifiees (rappel J-1 a 10h quotidien) |
| uuid | 10.x | Generation de tokens d'annulation UUID v4 |

### 3.3 Infrastructure Docker

| Service | Image | Port | Role |
|---|---|---|---|
| PostgreSQL | postgres:16-alpine | 5433:5432 | Base de donnees |
| Mailpit | axllent/mailpit:latest | 1025 (SMTP) / 8025 (Web UI) | SMTP de dev + interface web |
| API | Node.js 20 Alpine (custom) | 3000:3000 | Backend REST |
| Frontend | nginx Alpine (custom) | 5173:80 | Serveur frontend SPA |

### 3.4 Tests

| Outil | Role |
|---|---|
| Jest | 29.x | Tests unitaires backend |
| Supertest | 7.x | Tests HTTP des endpoints API |

---

## 4. Endpoints API REST

### 4.1 Endpoints Publics (sans authentification)

| Methode | Endpoint | Description |
|---|---|---|
| GET | `/api/resources` | Liste des ressources actives |
| GET | `/api/resources/:id/slots?date=` | Creneaux disponibles par ressource et date |
| GET | `/api/resources/bookings/public?date_from=&date_to=` | Reservations publiques (sans donnees client) |
| GET | `/api/resources/blocks/public?date_from=&date_to=` | Blocs/indisponibilites publics |
| POST | `/api/bookings` | Creer une reservation (formulaire client) |
| DELETE | `/api/bookings/:token` | Annuler via lien unique (token email) |
| POST | `/api/auth/login` | Login admin, retourne JWT |
| GET | `/api/settings/public` | Parametres publics (nom, logo, couleurs) |
| POST | `/api/upload` | Upload fichier (image, PDF, doc) vers MinIO |
| GET | `/api/resources/:id/fields` | Champs personnalises d'une ressource |
| GET | `/api/geocode?q=` | Geocodage adresse (LocationIQ / Nominatim) |
| GET | `/api/health` | Health check |

### 4.2 Endpoints Admin (JWT requis)

| Methode | Endpoint | Description |
|---|---|---|
| GET | `/api/admin/bookings` | Liste reservations avec filtres (statut, ressource, periode, pagination) |
| POST | `/api/admin/bookings` | Creer reservation manuellement |
| PUT | `/api/admin/bookings/:id` | Modifier une reservation |
| DELETE | `/api/admin/bookings/:id` | Annuler une reservation (soft delete) |
| DELETE | `/api/admin/bookings/:id/permanent` | Supprimer definitivement une reservation |
| GET | `/api/admin/resources` | Liste des ressources |
| POST | `/api/admin/resources` | Creer une ressource |
| PUT | `/api/admin/resources/:id` | Modifier une ressource |
| DELETE | `/api/admin/resources/:id` | Supprimer une ressource |
| POST | `/api/admin/slots` | Definir creneaux horaires par ressource |
| GET | `/api/admin/blocks` | Liste des blocs/indisponibilites |
| POST | `/api/admin/blocks` | Creer un bloc (conges, fermeture) |
| PUT | `/api/admin/blocks/:id` | Modifier un bloc |
| DELETE | `/api/admin/blocks/:id` | Supprimer un bloc |
| GET | `/api/admin/booking-values/:id` | Valeurs champs personnalises d'une reservation |
| GET | `/api/admin/custom-fields` | Liste des champs personnalises |
| POST | `/api/admin/custom-fields` | Creer un champ personnalise |
| PUT | `/api/admin/custom-fields/:id` | Modifier un champ personnalise |
| DELETE | `/api/admin/custom-fields/:id` | Supprimer un champ personnalise |
| PUT | `/api/admin/custom-fields/reorder` | Reordonner les champs (drag & drop) |
| GET | `/api/admin/settings` | Lire tous les parametres |
| PUT | `/api/admin/settings` | Modifier les parametres (SMTP, logo, couleurs) |
| POST | `/api/admin/settings/test-smtp` | Tester la configuration SMTP |
| POST | `/api/admin/settings/upload-logo` | Uploader un logo |

---

## 5. Modele de Donnees

### 5.1 Tables

| Table | Champs | Description |
|---|---|---|
| `bookings` | id, resource_id, client_name, email, phone, start_at, end_at, token, status, notes, color, reminder_sent, created_at, updated_at | Reservations clients |
| `resources` | id, name, description, capacity, color, active, created_at, updated_at | Ressources reservables |
| `slots` | id, resource_id, day_of_week, start_time, end_time, duration_min, created_at, updated_at | Creneaux horaires recurrents par jour de semaine |
| `blocks` | id, resource_id, start_at, end_at, reason, created_at, updated_at | Periodes bloquees (conges, fermeture) |
| `users` | id, email, password_hash, role, created_at, updated_at | Administrateurs |
| `settings` | id, key, value, created_at, updated_at | Parametres cle-valeur (SMTP, logo, couleurs, etc.) |
| `custom_fields` | id, resource_id, label, type, required, validate_value, placeholder, options, sort_order, created_at, updated_at | Definitions des champs personnalises par ressource |
| `booking_values` | id, booking_id, field_id, value, created_at, updated_at | Valeurs soumises des champs personnalises par reservation |

### 5.2 Detail du modele Booking

| Champ | Type | Contrainte | Description |
|---|---|---|---|
| id | INTEGER | PK, auto-increment | Identifiant unique |
| resource_id | INTEGER | NOT NULL | FK vers resources |
| client_name | STRING | NOT NULL | Nom du client |
| email | STRING | NOT NULL | Email du client |
| phone | STRING | default '' | Telephone du client |
| start_at | DATE | NOT NULL | Date/heure debut |
| end_at | DATE | NOT NULL | Date/heure fin |
| token | STRING | NOT NULL, unique | Token UUID v4 pour annulation |
| status | STRING | default 'confirmed' | Statut : confirmed, cancelled |
| notes | TEXT | default '' | Notes libres |
| color | STRING | default '' | Couleur personnalisee de l'evenement |
| reminder_sent | BOOLEAN | default false | Rappel J-1 envoye |

### 5.3 Detail du modele Resource

| Champ | Type | Contrainte | Description |
|---|---|---|---|
| id | INTEGER | PK, auto-increment | Identifiant unique |
| name | STRING | NOT NULL | Nom de la ressource |
| description | TEXT | default '' | Description |
| capacity | INTEGER | default 1 | Capacite |
| color | STRING | default '#3B82F6' | Couleur d'affichage |
| active | BOOLEAN | default true | Ressource active/inactive |

### 5.4 Detail du modele Slot

| Champ | Type | Contrainte | Description |
|---|---|---|---|
| id | INTEGER | PK, auto-increment | Identifiant unique |
| resource_id | INTEGER | NOT NULL | FK vers resources |
| day_of_week | INTEGER | NOT NULL | 0=dimanche, 1=lundi ... 6=samedi |
| start_time | STRING | NOT NULL | Heure debut (ex: "09:00") |
| end_time | STRING | NOT NULL | Heure fin (ex: "18:00") |
| duration_min | INTEGER | default 60 | Duree du creneau en minutes |

### 5.5 Detail du modele Block

| Champ | Type | Contrainte | Description |
|---|---|---|---|
| id | INTEGER | PK, auto-increment | Identifiant unique |
| resource_id | INTEGER | NOT NULL | FK vers resources |
| start_at | DATE | NOT NULL | Date/heure debut du blocage |
| end_at | DATE | NOT NULL | Date/heure fin du blocage |
| reason | STRING | default '' | Motif (conges, travaux, etc.) |

---

## 6. Routes Frontend

| Route | Composant | Auth | Description |
|---|---|---|---|
| `/` | BookingCalendar | Non | Calendrier public de reservation |
| `/cancel/:token` | CancelBooking | Non | Page d'annulation par token |
| `/login` | AdminLogin | Non | Page de connexion admin |
| `/admin` | AdminDashboard | JWT | Dashboard admin (reservations + filtres) |
| `/admin/resources` | AdminResources | JWT | Gestion CRUD des ressources + creneaux |
| `/admin/blocks` | AdminBlocks | JWT | Gestion des indisponibilites |
| `/admin/settings` | AdminSettings | JWT | Parametres (nom, logo, couleurs, SMTP, iframe) |
| `/embed` | BookingCalendar | Non | Version embarquable (iframe) |

---

## 7. Fonctionnalites Calendrier Custom (detail)

### 7.1 Les 6 vues

| Vue | Description |
|---|---|
| Month | Grille mensuelle avec evenements, multi-jours, "+N more" popover |
| Week | 7 colonnes horaires, overlap side-by-side, zones hachees blocs |
| Day | 1 colonne horaire, meme comportement que Week |
| Resource Timeline | Timeline horizontale par ressource (axe X = temps) |
| Resource DayGrid | Grille jour par ressource (1 colonne par ressource) |
| Resource TimeGrid | Grille horaire par ressource (1 colonne par ressource) |

### 7.2 Interactions Drag & Drop

| Interaction | Description |
|---|---|
| Drag-to-select | Cliquer-glisser sur cellules vides pour creer une reservation |
| Drag-to-move | Deplacer un evenement vers un autre horaire/jour/ressource (ghost element) |
| Drag-to-resize vertical | Etirer la duree d'un evenement en semaine/jour (bord bas) |
| Drag-to-resize horizontal | Etirer un evenement sur plusieurs jours en vue mois |
| Ghost element | Element fantome suivant le curseur pendant le drag |
| Auto-scroll | Defilement automatique quand le curseur approche des bords de l'ecran |

### 7.3 Fonctionnalites avancees

| Fonctionnalite | Description |
|---|---|
| Multi-day events | Barres de continuation qui traversent les semaines |
| Overlap side-by-side | Evenements a la meme heure affiches cote a cote |
| Popover "+N more" | Quand >2 evenements par jour en vue mois |
| Overnight events | Evenements traversant minuit affiches sur le jour suivant |
| Zones hachees | Blocs/indisponibilites affiches en hachures (semaine/jour) |
| Scroll to now | Defilement automatique vers l'heure courante au chargement |
| URL params | Persistance de la vue, date et ressource dans l'URL (?view=, ?date=, ?resource=) |
| Print | Optimisation pour l'impression (@media print) |
| Conflict detection | Erreur 409 si reservation chevauche un evenement existant sur la meme ressource |

---

## 8. Emails et Notifications

| Email | Declencheur | Contenu |
|---|---|---|
| Confirmation client | Apres creation reservation | Details reservation + lien d'annulation (token) |
| Notification admin | Apres creation reservation | Details reservation + infos client |
| Rappel J-1 | Cron quotidien a 10h | Rappel 24h avant le rendez-vous au client |

- **Transport** : Nodemailer avec SMTP configurable depuis l'interface admin
- **Dev** : Mailpit (port 1025 SMTP, port 8025 Web UI)
- **Flag reminder_sent** : empeche l'envoi de doublons

---

## 9. Decoupage en Sprints

| Sprint | Nom | Contenu | Points |
|---|---|---|---|
| Sprint 01 | Calendrier public | Vues mois/semaine/jour, navigation, affichage creneaux disponibles | 7 |
| Sprint 02 | Booking flow client | Formulaire reservation, validation, confirmation, annulation par token, detection conflits (409) | 8 |
| Sprint 03 | Dashboard admin | Auth JWT, liste reservations + filtres, CRUD ressources, gestion creneaux, bouton raccourci Ressources | 8 |
| Sprint 04 | Notifications & blocage | Emails SMTP confirmation client + notification admin, gestion des blocs/indisponibilites | 6 |
| Sprint 05 | Config & widget | Page parametres (nom, logo, couleurs, SMTP, test SMTP), widget iframe, rappel J-1 (cron) | 5 |
| Sprint 06 | Calendrier premium | 3 vues ressource supplementaires, drag-to-select/move/resize, ghost element, auto-scroll, multi-day events, overlap, "+N more", overnight, zones hachees, EventActions (eye/pencil/trash), modal confirmation, persistance URL, print, scroll to now | 13 |
| Sprint 07 | Docker & infrastructure | docker-compose.yml (PostgreSQL 16, Mailpit, API, Frontend nginx), Makefile, migration SQLite vers PostgreSQL, seed script (28 bookings, 3 ressources, 1 bloc) | 5 |
| Sprint 08 | Custom Fields, i18n & Upload | 13 langues, 19 types de champs personnalises, upload MinIO avec preview/resize, affichage valeurs dans modal detail (image, video, adresse, couleur, multi-select, checkbox traduit), seed-demo.js (6 resources, 31 champs, 25 bookings), validation multi-select JSON, detection URL images, messages erreur upload traduits, nginx upload 10MB | 10 |
| Sprint 09 | Responsive Design | Breakpoints reactifs (isMobile/isTablet), toolbar select dropdown mobile, vues filtrees mobile (Mois+Jour), auto-switch semaine→jour, noms jours 1 lettre, vue mois mobile (dots + bottom sheet), tap-to-create, tap-to-view, EventActions masques mobile, swipe navigation, touch drag tablette, formulaires/modals responsive, hamburger menu, admin pages responsive | 8 |
| Sprint 10 | Blocks & corrections | PUT blocks (edition), timezone fix blocks, blocs multi-jours avec clipping, hachures dans toutes les vues (mois, semaine, jour, timeline, resourceTimeGrid, resourceDayGrid), annulation drag timeline hors zone, EventActions agrandis, timeline pills centres | 5 |
| Sprint 11 | Pagination & admin | Pagination API (bookings, blocks, resources) avec persistance URL, recherche ressources, bouton Restore/Retablir, suppression permanente booking (cascade values + fichiers MinIO), filtre ressource dans blocks | 5 |

**Total** : 80 story points

---

## 10. Structure du Projet

```
booking/
├── frontend/                    # Vue.js 3 + Pinia + Tailwind v4
│   ├── src/
│   │   ├── views/               # BookingCalendar, AdminDashboard, AdminResources,
│   │   │                        # AdminBlocks, AdminSettings, AdminLogin, CancelBooking
│   │   ├── components/          # Calendrier custom, BookingForm, EventActions, modals
│   │   ├── stores/              # bookings.js, resources.js, auth.js, settings.js
│   │   ├── router/              # index.js (8 routes, guard requiresAuth)
│   │   └── config.js            # URL API, parametres
│   ├── Dockerfile               # Build + nginx Alpine
│   └── vite.config.js
├── api/                         # Node.js 20 + Express + PostgreSQL
│   ├── routes/                  # bookings.js, resources.js, admin.js, auth.js, settings.js
│   ├── models/                  # Booking, Resource, Slot, Block, User, Setting (Sequelize)
│   ├── middleware/              # auth.js (JWT verification)
│   ├── services/                # emailService.js (Nodemailer)
│   ├── config/                  # database.js (PostgreSQL via Sequelize)
│   ├── seed.js                  # Donnees de demo
│   ├── server.js                # Point d'entree
│   ├── Dockerfile               # Node.js 20 Alpine
│   └── package.json
├── docker-compose.yml           # 4 services : postgres, mailpit, api, frontend
├── Makefile                     # Commandes utilitaires
├── cdc-booking-system.md        # Ce document
└── user-stories.md              # User stories par sprint
```

---

## 11. Criteres de Qualite

| Critere | Exigence |
|---|---|
| Performance | Chargement initial < 2s, calendrier < 500ms |
| Responsive | Fonctionnel sur mobile, tablette, desktop |
| Compatibilite | Chrome, Firefox, Safari, Edge (2 dernieres versions) |
| Securite | JWT expiration 24h, tokens annulation UUID v4, bcrypt pour mots de passe, inputs sanitises |
| Installation | Operationnel en moins de 10 minutes via Docker |
| Calendrier | 100% custom, aucune dependance tierce (pas de FullCalendar), licence MIT |
| Detection conflits | POST et PUT retournent 409 si chevauchement sur la meme ressource |
| Emails | SMTP configurable, Mailpit en dev, rappel J-1 via cron |

---

## 12. Roadmap

### 12.1 V1.0 — MVP (termine — Mars 2026)

- Calendrier public custom 6 vues, drag & drop complet, booking flow, dashboard admin, notifications email, Docker

### 12.2 V1.1 — Custom Fields, i18n & Responsive (termine — Avril 2026)

- 13 langues, 19 types de champs personnalises, upload MinIO, design responsive mobile-first, support tactile tablette, hachures blocs dans toutes les vues

### 12.3 V1.5 — Paiement

- Integration Stripe (paiement a la reservation ou acompte)
- Gestion des remboursements en cas d'annulation

### 12.4 V2.0 — Multi-tenant SaaS

- Portage en SaaS : plusieurs etablissements, abonnement mensuel
- Sous-domaines par etablissement, branding personnalise
- Application mobile Vue Native ou Capacitor
