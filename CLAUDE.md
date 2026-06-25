# Glowline — agent instructions

The shared, cross-repo agent rules and this project's own rules live in `AGENTS.md`
(imported below). `AGENTS.md` is the single canonical source so every agent tool reads
the same instructions; keep edits there, not here.

The voice rule and banned-term dictionary in `AGENTS.md` are enforced by the Stop hook
`.claude/hooks/check-no-pleasantries.mjs`, registered in `.claude/settings.json`.

@AGENTS.md
