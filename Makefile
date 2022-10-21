# Builds
run:
	cd example && flutter run

# Format & Lint
format:
	flutter format . --line-length 999

lint:
	flutter analyze

# Testing
int-test:
	cd example && flutter drive --driver=integration_test/driver.dart --target=integration_test/main_test.dart --keep-app-running

int-test-watch:
	cd example && flutter run integration_test/main_test.dart

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