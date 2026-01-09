# Changelog - Middle East Adventure RPG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.11] - 2026-01-09

### Added
- Advanced lock-on camera system with head tracking and target switching
- EventBus event type definitions for better type safety
- Equipment key input handling through modular InputService architecture

### Changed
- Complete CameraService rewrite with sophisticated lock-on mechanics and smooth target tracking
- Enhanced InputService with cleaner modular structure and equipment key support
- Improved EventBus with proper event name typing and documentation
- Updated UI initialization to support new player data update events

### Fixed
- Corrected typo "posioned" to "poisoned" in Stats domain entity
- Fixed StatsUI debug print statement for better development experience

### Development
- Camera system architecture significantly improved for combat gameplay
- Input handling infrastructure enhanced for equipment management
- Event-driven architecture strengthened with proper type definitions

## [1.0.10] - 2026-01-09

### Added
- Equipment key bindings (1,2,3,4) with EventBus integration
- EquippedSlotsService foundation for equipment slot management
- Modular input handler methods in InputService
- Enhanced PlayerService with equipment data integration

### Changed
- Refactored InputService with cleaner modular architecture and equipment key support
- Enhanced PlayerService to support equipment domain entities
- Updated service initialization with improved EventBus integration
- Improved domain models for OneHanded, TwoHanded, Cloth equipment types

### Fixed
- Equipment system integration with player data structures

### Development
- Equipment system foundation solidified
- Input handling architecture improved for extensibility

## [1.0.9] - 2026-01-08

### Added
- EquippedSlotsService for equipment slot management with keyboard shortcuts
- EventBus service for inter-service communication
- Equipment key bindings (1,2,3,4) in client configuration
- New domain entities: OneHanded, TwoHanded, Cloth weapons/armor

### Changed
- Refactored InputService with modular handler methods and equipment key support
- Replaced Sword domain with specialized weapon/armor domain entities
- Enhanced service initialization with EventBus integration

### Development
- Equipment system foundation implemented
- Domain architecture expanded for different equipment types

## [1.0.6] - 2026-01-XX

### Added
- Initial camera service implementation with basic lock-on functionality
- Core architecture setup with Client/Server/Shared separation
- Domain entities foundation (Player, Inventory, Equipment, Skills, Stats)
- Basic service structure for all game systems

### Changed
- Project restructuring with Clean Architecture principles
- Improved code organization and maintainability

### Development
- Comprehensive project analysis completed
- Development roadmap established with 15 major implementation tasks
- Initial TODO.md created for task tracking
