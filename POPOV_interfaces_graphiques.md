# Étude technique : choix d’un framework d’interface graphique pour un projet de billetterie Java  
**Auteur : POPOV**  
**Projet : Application de billetterie (Java SE)**  

---

## 1. Contexte et but de l’étude

Le projet de billetterie nécessite une interface utilisateur claire et fluide, capable de gérer les réservations, paiements et affichages dynamiques.  
Plusieurs bibliothèques Java permettent de concevoir des interfaces graphiques, mais leurs philosophies et usages varient fortement.  

L’objectif de cette étude est de **comparer plusieurs frameworks** pour déterminer :
- un outil **professionnel et maintenable à long terme**,  
- un outil **léger et rapide à déployer** pour un prototype local.

---

## 2. Démarche d’évaluation

Chaque framework a été testé via un petit prototype (affichage d’une fenêtre, ajout de composants, gestion d’événements).  
Plutôt qu’un simple barème chiffré, chaque solution a été analysée selon **six axes qualitatifs** notés sur **3 niveaux** :  
- 🟩 Excellent  
- 🟨 Moyen  
- 🟥 Faible  

---

## 3. Axes d’évaluation

| Axe | Description |
|------|--------------|
| **Environnement & installation** | Difficulté d’installation, compatibilité avec Maven/Gradle et IDE (IntelliJ, Eclipse). |
| **Expérience de développement** | Clarté du code, outillage, ergonomie du développement. |
| **Design & rendu** | Qualité graphique, modernité, responsive design, support CSS ou thèmes. |
| **Architecture logicielle** | Capacité à séparer interface, logique et données (patterns MVC, MVP…). |
| **Écosystème & maintenance** | Fréquence des mises à jour, communauté, pérennité du projet. |
| **Type d’usage idéal** | Pertinence selon le type d’application (desktop, web, hybride). |

---

## 4. Frameworks étudiés

| Framework | Présentation synthétique |
|------------|--------------------------|
| **JavaFX** | API officielle de Java pour interfaces modernes, basée sur FXML, CSS et un moteur de rendu graphique. |
| **Swing** | API historique incluse dans le JDK, simple mais visuellement datée. |
| **Vaadin Flow** | Framework Java web côté serveur, génère automatiquement le HTML et gère les interactions via Java. |
| **Compose for Desktop** | Framework moderne de JetBrains inspiré de Jetpack Compose (Kotlin/Java), orienté interfaces réactives. |
| **SWT** | Bibliothèque native développée par Eclipse Foundation, offrant un rendu OS natif. |

---

## 5. Résultats comparatifs

| Critère | JavaFX | Swing | Vaadin Flow | Compose for Desktop | SWT |
|----------|:-------:|:------:|:------------:|:-------------------:|:----:|
| Environnement & installation | 🟩 | 🟩 | 🟨 | 🟨 | 🟥 |
| Expérience de développement | 🟩 | 🟨 | 🟩 | 🟩 | 🟨 |
| Design & rendu | 🟩 | 🟥 | 🟩 | 🟩 | 🟨 |
| Architecture logicielle | 🟩 | 🟨 | 🟩 | 🟩 | 🟨 |
| Écosystème & maintenance | 🟩 | 🟨 | 🟩 | 🟨 | 🟨 |
| Type d’usage idéal | Desktop | Desktop | Web | Desktop | Desktop |

---

## 6. Analyse individuelle

### 🟢 JavaFX
- **Installation :** disponible via OpenJFX ou Maven Central, compatible IntelliJ et Scene Builder.  
- **Atouts :** CSS, FXML, animations, MVC natif, documentation claire.  
- **Limites :** nécessite Java ≥ 11.  
- **Conclusion :** le standard actuel pour les applications desktop Java.

---

### 🟡 Swing
- **Installation :** aucun ajout nécessaire (intégré au JDK).  
- **Atouts :** légèreté, simplicité, stabilité.  
- **Limites :** apparence vieillissante, difficile à styliser.  
- **Conclusion :** pertinent pour des outils internes simples, mais plus adapté aux projets modernes.

---

### 🟢 Vaadin Flow
- **Installation :** projet Maven standard, nécessite un serveur (Tomcat ou Spring Boot).  
- **Atouts :** entièrement en Java, aucun HTML requis, intégration facile avec backend Spring.  
- **Limites :** performances moindres sur très gros volumes côté client.  
- **Conclusion :** framework idéal pour une **interface web Java professionnelle**.

---

### 🟢 Compose for Desktop
- **Installation :** plugin officiel JetBrains, dépend de Kotlin (interopérable Java).  
- **Atouts :** architecture réactive, rendu moderne, très fluide.  
- **Limites :** jeune projet, documentation encore limitée côté Java pur.  
- **Conclusion :** excellent choix pour des interfaces modernes en **Java/Kotlin**.

---

### 🟨 SWT
- **Installation :** nécessite des bibliothèques natives selon l’OS.  
- **Atouts :** rendu 100 % natif et très performant.  
- **Limites :** faible portabilité et documentation vieillissante.  
- **Conclusion :** utile dans les contextes Eclipse ou applications industrielles, sinon lourd à maintenir.

---

## 7. Recommandations finales

| Contexte | Framework recommandé | Raison principale |
|-----------|----------------------|-------------------|
| **Application desktop riche et moderne** | **JavaFX** | Complet, stable, bon rendu, API officielle. |
| **Application web Java en entreprise** | **Vaadin Flow** | Composants Java côté serveur, intégration Spring, maintenance longue durée. |
| **Prototype ou outil interne rapide** | **Swing** | Simple, aucune dépendance, démarrage immédiat. |
| **Interface réactive moderne (Java/Kotlin)** | **Compose for Desktop** | Fluide, moderne, approche déclarative. |

---

## 8. Conclusion

L’analyse montre que **JavaFX** reste la référence pour les applications **desktop Java**, combinant modernité, modularité et simplicité.  
Pour une **application web**, **Vaadin Flow** se démarque par sa maturité et sa compatibilité avec les environnements d’entreprise.  

---

_Fichier rédigé par POPOV – Octobre 2025._
