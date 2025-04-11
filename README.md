# Euro Caps – From Beans to Bytes

Dit repository bevat de technische implementatie van het project "From Beans to Bytes", uitgevoerd bij Euro Caps. In dit project is een volledige databaseoplossing ontwikkeld rondom het productieproces van koffiecapsules, inclusief procesmodellering, datainvoer, analyse en kwaliteitsverbetering met behulp van Six Sigma.

## Inhoud van de repository

### /DATA
Bevat representatieve testdata in .csv-formaat voor alle entiteiten binnen het datamodel, zoals producten, partners, leveringen en kwaliteitsregistraties.

### /sql
Bevat:
- `EuroCapsDB_ALL_TABLES.sql`: SQL-script voor het aanmaken van alle tabellen in MySQL.
- `EuroCaps_KPI_Operationele_SQL.sql`: SQL-queries voor het ophalen van KPI’s, zoals NOK-producten, voorraadniveaus en leverbetrouwbaarheid.

### /PYTHON
Bevat het script `import_all_csv_to_mysql.py` voor het automatisch inlezen van .csv-bestanden en het vullen van de database in MySQL Workbench.

### /ERD
Bevat de conceptuele en fysieke ERD-diagrammen (Entity Relationship Diagrams) die de datastructuur van het systeem weergeven. Bestanden zijn opgenomen in .png- of .drawio-formaat.

## Doel van het project

Het doel van dit project was om bedrijfsprocessen te analyseren en optimaliseren door:
- Het modelleren van een relationele database
- Het automatiseren van data-invoer
- Het uitvoeren van SQL-analyses voor operationele en strategische inzichten
- Het toepassen van een kwaliteitsmanagementmethode (Six Sigma)

## Technieken & Tools

- MySQL Workbench
- Python 3.11 (pandas, mysql-connector)
- Draw.io (voor ERD en swimlanes)
- Git & GitHub (versiebeheer en projectstructuur)

## Auteur

Dit project is opgesteld als onderdeel van de opleiding in samenwerking met Euro Caps.
Voor vragen of toelichting over de gebruikte scripts of structuur, neem contact op via GitHub of het eindverslag.
