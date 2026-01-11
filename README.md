# Middle East Adventure

An RPG game. A story about a nameless hero who must stop the apocalypse.

**Version:** v1.0.21 | **Status:** In Development | **Completion:** ~45%

## Description

The game features a variety of activities, including hunting, fishing, collecting, combat, and much more. Level up your hero and find a way to stop the disaster.

## Links

- [Project TODO](./.dev/TODO.md)
- [Changelog](./.dev/CHANGELOG.md)

## Development Status

### ✅ Completed Systems
- **Clean Architecture**: Client/Server/Shared separation implemented
- **Core Client Services**: 7/8 services complete (Animation, Camera, Input, Sprint, Tool, Player, Inventory)
- **Domain Models**: 8/10 entities complete (Player, Inventory, Equipment, Skills, Stats, OneHanded, TwoHanded, Cloth)
- **UI Framework**: Basic combat, inventory, stats, and equipment interfaces
- **Equipment System**: Equipment slot management with keyboard shortcuts (1,2,3,4)

### 🔄 Current Sprint (v1.1.0)
- Combat system integration with server-side logic
- Inventory management and persistence
- Player-to-player trading system
- Health/damage mechanics implementation

### 📋 Planned Features
- Advanced crafting systems (Alchemy, Smithing)
- Hunting and fishing mini-games
- Magic system implementation
- Multiplayer features and world exploration


## Project Structure

This project follows Clean Architecture principles, organized into three main layers:

### Client

* **Application**: Business logic for client-side features
* **Infrastructure**: Data access and external service integrations
* **Presentation**: UI components and user interaction handling

### Server

* **Application**: Server-side business logic and game services
* **Infrastructure**: Server data persistence and external integrations

### Shared

* **Application**: Common use cases and commands
* **Domain**: Core business entities and rules
* **Infrastructure**: Shared services and utilities
* **Data**: Game configuration and static data
* **Config/Constants/Types**: Shared configuration and type definitions

## Game Mechanics

### Character Progression

* **Attributes**: Strength, Dexterity, Ancient Knowledge, Blacksmith, Thief, Alchemy, Health, Stamina, Mana
* **Skills System**: Combat, Magic, Hunting, Thief, Alchemy, Smithing, and Misc skills
* **Experience & Leveling**: Gain experience through activities to unlock new abilities

### Combat System

* **Weapon Types**: One-handed swords, Two-handed weapons, Staffs, Bows, Crossbows
* **Damage Types**: Hit, Blade damage with different effectiveness against enemies
* **Requirements**: Weapons require specific attribute levels and skill training
* **Special Effects**: Some weapons have bonuses like Orc Slayer or mana regeneration

### Professions & Skills

#### Combat Skills

* **Sword Fighter**: Master one-handed blade weapons
* **Heavy Weapon**: Two-handed weapons specialization
* **Bowman**: Ranged combat expertise
* **Recovery**: Combat healing abilities

#### Magic Skills

* **Black Magician**: Dark magic specialization
* **Fire Magician**: Fire-based spells and effects
* **Staff Fight**: Magic weapon combat

#### Hunting Skills

* **Game Hunter**: Increased damage to animals
* **Silent Hunter**: Animals don't flee from you
* **Extraction**: Harvest animal parts (teeth, claws, horns)
* **Animal Skinning**: Process hides for crafting

#### Thief Skills

* **Lock Breaking**: Simple, Complex, and Impossible lock picking

#### Alchemy Skills

* **Potion Brewing**: Healing potions, mana potions, long-duration effects
* **Transmutation**: Transform materials
* **Poison Crafting**: Create various poisons
* **Elemental Enhancement**: Poisoned, Fire, Frost blades and arrows

#### Smithing Skills

* **Weapon Forging**: Create weapons from ore and pure ore
* **Ore Mining**: Extract raw materials
* **Blade Sharpening**: Enhance weapon effectiveness
* **Armor Enhancement**: Improve defensive equipment

### Resource Gathering

* **Hunting**: Track and hunt various animals for meat, skins, and rare drops
* **Fishing**: Catch fish for food and materials
* **Mining**: Extract ores for smithing and crafting

### Crafting Systems

* **Alchemy Lab**: Brew potions, poisons, and enchant weapons with elemental effects
* **Smithy**: Forge weapons and armor from mined ores
* **Crafting**: Combine materials to create equipment and tools

### Economy & Trading

* **Trading System**: Buy and sell goods with NPCs and other players
* **Market Prices**: Dynamic pricing based on supply and demand
* **Currency**: Gold coins earned through quests, sales, and activities

## Development

### Prerequisites
- Roblox Studio
- Aftman (for Lua tooling)
- Git

### Getting Started
1. Clone the repository
2. Open the project in Roblox Studio using `default.project.json`
3. Install dependencies: `aftman install`
4. Run static analysis: `selene src/`

### Architecture Overview
This project follows Clean Architecture principles to ensure maintainable and testable code:

- **Domain Layer**: Contains business logic and entities
- **Application Layer**: Use cases and service orchestration
- **Infrastructure Layer**: External concerns (data persistence, APIs)
- **Presentation Layer**: UI and user interaction

### Code Quality
- Lua type checking with EmmyLua annotations
- Static analysis with Selene
- Clean Architecture patterns for maintainability
