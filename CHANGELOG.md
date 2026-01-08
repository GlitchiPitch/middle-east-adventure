# Changelog - Middle East Adventure RPG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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