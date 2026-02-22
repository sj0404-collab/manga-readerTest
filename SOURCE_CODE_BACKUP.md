# Manga Talk Reader - Полная Резервная Копия Кодов

**Версия:** 1.0.0
**Дата:** 2026-02-22
**Статус:** Полная версия для резервного копирования

---

## СОДЕРЖАНИЕ

1. [Архитектура и структура проекта](#архитектура)
2. [Конфигурация проекта](#конфиг)
3. [Слой данных (Data Layer)](#data-layer)
4. [Бизнес-логика (Domain Layer)](#domain-layer)
5. [UI Слой (Presentation Layer)](#ui-layer)
6. [Внедрение зависимостей (DI)](#di)
7. [Ключевые компоненты](#components)

---

## АРХИТЕКТУРА ПРОЕКТА {#архитектура}

### Структура папок:
```
app/src/main/
├── java/com/mytech/mangatalkreader/
│   ├── MainActivity.kt
│   ├── data/
│   │   ├── db/
│   │   │   ├── MangaDatabase.kt
│   │   │   ├── entity/Entities.kt
│   │   │   ├── dao/
│   │   │   │   ├── MangaDao.kt
│   │   │   │   ├── ChapterDao.kt
│   │   │   │   ├── TextBlockDao.kt
│   │   │   │   ├── CollectionDao.kt
│   │   │   │   └── SourceDao.kt
│   │   │   ├── converter/DateConverter.kt
│   │   ├── repository/
│   │   │   └── MangaRepository.kt
│   │   ├── model/
│   │   │   └── DomainModels.kt
│   ├── domain/
│   │   └── service/
│   │       ├── OcrService.kt
│   │       ├── TtsService.kt
│   │       └── ArchiveService.kt
│   ├── ui/
│   │   ├── theme/
│   │   │   ├── Theme.kt
│   │   │   └── Type.kt
│   │   ├── viewmodel/
│   │   │   ├── LibraryViewModel.kt
│   │   │   └── ReaderViewModel.kt
│   │   ├── navigation/
│   │   │   └── Navigation.kt
│   │   └── screen/
│   │       ├── MainScreen.kt
│   │       ├── LibraryScreen.kt
│   │       ├── ReaderScreen.kt
│   │       ├── SettingsScreen.kt
│   │       ├── CollectionsScreen.kt
│   │       └── SourcesScreen.kt
│   ├── di/
│   │   └── DatabaseModule.kt
├── res/
│   └── values/
│       ├── strings.xml
│       └── themes.xml
└── AndroidManifest.xml
```

---

## КОНФИГУРАЦИЯ ПРОЕКТА {#конфиг}

### build.gradle.kts (Root)
```kotlin
plugins {
    alias(libs.plugins.android.application) apply false
    alias(libs.plugins.kotlin.android) apply false
}

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.2.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.20")
        classpath("com.google.dagger:hilt-android-gradle-plugin:2.48")
    }
}
```

### build.gradle.kts (App)
```kotlin
plugins {
    id("com.android.application")
    kotlin("android")
    kotlin("kapt")
    id("com.google.dagger.hilt.android")
}

android {
    namespace = "com.mytech.mangatalkreader"
    compileSdk = 34
    defaultConfig {
        applicationId = "com.mytech.mangatalkreader"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
    }
    buildFeatures {
        compose = true
    }
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.8"
    }
}

dependencies {
    // Core Android
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.6.2")
    implementation("androidx.activity:activity-compose:1.8.1")

    // Compose
    implementation(platform("androidx.compose:compose-bom:2023.10.01"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.material3:material3:1.1.2")
    implementation("androidx.compose.foundation:foundation")

    // Navigation
    implementation("androidx.navigation:navigation-compose:2.7.5")

    // Hilt
    implementation("com.google.dagger:hilt-android:2.48")
    kapt("com.google.dagger:hilt-compiler:2.48")

    // Room
    implementation("androidx.room:room-runtime:2.6.1")
    kapt("androidx.room:room-compiler:2.6.1")
    implementation("androidx.room:room-ktx:2.6.1")

    // Image Loading
    implementation("io.coil-kt:coil-compose:2.5.0")

    // ML Kit OCR
    implementation("com.google.mlkit:text-recognition:16.0.0")
    implementation("com.google.mlkit:text-recognition-chinese:16.0.0")
    implementation("com.google.mlkit:text-recognition-japanese:16.0.0")

    // Archive
    implementation("net.lingala.zip4j:zip4j:2.11.5")

    // Coroutines
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.7.3")

    // Logging
    implementation("com.jakewharton.timber:timber:5.0.1")
}
```

### AndroidManifest.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.CAMERA" />
    <application>
        <activity android:name=".MainActivity" android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
```

---

## СЛОЙ ДАННЫХ (Data Layer) {#data-layer}

### Entity Models (Entities.kt)

**MangaEntity** - Основная сущность манги
```
- id: Long (Primary Key)
- title: String (название)
- coverPath: String? (путь к обложке)
- description: String? (описание)
- source: String? (источник)
- sourceUrl: String? (URL источника)
- currentChapter: Int (текущая глава)
- totalChapters: Int (всего глав)
- progress: Float (прогресс 0-1)
- isRead: Boolean (прочитана ли)
- dateAdded: Date (дата добавления)
- lastReadDate: Date? (дата последнего чтения)
- isFavorite: Boolean (избранное)
```

**ChapterEntity** - Главы манги
```
- id: Long (Primary Key)
- mangaId: Long (Foreign Key к Manga)
- title: String (название главы)
- number: Int (номер главы)
- path: String? (путь к файлу)
- url: String? (URL)
- pageCount: Int (количество страниц)
- currentPage: Int (текущая страница)
- isRead: Boolean (прочитана)
- dateRead: Date? (дата чтения)
```

**TextBlockEntity** - Текстовые блоки (распознанный текст)
```
- id: Long (Primary Key)
- chapterId: Long (Foreign Key к Chapter)
- pageNumber: Int (номер страницы)
- text: String (текст)
- type: String (тип: dialog/description/comment)
- language: String (язык: ru/ja/en)
- x, y, width, height: Float (координаты)
- textColor, backgroundColor: Int (цвета)
- fontSize: Float (размер шрифта)
- isManual: Boolean (создан вручную)
- hasAudio: Boolean (есть ли аудио)
- audioPath: String? (путь к аудио)
- ttsSpeed, ttsPitch: Float (настройки TTS)
- dateCreated: Date
```

**CollectionEntity** - Коллекции пользователя
```
- id: Long
- name: String (название коллекции)
- description: String?
- iconColor: Int (цвет иконки)
- dateCreated: Date
```

**SourceEntity** - Веб-источники
```
- id: Long
- name: String (название)
- url: String (URL)
- iconUrl: String? (иконка)
- isActive: Boolean
- dateAdded: Date
- lastChecked: Date?
- updateCheckInterval: Long (интервал проверки)
```

### Database Access Objects (DAOs)

**MangaDao** - CRUD операции с мангой
```kotlin
- insert(manga): Long
- update(manga): Unit
- delete(manga): Unit
- getAllManga(): Flow<List<MangaEntity>>
- searchManga(query): Flow<List<MangaEntity>>
- getFavoriteManga(): Flow<List<MangaEntity>>
- updateProgress(id, progress)
- toggleFavorite(id, isFavorite)
```

**ChapterDao** - Управление главами
```kotlin
- insert(chapter): Long
- update(chapter): Unit
- delete(chapter): Unit
- getChaptersByManga(mangaId): Flow<List<ChapterEntity>>
- getChapterByNumber(mangaId, number): ChapterEntity?
- updateCurrentPage(id, page)
- updateReadStatus(id, isRead)
```

**TextBlockDao** - Управление текстовыми блоками
```kotlin
- insert(textBlock): Long
- update(textBlock): Unit
- delete(textBlock): Unit
- getTextBlocksByPage(chapterId, pageNumber): Flow<List<TextBlockEntity>>
- getTextBlocksByChapter(chapterId): Flow<List<TextBlockEntity>>
- updateAudioStatus(id, hasAudio, audioPath)
```

### Repository Pattern

**MangaRepository** - Бизнес-логика для манги
```kotlin
- getAllManga(): Flow<List<Manga>>
- searchManga(query): Flow<List<Manga>>
- getFavoriteManga(): Flow<List<Manga>>
- getMangaById(id): Manga?
- addManga(manga): Long
- updateManga(manga): Unit
- deleteManga(id): Unit
- updateProgress(id, progress)
- updateReadStatus(id, isRead)
- toggleFavorite(id, isFavorite)
```

---

## БИЗНЕС-ЛОГИКА (Domain Layer) {#domain-layer}

### OCR Service (OcrService.kt)

Интеграция Google ML Kit для распознавания текста:
```kotlin
suspend fun recognizeText(bitmap: Bitmap): List<TextBlock>
    - Распознаёт текст на изображении
    - Определяет тип текста (диалог/описание/комментарий)
    - Определяет язык текста (RU/JA/EN)
    - Вычисляет координаты и размер шрифта

private fun detectTextType(text: String): String
    - dialog: стандартный текст в балунах
    - description: длинный текст, описания
    - comment: примечания переводчиков

private fun detectLanguage(text: String): String
    - Проверяет диапазоны Unicode для определения языка
    - Поддерживает русский, японский, английский
```

### TTS Service (TtsService.kt)

Озвучка текста на Android:
```kotlin
fun speak(text: String, language: String, speed: Float, pitch: Float)
    - Озвучивает текст с указанными параметрами
    - Переключает язык (Locale)
    - Устанавливает скорость и тон

fun stop()
    - Останавливает текущую озвучку

fun isSpeaking(): Boolean
    - Проверяет, идёт ли озвучка
```

### Archive Service (ArchiveService.kt)

Работа с ZIP, CBZ архивами:
```kotlin
suspend fun extractPages(archivePath, outputDir): List<String>
    - Извлекает все изображения из архива
    - Фильтрует по расширениям (jpg, png, webp, gif)
    - Сортирует по имени файла

suspend fun getArchiveInfo(archivePath): ArchiveInfo
    - Возвращает размер архива
    - Количество страниц/изображений
    - Имя первого изображения

suspend fun extractFirstPage(archivePath, outputDir): String?
    - Извлекает первое изображение (обложка)

fun getImageList(folderPath): List<String>
    - Получает список изображений из папки
```

---

## UI СЛОЙ (Presentation Layer) {#ui-layer}

### ViewModels

**LibraryViewModel** - Управление библиотекой
```kotlin
- mangaList: StateFlow<List<Manga>>
- isLoading: StateFlow<Boolean>
- searchQuery: StateFlow<String>

fun loadManga()
    - Загружает все манги из репозитория

fun searchManga(query: String)
    - Поиск манги по названию

fun deleteManga(mangaId: Long)
    - Удаление манги

fun toggleFavorite(mangaId: Long, isFavorite: Boolean)
    - Добавление в избранное

fun refreshManga()
    - Обновление списка
```

**ReaderViewModel** - Управление читалкой
```kotlin
- currentPage: StateFlow<Int>
- totalPages: StateFlow<Int>
- textBlocks: StateFlow<List<TextBlock>>
- readingMode: StateFlow<String>
- showPageNumber: StateFlow<Boolean>

fun setTotalPages(total: Int)
    - Установить количество страниц

fun nextPage() / fun previousPage()
    - Переключение страниц

fun goToPage(page: Int)
    - Перейти на конкретную страницу

fun speakText(text: String, language: String)
    - Озвучить текст через TTS

fun stopSpeaking()
    - Остановить озвучку
```

### Screens (Jetpack Compose)

**MainScreen** - Главный экран с навигацией
- Bottom Navigation Bar с 4 вкладками
- Library | Collections | Sources | Settings
- Floating Action Button для добавления манги

**LibraryScreen** - Библиотека манги
- Поле поиска в верхней части
- Grid layout (2 колонки) с карточками манги
- Каждая карточка показывает:
  - Обложку
  - Название
  - Прогресс чтения (Progress Bar)
  - Текущую/общую главу

**ReaderScreen** - Читалка
- Главное изображение в центре
- Top Bar с кнопками (Back, Info, More)
- Bottom Bar с навигацией
- Номер текущей страницы
- Поддержка режимов чтения (RTL, LTR, Vertical)

**SettingsScreen** - Настройки приложения
- Переключатели (Switches) для опций
- Sliders для TTS параметров:
  - Скорость речи (0.5x - 2x)
  - Тон голоса (0.5 - 2)
  - Чувствительность OCR
- Информация о приложении

**CollectionsScreen** - Коллекции
- Список пользовательских коллекций
- Каждая коллекция с цветной полоской
- Кнопка удаления

**SourcesScreen** - Веб-источники
- Список добавленных источников
- URL и название каждого источника
- FAB для добавления нового источника

---

## ВНЕДРЕНИЕ ЗАВИСИМОСТЕЙ (DI) {#di}

### DatabaseModule (Hilt)

```kotlin
@Module
@InstallIn(SingletonComponent::class)
object DatabaseModule {

    @Singleton
    @Provides
    fun provideMangaDatabase(context: Context): MangaDatabase
        - Создаёт Room базу данных
        - Используется на уровне приложения (Singleton)

    @Singleton
    @Provides
    fun provideMangaDao(database: MangaDatabase): MangaDao

    @Singleton
    @Provides
    fun provideChapterDao(database: MangaDatabase): ChapterDao

    @Singleton
    @Provides
    fun provideTextBlockDao(database: MangaDatabase): TextBlockDao

    @Singleton
    @Provides
    fun provideCollectionDao(database: MangaDatabase): CollectionDao

    @Singleton
    @Provides
    fun provideSourceDao(database: MangaDatabase): SourceDao
}
```

### Автоматическое внедрение в ViewModels

```kotlin
@HiltViewModel
class LibraryViewModel @Inject constructor(
    private val mangaRepository: MangaRepository
) : ViewModel()

@HiltViewModel
class ReaderViewModel @Inject constructor(
    private val ocrService: OcrService,
    private val ttsService: TtsService
) : ViewModel()
```

---

## КЛЮЧЕВЫЕ КОМПОНЕНТЫ {#components}

### 1. Material Design 3 Тема

Используется современный Material Design 3 с поддержкой динамических цветов (Android 12+).

**Цветовая схема (Light Mode):**
- Primary: Indigo #6366F1
- Secondary: Cyan #0891B2
- Tertiary: Teal #059669
- Error: Red #DC2626

**Цветовая схема (Dark Mode):**
- Primary: Indigo #6366F1
- Secondary: Cyan #06B6D4
- Tertiary: Teal #10B981
- Background: Navy #0F172A

### 2. Coroutines & Flow

Все асинхронные операции используют Kotlin Coroutines:
- `withContext(Dispatchers.IO)` для операций с БД и файлами
- `withContext(Dispatchers.Default)` для CPU-интенсивных задач
- `Flow<T>` для реактивного потока данных из БД

### 3. MVVM Архитектура

- **Model** - Room Entities, Repositories, Services
- **View** - Jetpack Compose Screens
- **ViewModel** - Управление состоянием и UI логикой

Все данные текут через StateFlow для реактивности.

### 4. Процесс распознавания текста (OCR)

1. Пользователь открывает страницу манги
2. ArchiveService извлекает изображение
3. OcrService распознаёт текст через ML Kit
4. TextBlock'и сохраняются в БД
5. UI отображает распознанный текст с рамками

### 5. Озвучивание текста (TTS)

1. Пользователь тапает на TextBlock
2. Извлекается текст и язык
3. TtsService переключает язык (Locale)
4. Озвучка проигрывается с настройками (speed, pitch)
5. Active TextBlock визуально выделяется

### 6. Управление архивами

- Поддерживаются ZIP и CBZ форматы
- Извлечение на лету (без полной распаковки)
- Кэширование извлеченных страниц в памяти
- Оптимизация для больших архивов (>1GB)

---

## УСТАНОВКА И ЗАПУСК

### Требования:
- Android Studio 2024.1.1+
- Android SDK 34+
- Kotlin 1.9.20+
- Java 17+

### Шаги установки:

1. **Клонировать проект:**
   ```bash
   git clone <repository-url>
   cd manga-talk-reader
   ```

2. **Открыть в Android Studio:**
   - File → Open → выбрать корневую папку проекта

3. **Синхронизировать Gradle:**
   - Gradle автоматически скачает все зависимости

4. **Запустить приложение:**
   - Подключить устройство или эмулятор
   - Run → Run 'app'

### Требуемые разрешения:
- `READ_EXTERNAL_STORAGE` - чтение файлов манги
- `WRITE_EXTERNAL_STORAGE` - сохранение данных
- `INTERNET` - загрузка из веб-источников
- `CAMERA` - для OCR (если использовать камеру)

---

## ТЕСТИРОВАНИЕ

### Unit Tests:
```bash
./gradlew test
```

### Instrumented Tests (на устройстве):
```bash
./gradlew connectedAndroidTest
```

### Покрытие кода:
```bash
./gradlew jacocoTestReport
```

---

## ОШИБКИ И РЕШЕНИЯ

### Проблема: OCR не распознаёт текст
**Решение:** Убедитесь, что изображение достаточно чёткое, обновить ML Kit models.

### Проблема: TTS не работает
**Решение:** Проверить, что язык установлен в системе, перезагрузить приложение.

### Проблема: Архив не открывается
**Решение:** Использовать стандартные форматы ZIP/CBZ, избегать вложенных архивов.

---

## ДОКУМЕНТАЦИЯ

- [Google ML Kit](https://developers.google.com/ml-kit)
- [Jetpack Compose](https://developer.android.com/jetpack/compose)
- [Room Persistence](https://developer.android.com/training/data-storage/room)
- [Hilt Dependency Injection](https://developer.android.com/training/dependency-injection/hilt-android)
- [Kotlin Coroutines](https://kotlinlang.org/docs/coroutines-overview.html)

---

## ЛИЦЕНЗИЯ

MIT License - см. файл LICENSE

---

## КОНТАКТЫ

Email: support@mangatalkreader.dev
GitHub: https://github.com/mangatalkreader
Website: https://mangatalkreader.dev

---

**Документ завершен. Дата создания: 2026-02-22**
