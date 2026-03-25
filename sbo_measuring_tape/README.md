# Simple Tape Measure [tape_measure]
 
 [![luacheck](https://github.com/OgelGames/tape_measure/workflows/luacheck/badge.svg)](https://github.com/OgelGames/tape_measure/actions)
[![License](https://img.shields.io/badge/License-MIT%20and%20CC%20BY--SA%204.0-green.svg)](LICENSE.md)
[![Minetest](https://img.shields.io/badge/Minetest-5.0+-blue.svg)](https://www.minetest.net)
[![ContentDB](https://content.minetest.net/packages/OgelGames/tape_measure/shields/downloads/)](https://content.minetest.net/packages/OgelGames/tape_measure/)

## Overview

A simple tape measure for Skyblock: Zero.

## Usage

Punch a node to set the start position, punch another node to set the end position. The distance and size will be displayed in chat.

The distance is the real vector distance between the two positions. The size is the dimensions in nodes of a imaginary box that contains both points.

You can also right-click a node to set a temporary waypoint, which can be useful for larger measurements. Waypoints can be cleared by right-clicking the same position, or by right-clicking while not pointing at a node.

If you hold sneak while setting a position or waypoint, the position of the adjacent node will be used instead. If you hold the "special" key, your player position will be used.

## License

Except for any exceptions stated in [LICENSE.md](LICENSE.md#exceptions), all code is licensed under the [MIT License](LICENSE.md#mit-license), with all textures, models, sounds, and other media licensed under the [CC BY-SA 4.0 License](LICENSE.md#cc-by-sa-40-license). 
 * Mod Has been modified. I stripped waypoints, added a quest, renamed mod to sbo_measuring_tape, changed the item to "Mesuring Tape", changed item craft, changed mod.conf, and remade the textures
