.DEFAULT_GOAL := help

help:
	@dart tools/make.dart 'help'


# ------------------------------------------------------------
run: ## Startet die App
	@cd example && flutter run


# ------------------------------------------------------------
format: ## Formatiert und bereinigt alle Files. https://docs.flutter.dev/development/tools/formatting, https://dart.dev/tools/dart-fix
	@flutter format . --line-length 999
	@dart fix --apply

lint: ## Analysiert den Code und zeigt (Formatierungs-)Probleme unter Berücksichtigung von analysis_options.yaml
	@flutter analyze


# ------------------------------------------------------------
tests: ## Führt die Integrationstests EINMALIG aus.
	@cd example && flutter test integration_test/main_test.dart

tests-watch: ## Führt die Integrationstests aus und wartet dann auf [SHIFT + R] für einen erneuten Lauf. 
	@cd example && flutter run integration_test/main_test.dart

unit-tests: ## Führt die Unit-Tests aus. Genauer: alle Dateien mit folgendem Muster: /test/**_test.dart
	@flutter test
.PHONY: test


# ------------------------------------------------------------
clean: ## Bereinigt den Projekt-Cache. Löscht die temporären Projekt-Ordner und -Dateien (z.B. .dart_tools) und erstellt diese neu
	@flutter clean
	@flutter pub get
	@cd example && flutter clean
	@cd example && flutter pub get
	@flutter analyze


# ------------------------------------------------------------
translate: ## Kompiliert die ARB-Dateien zu dart Dateien, die Flutter bei Übersetzungen ausführt
	@cd example && flutter gen-l10n

phrasepull: ## Lädt die Sprachdateien von phrase.com und speichert sie als ARB Dateien ab.
	@dart tools/make.dart 'phrasepull'
