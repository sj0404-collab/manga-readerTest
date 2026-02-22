# Manga Talk Reader - Быстрый Справочник

## 🚀 Быстрый Старт

### Сборка проекта
```bash
# Debug APK
./gradlew assembleDebug

# Release APK
./gradlew assembleRelease

# Запуск тестов
./gradlew test

# Очистка
./gradlew clean
```

### Запуск на устройстве
```bash
./gradlew installDebug
adb shell am start -n com.mytech.mangatalkreader/.MainActivity
```

---

## 📁 Ключевые Файлы для Резервного Копирования

### Конфигурация
- `build.gradle.kts` (Root)
- `app/build.gradle.kts`
- `settings.gradle.kts`
- `app/src/main/AndroidManifest.xml`

### Основной класс
- `app/src/main/java/com/mytech/mangatalkreader/MainActivity.kt`

### Data Layer
```
data/
  ├── db/
  │   ├── MangaDatabase.kt
  │   ├── entity/Entities.kt
  │   ├── dao/
  │   │   ├── MangaDao.kt
  │   │   ├── ChapterDao.kt
  │   │   ├── TextBlockDao.kt
  │   │   ├── CollectionDao.kt
  │   │   └── SourceDao.kt
  │   ├── converter/DateConverter.kt
  ├── repository/MangaRepository.kt
  └── model/DomainModels.kt
```

### Domain Layer (Services)
```
domain/
  └── service/
      ├── OcrService.kt
      ├── TtsService.kt
      └── ArchiveService.kt
```

### UI Layer
```
ui/
  ├── theme/
  │   ├── Theme.kt
  │   └── Type.kt
  ├── viewmodel/
  │   ├── LibraryViewModel.kt
  │   └── ReaderViewModel.kt
  ├── navigation/Navigation.kt
  └── screen/
      ├── MainScreen.kt
      ├── LibraryScreen.kt
      ├── ReaderScreen.kt
      ├── SettingsScreen.kt
      ├── CollectionsScreen.kt
      └── SourcesScreen.kt
```

### Dependency Injection
```
di/
  └── DatabaseModule.kt
```

---

## 🔑 Ключевые Классы и Функции

### MangaDatabase - Инициализация
```kotlin
// Автоматически создается через Hilt в DatabaseModule
@Singleton
@Provides
fun provideMangaDatabase(context: Context): MangaDatabase {
    return Room.databaseBuilder(context, MangaDatabase::class.java, "manga_talk_reader.db").build()
}
```

### OcrService - Распознавание текста
```kotlin
@Singleton
class OcrService @Inject constructor(@ApplicationContext private val context: Context) {
    private val recognizer = TextRecognition.getClient(TextRecognizerOptions.Builder().build())

    suspend fun recognizeText(bitmap: Bitmap): List<TextBlock> {
        // Распознаёт текст и возвращает блоки с координатами
    }

    private fun detectLanguage(text: String): String {
        // Определяет язык (RU, JA, EN)
    }
}
```

### TtsService - Озвучка
```kotlin
@Singleton
class TtsService @Inject constructor(@ApplicationContext private val context: Context) {
    private lateinit var textToSpeech: TextToSpeech

    fun speak(text: String, language: String = "ru", speed: Float = 1f, pitch: Float = 1f) {
        textToSpeech.language = when(language) {
            "ja" -> Locale.JAPANESE
            "en" -> Locale.ENGLISH
            else -> Locale("ru")
        }
        textToSpeech.setSpeechRate(speed)
        textToSpeech.setPitch(pitch)
        textToSpeech.speak(text, TextToSpeech.QUEUE_FLUSH, null)
    }
}
```

### ArchiveService - Работа с архивами
```kotlin
@Singleton
class ArchiveService @Inject constructor() {
    suspend fun extractPages(archivePath: String, outputDir: String): List<String> {
        val zipFile = ZipFile(archivePath)
        val imageExtensions = listOf("jpg", "jpeg", "png", "webp", "gif")
        // Извлекает все изображения
    }
}
```

### LibraryViewModel - Управление библиотекой
```kotlin
@HiltViewModel
class LibraryViewModel @Inject constructor(
    private val mangaRepository: MangaRepository
) : ViewModel() {
    private val _mangaList = MutableStateFlow<List<Manga>>(emptyList())
    val mangaList: StateFlow<List<Manga>> = _mangaList.asStateFlow()

    fun searchManga(query: String) { /* реализация */ }
    fun deleteManga(mangaId: Long) { /* реализация */ }
    fun toggleFavorite(mangaId: Long, isFavorite: Boolean) { /* реализация */ }
}
```

### LibraryScreen - Главный экран библиотеки
```kotlin
@Composable
fun LibraryScreen(navController: NavController, viewModel: LibraryViewModel = hiltViewModel()) {
    Column(modifier = Modifier.fillMaxSize()) {
        OutlinedTextField(/* поиск */)
        LazyVerticalGrid(columns = GridCells.Fixed(2)) {
            items(mangaList) { manga ->
                MangaCard(manga)
            }
        }
    }
}
```

---

## 🎨 Material Design 3 Цвета

### Light Mode
```
Primary: #6366F1 (Indigo)
Secondary: #0891B2 (Cyan)
Tertiary: #059669 (Teal)
Error: #DC2626 (Red)
Background: #FAFAFA (White)
Surface: #FFFFFF
```

### Dark Mode
```
Primary: #6366F1 (Indigo)
Secondary: #06B6D4 (Cyan)
Tertiary: #10B981 (Teal)
Error: #EF4444 (Red)
Background: #0F172A (Dark Navy)
Surface: #1E293B (Navy)
```

---

## 📊 Database Entities

### MangaEntity
```
┌─────────────────┬──────────────────┐
│ Column          │ Type             │
├─────────────────┼──────────────────┤
│ id              │ LONG (PK)        │
│ title           │ TEXT             │
│ coverPath       │ TEXT (NULL)      │
│ progress        │ FLOAT (0-1)      │
│ currentChapter  │ INT              │
│ totalChapters   │ INT              │
│ isRead          │ BOOLEAN          │
│ isFavorite      │ BOOLEAN          │
│ dateAdded       │ TIMESTAMP        │
│ lastReadDate    │ TIMESTAMP (NULL) │
└─────────────────┴──────────────────┘
```

### TextBlockEntity
```
┌──────────────────┬──────────────────┐
│ Column           │ Type             │
├──────────────────┼──────────────────┤
│ id               │ LONG (PK)        │
│ chapterId        │ LONG (FK)        │
│ pageNumber       │ INT              │
│ text             │ TEXT             │
│ type             │ TEXT (dialog)    │
│ language         │ TEXT (ru/ja/en)  │
│ x, y             │ FLOAT (coords)   │
│ width, height    │ FLOAT (size)     │
│ fontSize         │ FLOAT            │
│ hasAudio         │ BOOLEAN          │
│ audioPath        │ TEXT (NULL)      │
│ ttsSpeed         │ FLOAT (default 1)│
│ ttsPitch         │ FLOAT (default 1)│
└──────────────────┴──────────────────┘
```

---

## 🔧 Конфигурация Dependencies

### build.gradle.kts (Версии)
```kotlin
compileSdk = 34
minSdk = 24
targetSdk = 34

// Core
androidx.core:core-ktx = 1.12.0
androidx.lifecycle:lifecycle-runtime-ktx = 2.6.2

// Compose
androidx.compose:compose-bom = 2023.10.01
androidx.compose.material3 = 1.1.2

// Room
androidx.room = 2.6.1

// ML Kit
com.google.mlkit:text-recognition = 16.0.0

// Archive
net.lingala.zip4j = 2.11.5

// DI (Hilt)
com.google.dagger:hilt-android = 2.48

// Logging
com.jakewharton.timber = 5.0.1
```

---

## 🔐 Требуемые Разрешения

```xml
<!-- Storage -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />

<!-- Network -->
<uses-permission android:name="android.permission.INTERNET" />

<!-- Camera (для OCR) -->
<uses-permission android:name="android.permission.CAMERA" />

<!-- Audio (для TTS) -->
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

---

## 🐛 Диагностика и Отладка

### Логирование
```kotlin
// Используется Timber для логирования
Timber.d("Debug message")
Timber.e(exception, "Error message")
Timber.w("Warning message")
```

### Проверка TTS инициализации
```kotlin
// В TtsService
if (!isReady) {
    Timber.w("TTS not ready yet")
    return
}
```

### Проверка OCR
```kotlin
// В OcrService
task.addOnFailureListener { exception ->
    Timber.e(exception, "OCR recognition failed")
}
```

---

## 📈 Performance Tips

### Оптимизация памяти
- Используется Coil для эффективного кэширования изображений
- LRU кэш для страниц манги
- Агрессивное управление памятью для больших изображений

### Асинхронность
```kotlin
// Все операции в ViewModel используют viewModelScope
viewModelScope.launch {
    mangaRepository.getAllManga().collect { mangas ->
        _mangaList.value = mangas
    }
}
```

### Кэширование
- Room database кэширует данные автоматически
- Compose помнит скомпилированные composables
- Coil кэширует загруженные изображения

---

## 🚨 Частые Проблемы и Решения

| Проблема | Причина | Решение |
|----------|---------|---------|
| OCR не распознаёт текст | Низкое качество изображения | Улучшить качество или пересоздать ZIP |
| TTS не работает | Язык не установлен | Установить языковой пакет в настройках ОС |
| Архив не открывается | Повреждённый файл | Проверить целостность, пересоздать архив |
| Приложение зависает | Большой размер архива | Использовать фоновые потоки (Coroutines) |
| БД не синхронизируется | Конфликт в Room | Использовать `@Transaction` для операций |

---

## 📞 Контакты Поддержки

- **GitHub**: https://github.com/mangatalkreader
- **Email**: support@mangatalkreader.dev
- **Issues**: https://github.com/mangatalkreader/issues

---

## 📄 Версионирование

**Текущая версия**: 1.0.0
**Дата релиза**: 2026-02-22
**Статус**: Production Ready

---

**Последнее обновление: 2026-02-22**
