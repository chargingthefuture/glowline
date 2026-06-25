# Glowline – Neon Arcade Racer

Glowline is a relaxing neon arcade racer. Glide, boost, and drift through glowing circuits with a synthwave vibe.

There are two implementations in this repo:

- **`web/` — Offline PWA (recommended for iPhone).** A self-contained HTML5 +
  Canvas port you can install to your iOS Home Screen and play **fully offline,
  with no App Store and no Apple Developer fee.** See [`web/README.md`](web/README.md).
- **Godot prototype (`scenes/`, `scripts/`).** The original Godot project,
  originally targeted at Android.

## Screenshots

| Title | Race | Choice |
|---|---|---|
| ![Title screen](web/screenshots/01-title.png) | ![Race level](web/screenshots/03-race.png) | ![Branching choice](web/screenshots/04-choice.png) |

## Play on iPhone (no Apple tax)

Host the `web/` folder over HTTPS (a free GitHub Pages workflow is included —
see [`web/README.md`](web/README.md)), open it in Safari, then
**Share → Add to Home Screen**. It runs full-screen and works offline.

To try it locally:

```sh
cd web && python3 -m http.server 8000   # then open http://localhost:8000/
```

## Project Structure
- `/web` – the offline PWA (the playable app)
- `/scenes`, `/scripts` – the original Godot prototype

## Controls & Gameplay
- Touch left/right to steer
- Slide along walls for speed boosts
- Complete laps as fast as possible

## Credits
- Music: Royalty-free synthwave

## Future Enhancements
- Leaderboards
- More levels/tracks
- Customization (ship colors, music)
- Achievements
