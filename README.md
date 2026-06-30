# Glowline – Neon Arcade Racer

Glowline is a relaxing offline neon arcade racer. Glide through glowing circuits, dodge hazards, and navigate maze corridors with a synthwave sound generated in the browser.

There are two implementations in this repo:

- **`web/` — Offline PWA (recommended for iPhone).** A self-contained HTML5 +
  Canvas game you can install to your iOS Home Screen and play **fully offline,
  with no App Store and no Apple Developer fee.** See [`web/README.md`](web/README.md).
- **Godot prototype (`scenes/`, `scripts/`).** The original Godot project,
  originally targeted at Android.

## Screenshots

| Title | Race | Choice |
|---|---|---|
| ![Title screen](web/screenshots/01-title.png) | ![Race level](web/screenshots/03-race.png) | ![Branching choice](web/screenshots/04-choice.png) |

## Play on iPhone (no Apple tax)

Host the `web/` folder over HTTPS once (a free GitHub Pages workflow is included —
see [`web/README.md`](web/README.md)), open it in Safari, then
**Share → Add to Home Screen**. After that first load, the game runs full-screen
and works offline.

To try it locally:

```sh
cd web && python3 -m http.server 8000   # then open http://localhost:8000/
```

## Project Structure
- `/web` – the offline PWA (the playable app)
- `/scenes`, `/scripts` – the original Godot prototype

## Controls & Gameplay
- Touch left/right to steer
- Keyboard: left/right arrows or A/D
- Navigate hazards and maze openings
- Hazards set progress back; they do not end the run

## Credits
- Music and sound effects: generated locally with Web Audio

## Future Enhancements
- More offline levels
- Ship color options stored on the device
- Local achievement badges stored on the device
