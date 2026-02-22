# Manga Talk Reader - Полное Руководство по Сборке

## 📋 Общая информация

**Приложение**: Manga Talk Reader v1.0.0
**Тип**: Native Android Application
**Язык**: Kotlin
**API минимум**: 24 (Android 7.0)
**API цель**: 34 (Android 14)
**Размер APK**: ~45-50 MB (примерно)

---

## ✅ Требования для сборки

### Обязательное:
- **Android Studio**: 2024.1.1 или новее
- **Android SDK**: Level 34
- **Build Tools**: 34.0.0+
- **Java JDK**: 17 или новее
- **Kotlin**: 1.9.20
- **Gradle**: 8.2.0

### Опционально:
- Physical Android device (API 24+)
- Android emulator (минимум 2GB RAM)

### Система:
- RAM: минимум 8GB (рекомендуется 16GB)
- Disk: 10GB свободного места
- Internet: для загрузки dependencies

---

## 🛠️ Пошаговая установка и сборка

### Шаг 1: Подготовка окружения

1. **Установить Android Studio**
   - Скачать с https://developer.android.com/studio
   - Установить для вашей ОС (Windows/Mac/Linux)

2. **Установить Android SDK**
   - Открыть Android Studio
   - Tools → SDK Manager
   - Установить API 34 и Build Tools 34.0.0
   - Установить Emulator для тестирования

3. **Установить Java JDK 17**
   ```bash
   # Windows
   Set-Path "C:\Program Files\Java\jdk-17\bin" -Scope User

   # macOS/Linux
   export JAVA_HOME=/usr/libexec/java_home -v 17
   export PATH=$JAVA_HOME/bin:$PATH
   ```

### Шаг 2: Клонирование проекта

```bash
# Клонировать репозиторий
git clone https://github.com/mangatalkreader/manga-talk-reader.git
cd manga-talk-reader

# Или если у вас есть архив
unzip manga-talk-reader-main.zip
cd manga-talk-reader-main
```

### Шаг 3: Открытие в Android Studio

1. Запустить Android Studio
2. File → Open
3. Выбрать корневую папку проекта
4. Нажать "Open"
5. Дождаться индексирования файлов

### Шаг 4: Синхронизация Gradle

```bash
# Автоматическая синхронизация (обычно происходит сама)
# Если нет, то выполнить вручную:
./gradlew clean
./gradlew build
```

---

## 🔨 Сборка APK

### Вариант 1: Debug APK (для разработки)

```bash
# Через консоль
./gradlew assembleDebug

# Результат: app/build/outputs/apk/debug/app-debug.apk
# Размер: ~45 MB
# Подписание: Автоматическое (debug key)
# Установка: ./gradlew installDebug
```

**Используется для:**
- Локальное тестирование
- Отладка
- Быстрое развёртывание

### Вариант 2: Release APK (для публикации)

```bash
# Через консоль
./gradlew assembleRelease

# Результат: app/build/outputs/apk/release/app-release-unsigned.apk
# Размер: ~35 MB (минифицирован)
# Требует подписание
```

**Процесс подписания:**

1. **Создать keystore (если нет)**
   ```bash
   keytool -genkey -v -keystore my-release-key.keystore \
     -keyalg RSA -keysize 2048 -validity 10000 \
     -alias my-key-alias
   ```

2. **Подписать APK**
   ```bash
   jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 \
     -keystore my-release-key.keystore \
     app/build/outputs/apk/release/app-release-unsigned.apk \
     my-key-alias
   ```

3. **Оптимизировать (zipalign)**
   ```bash
   zipalign -v 4 \
     app/build/outputs/apk/release/app-release-unsigned.apk \
     app-release.apk
   ```

### Вариант 3: Bundle (для Google Play)

```bash
./gradlew bundleRelease

# Результат: app/build/outputs/bundle/release/app-release.aab
# Размер: ~30 MB (после оптимизации)
```

---

## 📱 Установка и запуск

### На эмуляторе

```bash
# 1. Запустить эмулятор
emulator -avd Nexus_5_API_34

# 2. Убедиться, что устройство подключено
adb devices

# 3. Установить приложение
./gradlew installDebug

# 4. Запустить приложение
adb shell am start -n com.mytech.mangatalkreader/.MainActivity

# 5. Просмотр логов
adb logcat -s "MangaTalkReader"
```

### На физическом устройстве

```bash
# 1. Включить USB Debugging в разработчика на устройстве
# Settings → About Phone → Build Number (нажать 7 раз)
# Settings → Developer Options → USB Debugging

# 2. Подключить устройство USB кабелем

# 3. Проверить подключение
adb devices

# 4. Установить
./gradlew installDebug

# 5. Запустить
adb shell am start -n com.mytech.mangatalkreader/.MainActivity
```

---

## 🧪 Тестирование

### Запуск всех тестов

```bash
./gradlew test
```

### Запуск инструментированных тестов

```bash
./gradlew connectedAndroidTest
```

### Проверка покрытия кода

```bash
./gradlew jacocoTestReport
# Результат: app/build/reports/jacoco/index.html
```

### Статический анализ кода (Lint)

```bash
./gradlew lint
# Результат: app/build/reports/lint-results.html
```

---

## 🔍 Проверка перед публикацией

### Checklist

- [ ] Все тесты проходят: `./gradlew test`
- [ ] Нет lint ошибок: `./gradlew lint`
- [ ] Build успешно компилируется: `./gradlew build`
- [ ] Release APK создан и подписан
- [ ] Версионирование обновлено (versionCode, versionName)
- [ ] Иконки и ресурсы добавлены
- [ ] Permissions в AndroidManifest.xml корректны
- [ ] Privacy Policy подготовлена
- [ ] App Store Listing готов

### Version Codes

```kotlin
// Обновлять для каждого релиза (build.gradle.kts)
versionCode = 1  // Увеличивать для каждого выпуска
versionName = "1.0.0"  // Semantic versioning
```

---

## 📦 Структура выходных файлов

### После успешной сборки

```
app/build/outputs/
├── apk/
│   ├── debug/
│   │   ├── app-debug.apk
│   │   └── app-debug.apk.asc (if signed)
│   └── release/
│       ├── app-release-unsigned.apk
│       └── app-release.apk (if signed)
├── bundle/
│   └── release/
│       └── app-release.aab
└── logs/
    └── manifest-merger-release-report.txt
```

### Размеры файлов

| File | Size | Notes |
|------|------|-------|
| app-debug.apk | ~45 MB | Для разработки |
| app-release-unsigned.apk | ~38 MB | Требует подписания |
| app-release.apk | ~35 MB | Оптимизирован и подписан |
| app-release.aab | ~30 MB | Для Google Play |

---

## 🐛 Troubleshooting (Решение проблем)

### Проблема: "SDK не найден"
```
Решение:
1. File → Project Structure
2. SDK Location → выбрать путь к Android SDK
3. Sync Now
```

### Проблема: "Gradle версия несовместима"
```
Решение:
./gradlew wrapper --gradle-version=8.2.0
```

### Проблема: "OutOfMemoryError при сборке"
```
Решение:
# gradle.properties
org.gradle.jvmargs=-Xmx4096m
```

### Проблема: "Duplicate class com.google...."
```
Решение:
# В build.gradle.kts
packagingOptions {
    exclude 'META-INF/proguard/androidx-*.pro'
}
```

### Проблема: "Cannot find app-debug.apk"
```
Решение:
./gradlew clean assembleDebug
```

### Проблема: "Installation failed: insufficient storage"
```
Решение:
adb shell pm clear com.mytech.mangatalkreader
./gradlew installDebug
```

---

## 🚀 Оптимизация сборки

### Скоростная сборка

```bash
# Отключить встроенные тесты
./gradlew assembleDebug -x test

# Использовать только один CPU
./gradlew assembleDebug -x test --no-parallel
```

### Настройка gradle.properties

```properties
# gradle.properties
org.gradle.jvmargs=-Xmx4096m
org.gradle.parallel=true
org.gradle.caching=true
org.gradle.configureondemand=true
android.enableBuildCache=true
```

### Минификация (Release)

```kotlin
// build.gradle.kts
buildTypes {
    release {
        isMinifyEnabled = true
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
}
```

---

## 📊 Размеры и производительность

### Компонеры APK (Debug)

```
- Code (DEX): ~8 MB
- Resources: ~15 MB
- Assets: ~8 MB
- Libraries: ~12 MB
- Overhead: ~2 MB
= Total: ~45 MB
```

### Компонеры APK (Release)

```
- Code (DEX): ~3 MB (минифицирован)
- Resources: ~12 MB (оптимизирован)
- Assets: ~8 MB
- Libraries: ~10 MB
- Overhead: ~2 MB
= Total: ~35 MB
```

---

## 🔐 Безопасность

### Перед публикацией

1. **Проверить API ключи**
   - Убедиться, что API ключи для ML Kit настроены правильно
   - Не коммитить чувствительные данные

2. **ProGuard/R8 минификация**
   - Включена для Release
   - Защищает код от reverse engineering

3. **Подписание APK**
   - Использовать надёжный пароль для keystore
   - Хранить keystore в безопасном месте
   - Никогда не коммитить keystore в git

4. **Permissions**
   - Запрашивать только необходимые разрешения
   - Обрабатывать отказы пользователя

---

## 📝 Документация

### Версионирование
- Текущая версия: **1.0.0**
- Формат: Semantic Versioning (MAJOR.MINOR.PATCH)
- Обновляется в: `build.gradle.kts`

### Changelog

```
## 1.0.0 (2026-02-22)
- Initial release
- Full OCR integration
- TTS support
- Multi-language support
- Library management
- Archive handling
```

---

## 📞 Поддержка

- **GitHub Issues**: https://github.com/mangatalkreader/issues
- **Documentation**: Смотри SOURCE_CODE_BACKUP.md
- **Email**: support@mangatalkreader.dev

---

## ✨ Дополнительные ресурсы

- [Android Official Docs](https://developer.android.com)
- [Kotlin Documentation](https://kotlinlang.org/docs)
- [Jetpack Compose Guide](https://developer.android.com/jetpack/compose/documentation)
- [Google Play Console](https://play.google.com/console)

---

**Последнее обновление: 2026-02-22**
**Версия документации: 1.0**
