# Manga Talk Reader

Advanced Android application for reading manga/manhwa/webtoons with integrated OCR (Optical Character Recognition) and TTS (Text-to-Speech) technology.

## Features

### Core Features
- **📖 Multi-format Support**: ZIP, CBZ, CBR archives and image folders
- **🎤 Text-to-Speech**: Read manga in multiple languages (Russian, Japanese, English)
- **🔍 OCR Integration**: Automatic text recognition using Google ML Kit
- **🎯 Smart Text Detection**: Automatic classification of text blocks (dialogue, description, comments)
- **📚 Library Management**: Organize and track reading progress
- **🌐 Web Integration**: Built-in browser for online manga sources
- **💾 Collections**: Create custom manga collections

### Advanced Features
- Multi-language OCR (Russian, Japanese, English)
- Customizable TTS parameters (speed, pitch, volume)
- Multiple reading modes (Right-to-Left, Left-to-Right, Vertical)
- Archive page caching and optimization
- Tachiyomi backup compatibility
- Progress synchronization

## Technology Stack

### Core Architecture
- **Language**: Kotlin
- **UI Framework**: Jetpack Compose
- **Architecture Pattern**: MVVM
- **Dependency Injection**: Hilt

### Database & Storage
- **Database**: Room (SQLite)
- **Preferences**: DataStore
- **Archive Handling**: Zip4j

### AI & Vision
- **OCR**: Google ML Kit Text Recognition
- **TTS**: Android TextToSpeech API
- **Image Processing**: Coil

### Async & Reactive
- **Coroutines**: Kotlin Coroutines
- **Reactive Streams**: Flow, StateFlow

## Project Structure

```
manga-talk-reader/
├── app/
│   └── src/main/
│       ├── java/com/mytech/mangatalkreader/
│       │   ├── MainActivity.kt
│       │   ├── data/               # Data layer
│       │   │   ├── db/             # Room database
│       │   │   ├── repository/     # Data repositories
│       │   │   └── model/          # Data models
│       │   ├── domain/             # Business logic
│       │   │   └── service/        # OCR, TTS, Archive services
│       │   ├── ui/                 # Presentation layer
│       │   │   ├── screen/         # Compose screens
│       │   │   ├── viewmodel/      # ViewModels
│       │   │   ├── navigation/     # Navigation
│       │   │   └── theme/          # Material Design theme
│       │   └── di/                 # Dependency injection
│       └── res/                    # Resources
├── build.gradle.kts
├── settings.gradle.kts
└── README.md
```

## Installation

### Requirements
- Android Studio 2024.1.1+
- Android SDK 34+
- Kotlin 1.9.20+
- Java 17+

### Build APK

**Debug APK:**
```bash
./gradlew assembleDebug
```
Output: `app/build/outputs/apk/debug/app-debug.apk`

**Release APK:**
```bash
./gradlew assembleRelease
```

### Run on Device
```bash
./gradlew installDebug
adb shell am start -n com.mytech.mangatalkreader/.MainActivity
```

## Permissions Required

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.CAMERA" />
```

## Usage

### Adding Manga
1. Tap the FAB (+ button) in Library
2. Select "Import Archive" (ZIP/CBZ/CBR)
3. Choose file from storage
4. Manga will appear in your library

### Reading Manga
1. Select manga from library
2. Choose chapter to read
3. Use swipe or tap to navigate pages
4. Tap to toggle reader controls

### OCR & TTS
1. OCR automatically recognizes text on page load
2. Tap speaker icon to hear text
3. Customize settings in Settings screen
4. Adjust speed, pitch, language as needed

### Managing Library
- **Search**: Use search bar to find manga
- **Progress**: Track reading progress automatically
- **Collections**: Organize manga into custom collections
- **Favorites**: Mark important manga as favorites

## Settings

### Reader Settings
- Reading mode (RTL, LTR, Vertical)
- Show page numbers
- Keep screen on
- Auto-fit content

### TTS Settings
- Speech speed (0.5x - 2.0x)
- Pitch/tone adjustment
- Language selection
- Volume control

### OCR Settings
- Language selection (RU, JA, EN)
- Detection sensitivity
- Minimum text size filter
- Balloon highlighting

## Database Schema

### Tables
- **manga** - Main manga entries
- **chapter** - Individual chapters
- **text_block** - Recognized text blocks
- **collection** - User collections
- **source** - Web sources
- **manga_collection_cross** - Many-to-many relationship

## API Reference

### OcrService
```kotlin
suspend fun recognizeText(bitmap: Bitmap): List<TextBlock>
```
Recognizes text in image and returns list of text blocks.

### TtsService
```kotlin
fun speak(text: String, language: String, speed: Float, pitch: Float)
fun stop()
fun isSpeaking(): Boolean
```
Controls text-to-speech playback.

### ArchiveService
```kotlin
suspend fun extractPages(archivePath: String, outputDir: String): List<String>
suspend fun getArchiveInfo(archivePath: String): ArchiveInfo
fun getImageList(folderPath: String): List<String>
```
Handles archive extraction and page management.

## Troubleshooting

### OCR Not Working
- Ensure image quality is good
- Check ML Kit models are installed
- Verify camera permission is granted

### TTS Issues
- Confirm language is installed on device
- Check volume settings
- Restart application

### Archive Problems
- Use standard ZIP/CBZ formats
- Avoid nested archives
- Check file integrity

## Future Roadmap

- [ ] Cloud synchronization
- [ ] Community sharing
- [ ] Character-specific voice synthesis
- [ ] Advanced translation integration
- [ ] Offline mode improvements
- [ ] Performance optimization
- [ ] Dark mode enhancements

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## Documentation

See [SOURCE_CODE_BACKUP.md](./SOURCE_CODE_BACKUP.md) for complete source code documentation.

### Additional Resources
- [Google ML Kit Documentation](https://developers.google.com/ml-kit)
- [Jetpack Compose Guide](https://developer.android.com/jetpack/compose)
- [Room Database](https://developer.android.com/training/data-storage/room)
- [Hilt Dependency Injection](https://developer.android.com/training/dependency-injection/hilt-android)

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## Support

For issues and questions:
- GitHub Issues: [Report bug](https://github.com/mangatalkreader/issues)
- Email: support@mangatalkreader.dev
- Documentation: [Full Docs](./SOURCE_CODE_BACKUP.md)

## Changelog

### Version 1.0.0 (2026-02-22)
- Initial release
- Full OCR integration
- TTS support for multiple languages
- Library management
- Archive handling (ZIP, CBZ)
- Material Design 3 UI

---

**Made with ❤️ for manga fans**

Last Updated: 2026-02-22
