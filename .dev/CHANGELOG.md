# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## \[1.0.17] - 2025-01-11

### Added

* Smithing/blacksmithing system with SmithService and SmithUI
* Controller architecture with CameraController, SprintController, and TargetController
* Enhanced service organization and modularity

### Changed

* Restructured services: moved CameraService, SprintService, and TargetService to Controllers
* Updated service initialization and dependency injection
* Improved UI management and presentation layer
* Enhanced EventBus communication between services

### Fixed

* Various bug fixes and code improvements across services

## \[Unreleased]

### Planned

* Character customization system
* Advanced combat mechanics
* More NPC interactions and quests
* Mobile performance optimization

## \[1.0.18] - 2026-01-11

### Added

* New service modules: ChestService, LecternService, TradeService
* Enhanced controller architecture with improved CameraController and TargetController
* Expanded service functionality across multiple modules

### Changed

* Updated AlchemyService, DialogService, InputService, InteractService, InventoryService
* Improved LootService, PlayerService, SmithService, and ToolService functionality
* Enhanced UI components: AlchemyUI, SmithUI, and UIManager
* Updated Constants.luau and sourcemap.json for better compatibility

### Fixed

* Various bug fixes and performance improvements across services
* Code optimizations and service integration improvements

## \[1.0.17] - 2025-01-11

### Added

* Enhanced dialog system with cycling conversations
* Improved NPC interaction mechanics
* Seller NPC type with dedicated dialog options

### Changed

* Updated DialogService with better dialog flow management
* Improved EventBus communication between services
* Enhanced AlchemyService functionality
* UI improvements in DialogUI and Presentation layer

### Fixed

* Dialog cache management and cleanup
* Player control toggling during conversations

## \[1.0.15] - 2025-01-10

### Added

* Dialogs.luau data file for NPC conversations
* Documentation structure with .dev/ folder
* CHANGELOG.md and TODO.md for project tracking

### Changed

* Updated game version to v1.0.15
* Various service improvements (Alchemy, Camera, Dialog, Input, Player, Target, Tool)
* UI enhancements (AlchemyUI, DialogUI, StatsUI, UIManager)
* Updated Constants.luau and Types.luau

### Fixed

* Various bug fixes and code improvements

## \[1.0.14] - 2024-01-XX

* Initial release with core gameplay features
