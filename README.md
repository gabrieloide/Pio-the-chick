<p align="center">
  <img src="https://img.shields.io/badge/Godot-4.6-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white" alt="Godot 4.6"/>
  <img src="https://img.shields.io/badge/GDScript-Game_Logic-355570?style=for-the-badge&logo=godot-engine&logoColor=white" alt="GDScript"/>
  <img src="https://img.shields.io/badge/Jolt-Physics-FF6600?style=for-the-badge" alt="Jolt Physics"/>
  <img src="https://img.shields.io/badge/Platform-Web_|_Windows_|_macOS_|_Linux-4CAF50?style=for-the-badge" alt="Platforms"/>
  <img src="https://img.shields.io/badge/Game_Jam-Global_Game_Jam-E91E63?style=for-the-badge" alt="Game Jam"/>
</p>

# 🐣 Pio The Chick

> **A 3D top-down dungeon crawler where a brave chick dons powerful masks to battle through procedurally generated dungeons.**

Built in **48 hours** for the **Global Game Jam** by a multidisciplinary team of 4.

---

## 🎮 Gameplay

You play as **Pio**, a small but fierce chick navigating procedurally generated dungeon floors. Before each run, you visit a **shop** to equip **masks** that completely change your combat style, and buy **power-ups** to boost your stats. Then you head into the dungeon — clearing rooms of enemies, collecting coins, and fighting your way to the **boss**.

### Core Loop

```
🏪 Shop  →  ⚔️ Dungeon Rooms  →  💀 Boss Fight  →  🏆 Victory  →  🔄 Return to Shop
```

- **Masks** define your attack type (ranged, short/medium/long melee) and base stats
- **Power-ups** stack on top of your mask, boosting damage, speed, and range
- **Coins** drop from enemies and are spent in the shop between runs
- **Death** resets your power-ups — but owned masks persist

---

## ⚔️ Combat System

The combat is built around a **state-machine attack manager** with 4 distinct weapon types, each tied to a different mask:

| Mask Type | Attack Style | Description |
|-----------|-------------|-------------|
| 🔵 **Distance** | Ranged projectile | Fires bullets at enemies from afar |
| 🟢 **Melee Short** | Twin strikes | Fast double-hit swipes at close range |
| 🟡 **Melee Medium** | Sweeping arc | Balanced range and speed |
| 🔴 **Melee Long** | Heavy cleave | Wide reach, slower hits |

Each mask also **changes the chick's color** dynamically via material overrides, giving clear visual feedback of your current build.

**Additional combat mechanics:**
- **Dash** — Quick burst of speed with i-frame potential (Space bar)
- **Twin-stick aiming** — Move with WASD, aim attacks with Arrow Keys
- **Health recovery** — Entering a new room heals you slightly

---

## 🏰 Procedural Dungeon Generation

The dungeon system uses a **grid-based floor plan** with seeded RNG:

- A `10×10` grid of rooms is generated per run
- Each room is randomly populated with enemies from a configurable **Room Registry**
- **Spawn room** and **Boss room** are placed at random non-overlapping positions
- Rooms lock their **doors** until all enemies are defeated
- **Smooth camera transitions** with cubic easing animate room changes
- Camera dynamically adjusts its orthographic size to fit each room

---

## 👾 Enemies

| Enemy | Behavior | Description |
|-------|----------|-------------|
| 🐛 **Bug** | Melee | Charges directly at the player |
| 🐌 **Snail** | Melee | Slow but persistent stalker |
| 🐛 **Worm** | Ranged | Keeps distance, fires projectiles; retreats when player gets too close |
| 🦔 **Mole** | Melee | Standard close-combat enemy |
| 👹 **Boss** | Multi-phase | 3-stage fight with evolving attack patterns |

### Boss Fight (3 Phases)

The boss encounter is a multi-phase fight with health thresholds:

1. **Phase 1** (100%–80% HP) — Melee charges at the player
2. **Phase 2** (80%–40% HP) — Rapid dashes + 3-bullet spread shots
3. **Phase 3** (40%–0% HP) — Slower movement, heavy single projectiles

The boss becomes **temporarily immortal** during phase transitions and plays unique audio cues.

---

## 🏪 Shop System

Between dungeon runs, the player visits an interactive 3D shop:

- **Mask Vendors** — Walk up to a mask stand, preview stats, and buy/equip masks
- **Power-Up Vendors** — Browse stackable upgrades (damage, speed, range, movement)
- **Economy** — Coins earned from killing enemies; prices scale with power
- **Typewriter text animation** for item descriptions
- **First-time tutorial** overlay for new players

---

## 🛠️ Technical Highlights

| Feature | Implementation |
|---------|---------------|
| **Attack State Machine** | `AttackManager` + `AttackBase` class hierarchy with polymorphic `perform_specific_attack()` |
| **Procedural Generation** | Seeded RNG floor plan with configurable room registries and enemy pools |
| **Component Health System** | Reusable `Health` node with signals (`health_changed`, `destroyed`) |
| **Hit Flash VFX** | Dynamic material duplication + emission tweening on enemy damage |
| **EventBus Architecture** | Global signal bus for decoupled UI updates |
| **Dynamic Music** | `Audio` autoload with theme switching (Menu ↔ Dungeon) |
| **Jolt Physics** | High-performance 3D physics via Jolt engine integration |
| **Navigation AI** | `NavigationAgent3D` for pathfinding; ranged enemies use retreat logic |
| **Multi-platform Export** | Web, Windows (x64/ARM), macOS (Universal), Linux (x64/ARM) |

---

## 🗂️ Project Architecture

```
ggj.project/
├── entities/
│   ├── player/          # Player controller, attack states, attack manager
│   ├── enemies/         # Enemy base class, melee/ranged AI, boss logic
│   ├── bullet/          # Projectile system with friendly-fire prevention
│   └── health/          # Reusable health component
├── scenes/
│   ├── main/            # Main menu, game scene (shop → dungeon flow)
│   ├── dungeon/         # Procedural dungeon generator & room transitions
│   ├── rooms/           # Room templates, door logic, room registry
│   └── shop/            # Shop scene, mask/power-up vendors
├── globals/             # Autoloads: GameState, Audio, EventBus, GlobalHUD
├── ui/                  # HUD, health bars, pause menu, win screen
├── assets/              # 3D models (GLB), textures, audio files
├── sounds/              # SFX library (60+ sound effects)
└── fonts/               # Early GameBoy pixel font
```

---

## 🎨 Art & Audio

- **3D low-poly art style** with custom animated chick model
- **Pixel font** (Early GameBoy) for retro UI feel
- **60+ custom SFX** covering attacks, enemy sounds, UI interactions, footsteps, and ambient effects
- **Dynamic soundtrack** that switches between menu and dungeon themes
- **Per-attack-type pitch randomization** for organic sound variation

---

## 🚀 Getting Started

### Prerequisites

- [Godot 4.6](https://godotengine.org/download) (GL Compatibility renderer)

### Running Locally

1. Clone the repository:
   ```bash
   git clone https://github.com/gabrieloide/Pio-the-chick.git
   cd ggj
   ```
2. Open `ggj.project/project.godot` in Godot 4.6
3. Press **F5** to run the game

### Controls

| Action | Key |
|--------|-----|
| Move | `W` `A` `S` `D` |
| Aim / Attack | `↑` `←` `↓` `→` (Arrow Keys) |
| Dash | `Space` |
| Pause | `Escape` |

---

## 👥 Team

| Member | Role |
|--------|------|
| **WhiteStorm** | Programming & Game Design |
| **Gabriel** | Programming |
| **Andrzej Manderla** | Programming |
| **Marco Rios** | Sound Design & SFX |

---

## 📝 License

This project was created for the **Global Game Jam**. All rights reserved by the respective contributors.
