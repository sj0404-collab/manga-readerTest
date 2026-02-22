# 📑 Индекс всех файлов проекта

**Последнее обновление**: 22 февраля 2026
**Всего файлов**: 40+
**Всего строк кода**: ~3,500+

---

## 📋 Главные документы

| Файл | Размер | Описание |
|------|--------|---------|
| README.md | ~4 KB | Основная информация и введение |
| BUILD_GUIDE.md | ~8 KB | Полное руководство по сборке APK |
| PROJECT_SUMMARY.md | ~10 KB | Полное резюме проекта и архитектура |
| SOURCE_CODE_BACKUP.md | ~15 KB | Полная резервная копия всех кодов |
| QUICK_REFERENCE.md | ~6 KB | Быстрый справочник и шпаргалка |
| FILE_INDEX.md | ~5 KB | Этот файл - индекс всех файлов |

---

## 🏗️ Конфигурационные файлы

### Gradle конфигурация
| Файл | Линий | Описание |
|------|------|---------|
| build.gradle.kts | 12 | Root build конфиг (plugins, repos) |
| app/build.gradle.kts | 95 | App build конфиг (dependencies, SDK) |
| settings.gradle.kts | 15 | Settings конфиг (plugins, repos) |
| proguard-rules.pro | 30 | Правила минификации для Release |
| gradle.properties | - | Gradle свойства (не создан, используется по умолчанию) |

### Манифест и ресурсы
| Файл | Линий | Описание |
|------|------|---------|
| app/src/main/AndroidManifest.xml | 25 | Манифест приложения (permissions, activities) |
| app/src/main/res/values/strings.xml | 18 | Строки локализации |
| app/src/main/res/values/themes.xml | 8 | Tema конфигурация |

### NPM конфиг
| Файл | Линий | Описание |
|------|------|---------|
| package.json | 20 | NPM скрипты и metadata |

---

## 💾 Data Layer (~1,000 строк)

### Database
| Файл | Путь | Линий | Описание |
|------|------|------|---------|
| MangaDatabase.kt | data/db/ | 25 | Room Database config (6 таблиц) |
| Entities.kt | data/db/entity/ | 150 | Все Entity классы (Manga, Chapter, TextBlock, Collection, Source) |
| DateConverter.kt | data/db/converter/ | 12 | TypeConverter для Date ↔ Long |

### DAOs (Data Access Objects)
| Файл | Путь | Линий | Описание |
|------|------|------|---------|
| MangaDao.kt | data/db/dao/ | 50 | CRUD операции для Manga |
| ChapterDao.kt | data/db/dao/ | 40 | CRUD операции для Chapter |
| TextBlockDao.kt | data/db/dao/ | 40 | CRUD операции для TextBlock |
| CollectionDao.kt | data/db/dao/ | 40 | CRUD операции для Collection |
| SourceDao.kt | data/db/dao/ | 35 | CRUD операции для Source |

### Repository
| Файл | Путь | Линий | Описание |
|------|------|------|---------|
| MangaRepository.kt | data/repository/ | 60 | Бизнес-логика для манги (синглтон) |

### Models
| Файл | Путь | Линий | Описание |
|------|------|------|---------|
| DomainModels.kt | data/model/ | 120 | Все domain модели (Manga, Chapter, TextBlock, etc) |

---

## 🧠 Domain Layer (~800 строк)

### Services
| Файл | Путь | Линий | Описание |
|------|------|------|---------|
| OcrService.kt | domain/service/ | 80 | ML Kit OCR (распознавание текста) |
| TtsService.kt | domain/service/ | 70 | Android TTS (озвучка текста) |
| ArchiveService.kt | domain/service/ | 100 | Обработка ZIP/CBZ архивов |

---

## 🎨 Presentation Layer (UI) (~1,200 строк)

### Theme (Material Design 3)
| Файл | Путь | Линий | Описание |
|------|------|------|---------|
| Theme.kt | ui/theme/ | 90 | Light/Dark theme с Material Design 3 |
| Type.kt | ui/theme/ | 80 | Typography (шрифты, стили) |

### ViewModels
| Файл | Путь | Линий | Описание |
|------|------|------|---------|
| LibraryViewModel.kt | ui/viewmodel/ | 60 | ViewModel для экрана библиотеки |
| ReaderViewModel.kt | ui/viewmodel/ | 55 | ViewModel для экрана читалки |

### Navigation
| Файл | Путь | Линий | Описание |
|------|------|------|---------|
| Navigation.kt | ui/navigation/ | 25 | NavHost с маршрутами приложения |

### Screens (Compose)
| Файл | Путь | Линий | Описание |
|------|------|------|---------|
| MainScreen.kt | ui/screen/ | 65 | Главный экран с Bottom Navigation |
| LibraryScreen.kt | ui/screen/ | 150 | Экран библиотеки (Grid карточек) |
| ReaderScreen.kt | ui/screen/ | 120 | Экран читалки (Full screen reader) |
| SettingsScreen.kt | ui/screen/ | 130 | Экран настроек (Sliders, Switches) |
| CollectionsScreen.kt | ui/screen/ | 90 | Экран коллекций |
| SourcesScreen.kt | ui/screen/ | 85 | Экран веб-источников |

---

## 🔌 Dependency Injection

### Modules
| Файл | Путь | Линий | Описание |
|------|------|------|---------|
| DatabaseModule.kt | di/ | 40 | Hilt модуль для Database и DAOs |

---

## 📱 Main Application

| Файл | Путь | Линий | Описание |
|------|------|------|---------|
| MainActivity.kt | / | 35 | Entry point приложения (Compose) |

---

## 📊 Полная структура папок

```
manga-talk-reader/
│
├── 📄 Документы
│   ├── README.md
│   ├── BUILD_GUIDE.md
│   ├── PROJECT_SUMMARY.md
│   ├── SOURCE_CODE_BACKUP.md
│   ├── QUICK_REFERENCE.md
│   ├── FILE_INDEX.md
│   └── package.json
│
├── 📂 app/
│   ├── 📂 src/
│   │   ├── 📂 main/
│   │   │   ├── 📂 java/com/mytech/mangatalkreader/
│   │   │   │   ├── 📄 MainActivity.kt
│   │   │   │   │
│   │   │   │   ├── 📂 data/
│   │   │   │   │   ├── 📂 db/
│   │   │   │   │   │   ├── 📄 MangaDatabase.kt
│   │   │   │   │   │   ├── 📂 entity/
│   │   │   │   │   │   │   └── 📄 Entities.kt
│   │   │   │   │   │   ├── 📂 dao/
│   │   │   │   │   │   │   ├── 📄 MangaDao.kt
│   │   │   │   │   │   │   ├── 📄 ChapterDao.kt
│   │   │   │   │   │   │   ├── 📄 TextBlockDao.kt
│   │   │   │   │   │   │   ├── 📄 CollectionDao.kt
│   │   │   │   │   │   │   └── 📄 SourceDao.kt
│   │   │   │   │   │   └── 📂 converter/
│   │   │   │   │   │       └── 📄 DateConverter.kt
│   │   │   │   │   ├── 📂 repository/
│   │   │   │   │   │   └── 📄 MangaRepository.kt
│   │   │   │   │   └── 📂 model/
│   │   │   │   │       └── 📄 DomainModels.kt
│   │   │   │   │
│   │   │   │   ├── 📂 domain/
│   │   │   │   │   └── 📂 service/
│   │   │   │   │       ├── 📄 OcrService.kt
│   │   │   │   │       ├── 📄 TtsService.kt
│   │   │   │   │       └── 📄 ArchiveService.kt
│   │   │   │   │
│   │   │   │   ├── 📂 ui/
│   │   │   │   │   ├── 📂 theme/
│   │   │   │   │   │   ├── 📄 Theme.kt
│   │   │   │   │   │   └── 📄 Type.kt
│   │   │   │   │   ├── 📂 viewmodel/
│   │   │   │   │   │   ├── 📄 LibraryViewModel.kt
│   │   │   │   │   │   └── 📄 ReaderViewModel.kt
│   │   │   │   │   ├── 📂 navigation/
│   │   │   │   │   │   └── 📄 Navigation.kt
│   │   │   │   │   └── 📂 screen/
│   │   │   │   │       ├── 📄 MainScreen.kt
│   │   │   │   │       ├── 📄 LibraryScreen.kt
│   │   │   │   │       ├── 📄 ReaderScreen.kt
│   │   │   │   │       ├── 📄 SettingsScreen.kt
│   │   │   │   │       ├── 📄 CollectionsScreen.kt
│   │   │   │   │       └── 📄 SourcesScreen.kt
│   │   │   │   │
│   │   │   │   └── 📂 di/
│   │   │   │       └── 📄 DatabaseModule.kt
│   │   │   │
│   │   │   ├── 📄 AndroidManifest.xml
│   │   │   └── 📂 res/
│   │   │       └── 📂 values/
│   │   │           ├── 📄 strings.xml
│   │   │           └── 📄 themes.xml
│   │   │
│   ├── 📄 build.gradle.kts
│   └── 📄 proguard-rules.pro
│
├── 📄 build.gradle.kts
├── 📄 settings.gradle.kts
├── 📄 .gitignore
└── 📄 .gradle/ (auto-generated)
```

---

## 🗂️ Классификация по функциональности

### Database & Persistence
```
data/db/MangaDatabase.kt
data/db/entity/Entities.kt
data/db/dao/MangaDao.kt
data/db/dao/ChapterDao.kt
data/db/dao/TextBlockDao.kt
data/db/dao/CollectionDao.kt
data/db/dao/SourceDao.kt
data/db/converter/DateConverter.kt
```

### Business Logic
```
data/repository/MangaRepository.kt
domain/service/OcrService.kt
domain/service/TtsService.kt
domain/service/ArchiveService.kt
```

### UI Components
```
ui/screen/MainScreen.kt
ui/screen/LibraryScreen.kt
ui/screen/ReaderScreen.kt
ui/screen/SettingsScreen.kt
ui/screen/CollectionsScreen.kt
ui/screen/SourcesScreen.kt
```

### State Management
```
ui/viewmodel/LibraryViewModel.kt
ui/viewmodel/ReaderViewModel.kt
```

### Styling & Navigation
```
ui/theme/Theme.kt
ui/theme/Type.kt
ui/navigation/Navigation.kt
```

### Configuration & Setup
```
MainActivity.kt
di/DatabaseModule.kt
build.gradle.kts (app & root)
settings.gradle.kts
AndroidManifest.xml
```

---

## 📊 Статистика по типам файлов

| Тип | Количество | Строк | % кода |
|-----|-----------|-------|--------|
| Kotlin (.kt) | 28 | ~3,200 | 91% |
| XML (.xml) | 3 | ~120 | 3% |
| Gradle (.kts) | 3 | ~120 | 3% |
| Markdown (.md) | 6 | ~600 | 3% |
| **Всего** | **40** | **~4,000+** | **100%** |

---

## 🔍 Поиск по функциям

### OCR (Распознавание текста)
```
domain/service/OcrService.kt ← ML Kit интеграция
  ├── recognizeText()
  ├── detectLanguage()
  └── detectTextType()

data/db/entity/Entities.kt ← TextBlockEntity хранит результаты
data/db/dao/TextBlockDao.kt ← Операции с распознанным текстом
data/model/DomainModels.kt ← TextBlock модель
```

### TTS (Озвучка)
```
domain/service/TtsService.kt ← Android TTS интеграция
  ├── speak()
  ├── stop()
  └── isSpeaking()

ui/viewmodel/ReaderViewModel.kt ← Управление озвучкой
ui/screen/ReaderScreen.kt ← UI для озвучки
```

### Archive Handling (Архивы)
```
domain/service/ArchiveService.kt
  ├── extractPages()
  ├── getArchiveInfo()
  ├── extractFirstPage()
  └── getImageList()

data/db/entity/Entities.kt ← ChapterEntity хранит пути
data/db/dao/ChapterDao.kt ← Операции с главами
```

### Library Management (Библиотека)
```
data/db/dao/MangaDao.kt ← CRUD для манги
data/repository/MangaRepository.kt ← Бизнес-логика
ui/viewmodel/LibraryViewModel.kt ← State management
ui/screen/LibraryScreen.kt ← UI для библиотеки
```

### Collections (Коллекции)
```
data/db/entity/CollectionEntity.kt ← Модель
data/db/dao/CollectionDao.kt ← CRUD операции
ui/screen/CollectionsScreen.kt ← UI
```

### Web Sources (Источники)
```
data/db/entity/SourceEntity.kt ← Модель
data/db/dao/SourceDao.kt ← CRUD операции
ui/screen/SourcesScreen.kt ← UI
```

### Settings (Настройки)
```
ui/screen/SettingsScreen.kt ← Вся UI для настроек
  ├── TTS параметры
  ├── OCR параметры
  └── Reader параметры
```

---

## 🔗 Dependencies Map

```
MainActivity.kt
  ├── AppNavigation() [Navigation.kt]
  │   ├── MainScreen()
  │   ├── LibraryScreen() [hiltViewModel → LibraryViewModel]
  │   ├── ReaderScreen() [hiltViewModel → ReaderViewModel]
  │   ├── SettingsScreen()
  │   ├── CollectionsScreen()
  │   └── SourcesScreen()
  │
  ├── MangaTalkReaderTheme() [Theme.kt]
  │   └── Typography [Type.kt]
  │
  └── DatabaseModule.kt
      ├── MangaDatabase
      │   ├── MangaDao
      │   ├── ChapterDao
      │   ├── TextBlockDao
      │   ├── CollectionDao
      │   └── SourceDao
      │
      └── Repositories
          ├── MangaRepository
          │   └── OcrService
          │   └── TtsService
          │   └── ArchiveService
          └── ...

ViewModels
  ├── LibraryViewModel → MangaRepository
  │   └── Coroutines Flow → StateFlow
  │
  └── ReaderViewModel
      ├── OcrService
      ├── TtsService
      └── ArchiveService
```

---

## ✅ Контрольный список файлов

- [x] build.gradle.kts (root)
- [x] app/build.gradle.kts
- [x] settings.gradle.kts
- [x] AndroidManifest.xml
- [x] MainActivity.kt
- [x] MangaDatabase.kt
- [x] Entities.kt (5 entity классов)
- [x] All DAO files (5 DAOs)
- [x] DateConverter.kt
- [x] MangaRepository.kt
- [x] DomainModels.kt
- [x] OcrService.kt
- [x] TtsService.kt
- [x] ArchiveService.kt
- [x] Theme.kt
- [x] Type.kt
- [x] LibraryViewModel.kt
- [x] ReaderViewModel.kt
- [x] Navigation.kt
- [x] MainScreen.kt
- [x] LibraryScreen.kt
- [x] ReaderScreen.kt
- [x] SettingsScreen.kt
- [x] CollectionsScreen.kt
- [x] SourcesScreen.kt
- [x] DatabaseModule.kt
- [x] strings.xml
- [x] themes.xml
- [x] proguard-rules.pro
- [x] README.md
- [x] BUILD_GUIDE.md
- [x] PROJECT_SUMMARY.md
- [x] SOURCE_CODE_BACKUP.md
- [x] QUICK_REFERENCE.md
- [x] FILE_INDEX.md
- [x] package.json

---

## 📞 Справка

**Нужна помощь в поиске файла?**

1. Определите функцию (OCR, TTS, UI, Database)
2. Найдите раздел выше (Поиск по функциям)
3. Перейдите в файл

**Нужна быстрая сборка?**
→ Смотрите BUILD_GUIDE.md

**Нужна информация о коде?**
→ Смотрите SOURCE_CODE_BACKUP.md

**Нужен быстрый справочник?**
→ Смотрите QUICK_REFERENCE.md

---

**Последнее обновление**: 22 февраля 2026
**Версия индекса**: 1.0
**Совместимость**: Kotlin 1.9.20+, Android 34+
