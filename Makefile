# Builds
run:
	cd example && flutter run

# Format & Lint
format:
	flutter format . --line-length 999
lint:
	flutter analyze

# Testing
test:
	flutter test
.PHONY: test

# Clean project
clean:
	flutter clean
	flutter pub get

# Localization
translate:
	cd example && flutter gen-l10n
phrasepull:
	dart tools/phrasepull.dart
