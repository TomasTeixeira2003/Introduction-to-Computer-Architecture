# Road Survival: Car & Water Simulation

This repository contains a low-level simulation developed in **Assembly (PEPE 16-bit architecture)**.

## Project Overview

In **Road Survival**, you navigate a car through a constant stream of oncoming traffic. The primary challenge is balancing your speed and movement against a depleting water supply, which serves as your vehicle's "fuel" or energy.

### Core Mechanics

* **The Vehicle**: A car positioned at the bottom of a $32 \times 64$ pixel display.
* **The Hazards**: Incoming cars (75% spawn rate) that move from the top to the bottom, increasing in size as they approach to simulate perspective. A single collision results in an immediate game over.
* **The Resource (Water)**: 
    * **Consumption**: Water levels drop by 5% every 3 seconds.
    * **Action Cost**: Using special maneuvers or items consumes 5% water.
    * **Replenishment**: Collect "Water Supply" items (green indicators, 25% spawn rate) to gain +10% water.
    * **Survival**: The game ends if the water level reaches 0%.

## Technical Specifications

The project is built to interface directly with hardware peripherals via memory-mapped I/O:

* **Processor**: PEPE (16-bit RISC-style architecture).
* **Graphics**: $32 \times 64$ monochrome/color-mapped display via the MediaCenter module.
* **Timing**: Three independent hardware timers manage the asynchronous movement of traffic, player actions, and resource decay.
* **Input**: 4x4 Matrix Keyboard handled via polling and debouncing.
* **Output**: Three 7-segment displays show the real-time water percentage in decimal.

## Controls

| Key | Function |
| :--- | :--- |
| **0** | Steer Left |
| **2** | Steer Right |
| **1** | Use Item / Action |
| **C** | Start / Restart Simulation |
| **D** | Pause / Resume |
| **E** | Terminate Simulation |

## Memory Map

| Peripheral | Address |
| :--- | :--- |
| **System RAM** | `0000H` – `3FFFH` |
| **MediaCenter (Video RAM)** | `8000H` – `8FFFH` |
| **MediaCenter (Commands)** | `6000H` – `6063H` |
| **7-Segment Displays (POUT-1)** | `0A000H` |
| **Keyboard Output (POUT-2)** | `0C000H` |
| **Keyboard Input (PIN)** | `0E000H` |

## How to Run

1.  Open the **PEPE Simulator**.
2.  Load the `.asm` assembly file.
3.  Ensure the **MediaCenter** and **7-Segment Display** windows are active.
4.  Press `C` on the simulated keyboard to begin the drive.
