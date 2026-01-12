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

## \[1.0.20] - 2026-01-11

### Added

* Comprehensive food item system with various consumables and effects
* Extensive potion system with recipes, effects, and alchemy requirements
* Detailed resource database including mushrooms, herbs, and crafting materials
* Enhanced item data structures with costs, effects, and crafting recipes

### Changed

* Expanded Food.luau with banana, ham, rice, fish, and other food items
* Updated Potion.luau with healing potions, mana potions, transformation potions, and antidotes
* Enhanced Resource.luau with complete mushroom, herb, and miscellaneous item collections
* Improved item data organization and accessibility

### Fixed

* Item data consistency and structure improvements
* Recipe and effect data validation

## [1.0.21] - 2026-01-11

### Added

* Version synchronization across all project files
* Enhanced project documentation structure
* Improved CHANGELOG.md formatting and organization
* Updated TODO.md with detailed task tracking

### Changed

* Synchronized game version from v1.0.20 to v1.0.21 across GameVersion.model.json and README.md
* Updated project completion status to ~45%
* Restructured documentation for better maintainability

### Fixed

* Version consistency issues across project files
* Documentation formatting and links

## [1.0.22] - 2026-01-11

### Added

* Version synchronization and documentation maintenance
* Enhanced project structure and version tracking
* Improved commit cycle with automated documentation updates

### Changed

* Updated game version from v1.0.21 to v1.0.22
* Refined documentation workflow and version management
* Enhanced project tracking and development planning

### Fixed

* Version consistency across all project files
* Documentation synchronization issues

## [1.0.23] - 2026-01-11

### Added

* Character customization system with appearance options
* Advanced combat mechanics with combo attacks and animations
* Dynamic quest system with branching storylines
* Mobile performance optimization and touch controls
* Enhanced UI/UX with modern design and accessibility
* Full ChestService integration with inventory persistence
* LecternService implementation for magical book interactions
* Complete TradeService with NPC merchant economies
* Comprehensive save/load system with cloud sync
* Achievement system with rewards and progression
* Food consumption integration with hunger mechanics
* Potion brewing with visual effects and animations

### Changed

* Improved service architecture and integration
* Enhanced performance across all platforms
* Updated UI components with modern design principles
* Expanded NPC interaction capabilities
* Optimized mobile device performance

### Fixed

* Various performance optimizations
* UI responsiveness improvements
* Service integration stability
* Mobile touch control enhancements

## [1.0.25] - 2026-01-12

### Added

* New AttributesUI component for displaying character attributes, experience, and defense stats
* Lectern usage tracking system to prevent repeated knowledge gains
* Ancient knowledge progression when interacting with lecterns

### Changed

* Restructured Attributes domain entity with nested table organization (attributes, exp, defense)
* Refactored InventoryUI to remove stats integration and focus on inventory management
* Enhanced PlayerProgress entity with usedLectern tracking
* Improved inventory slot management with automatic cleanup of zero-amount items
* Updated UI initialization to include new AttributesUI component

### Fixed

* Removed redundant StarterGui backpack disabling code
* Improved attribute data structure consistency across the application

## [1.0.24] - 2026-01-12

### Added

* Enhanced character customization with additional appearance options
* Advanced quest mechanics with complex branching storylines
* Multiplayer features and social interaction capabilities
* Comprehensive sound system with effects and background music
* Tutorial and onboarding system for new players
* Enhanced NPC AI with realistic behavior patterns
* Weather system and dynamic time cycles
* Mini-games and side activities
* Guild/clan system for social organization
* Advanced crafting recipes and blueprint system

### Changed

* Improved service architecture for better modularity
* Enhanced performance across all platforms
* Updated UI components with improved accessibility
* Expanded NPC interaction capabilities
* Optimized mobile device compatibility

### Fixed

* Performance optimizations for smoother gameplay
* UI responsiveness improvements
* Service integration stability enhancements
* Mobile touch control refinements

## [1.0.26] - 2026-01-12

### Added

* New EquipmentService for handling equipment-related operations and key bindings
* Enhanced EquipmentUI with real-time equipment display and slot management
* Equipment slot visualization with item images and key bindings (1-4 keys)
* Comprehensive equipment system integration with player service

### Changed

* Restructured Attributes domain entity with flattened structure for better performance
* Removed nested attributes table in favor of direct property access
* Enhanced Equipment domain with improved data organization
* Updated Weapon data with expanded weapon types and properties
* Improved service integration across InputService, InventoryService, and PlayerService
* Enhanced UI initialization and presentation layer organization

### Fixed

* Equipment slot management and visual updates
* Service dependency injection improvements
* Code optimizations across multiple service modules

## [1.0.27] - 2026-01-12

### Added

* Comprehensive weapon asset system with 3D models and images for all weapons
* New EquipmentService for server-side equipment operations and tool management
* Enhanced Equipment domain with weapon equipping functionality and improved slot management
* Client-side EquipItem use case for equipment operations
* Weapon tool equipping mechanics with automatic tool switching

### Changed

* Expanded Weapon.luau data with model references and image assets for all weapon types
* Refactored Equipment domain with flattened slot structure and equippedWeapon tracking
* Enhanced service integration across EquipmentService, InventoryService, and PlayerService
* Updated UseCases architecture with dependency injection for EquipItem functionality
* Improved weapon data organization with direct asset references

### Fixed

* Equipment slot management and weapon equipping logic
* Service initialization and dependency injection improvements
* Tool equipping/un-equipping mechanics for player characters

## [Unreleased]

### Planned

* Advanced inventory management system implementation
* Pet/companion system development
* Housing/building system creation
* Advanced magic system with spells
* Seasonal events and festivals
* Marketplace with player trading
* Skill specialization trees
* Dungeon crawling mechanics
* Boss battle encounters
* Reputation system

## [1.0.28] - 2026-01-12

### Added

* New Zone domain entity for location-based gameplay mechanics
* Workspace integration with MineZones, MobZones, and PlantsZones folders
* Enhanced project structure with proper Workspace configuration

### Changed

* Refactored EquipmentService setToolToPlayer method to use equippedWeapon directly
* Improved PlayerService with automatic backpack cleanup mechanism
* Updated Domain module to include Zone entity integration

### Fixed

* Equipment tool management and weapon equipping logic improvements
* Player service initialization and dependency injection enhancements

## \[1.0.19] - 2026-01-11

### Added

* Enhanced service integration framework
* Improved controller architecture stability
* Expanded service modules functionality

### Changed

* Updated service communication protocols
* Enhanced EventBus messaging system
* Improved service initialization and dependency management

### Fixed

* Service integration bugs and performance issues
* Controller stability improvements
* Code optimizations across all modules

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
