# E-Sports Ticketing
Theme: League of Legends — Worlds 2025 (E-Sports ticketing)
Database: MySQL

## Repository structure
- /modélisation
  - billeterie.puml          # PlantUML source for ER diagram
- /sql
  - billeterie.sql          # SQL schema + data inserts (MySQL)
- /docs
  - tableau_synthese.md     # Example 'tableau de synthèse' (projects ↔ compétences)
- README.md                 # This file

## How to use
1. Clone the repository (or download files).
2. Import `sql/billeterie.sql` into a MySQL database (e.g., `mysql -u root -p < billeterie.sql`).
3. Open `modélisation/billeterie.puml` in a PlantUML editor to view the ER diagram.

## Notes
- This package contains a complete schema and generated realistic sample data:
  - ~10 events, ~50 clients, ~100 tickets

