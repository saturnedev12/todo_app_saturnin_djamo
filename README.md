# 📱 Application Todo – Test Technique Flutter pour Djamo

## 🌍 Contexte

Ce projet a été réalisé dans le cadre du processus de recrutement chez **Djamo**, une entreprise ambitieuse qui transforme l’accès aux services financiers pour des millions d’Africains.  
L’objectif est de démontrer mes compétences techniques en Flutter, en respectant une architecture propre et évolutive.

---

## ✨ Fonctionnalités

L’application permet à un utilisateur non authentifié de :

- ✅ **Lister** toutes les tâches
- ✅ **Consulter** le détail d’une tâche
- ✅ **Ajouter** une nouvelle tâche
- ✅ **Modifier** une tâche existante
- ✅ **Supprimer** une ou plusieurs tâches

Chaque tâche peut contenir :

- Des **sous-tâches**
- Un niveau de **priorité**
- Une **notification de rappel**
- Une **date de création** (timestamp)

---

## 🧱 Architecture et Structure du Projet

Le projet suit la **Clean Architecture**, basée sur le [cours de ResoCoder](https://github.com/ResoCoder/flutter-tdd-clean-architecture-course), avec une séparation claire entre :

- **Domain** : logique métier pure (entités, use cases)
- **Data** : modèles, gestion locale (Isar), implémentations des repositories
- **Presentation** : UI, gestion d'état avec Bloc, composants

### 📁 Arborescence du projet

```plaintext
├── app
│   ├── app.dart
│   ├── core
│   │   ├── config
│   │   │   ├── injectable_config.config.dart
│   │   │   ├── injectable_config.dart
│   │   │   ├── isar_config.dart
│   │   │   └── theme_config.dart
│   │   ├── services
│   │   │   └── reminder_service.dart
│   │   ├── shared
│   │   │   ├── logic
│   │   │   └── widgets
│   │   └── utils
│   │       └── theme_handler.dart
│   └── features
│       ├── home
│       │   ├── domain
│       │   │   └── models
│       │   │       ├── theme_model.dart
│       │   │       └── theme_model.g.dart
│       │   └── presentation
│       │       ├── bloc
│       │       │   └── theme_bloc.dart
│       │       ├── components
│       │       │   ├── select_button.dart
│       │       │   ├── select_handler.dart
│       │       │   ├── select_theme_button.dart
│       │       │   └── task_progress_bar.dart
│       │       ├── pages
│       │       │   └── home_page.dart
│       │       └── utils
│       │           └── home_utils.dart
│       └── toto_list
│           ├── data
│           │   ├── models
│           │   │   ├── sub_task_model.dart
│           │   │   ├── sub_task_model.g.dart
│           │   │   ├── task_model.dart
│           │   │   └── task_model.g.dart
│           │   └── repositories
│           │       └── task_repository_impl.dart
│           ├── domain
│           │   ├── entities
│           │   │   ├── task_entity.dart
│           │   │   ├── task_entity.freezed.dart
│           │   │   └── task_entity.g.dart
│           │   ├── repositories
│           │   │   └── task_repository.dart
│           │   └── use_cases
│           │       └── task_use_case.dart
│           └── presentation
│               ├── bloc
│               │   ├── check_mode_cubit.dart
│               │   ├── check_mode_state.dart
│               │   ├── check_mode_state.freezed.dart
│               │   ├── sub_task_logic.dart
│               │   ├── task_cubit.dart
│               │   ├── task_list_logic.dart
│               │   ├── task_list_state.dart
│               │   └── task_list_state.freezed.dart
│               ├── components
│               │   ├── add_sub_task_compoent.dart
│               │   ├── add_task_compoent.dart
│               │   ├── custom_chip.dart
│               │   ├── priority_color_selector.dart
│               │   ├── reminder_picker.dart
│               │   ├── sub_task_item.dart
│               │   ├── sub_task_list.dart
│               │   └── task_item.dart
│               ├── pages
│               │   └── task_list_page.dart
```

## ⚙️ Technologies Utilisées

| Outil                  | Description                              |
| ---------------------- | ---------------------------------------- |
| **Flutter**            | Framework mobile multiplateforme         |
| **Dart**               | Langage utilisé pour Flutter             |
| **Bloc**               | Gestion d'état robuste et testable       |
| **Isar**               | Base de données locale ultra performante |
| **Injectable + GetIt** | Injection de dépendances                 |
| **Freezed**            | Génération de modèles immuables          |
| **TDD**                | Architecture orientée tests              |

---

## 📱 Captures d’écran

> _(Ajoutez ici une ou deux captures si vous en avez)_

---

## 📦 Déploiement et Livrables

- ✅ Code source livré sur un dépôt **GitHub/GitLab privé**
- ✅ **APK** généré pour Android, prêt à être testé

---

## 🔗 Lien utile

- [API JSONPlaceholder](https://jsonplaceholder.typicode.com/) _(utilisée uniquement si l'option distant est choisie)_

---

## 🙏 Remerciements

Merci à l’équipe de **Djamo** pour cette opportunité.  
Ce projet a été réalisé avec passion, rigueur, et l’envie de contribuer à une mission à fort impact.

---
