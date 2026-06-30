// Glowline — narrative script.
// Ported from scripts/main.gd. Each "beat" drives the story engine in main.js.
//
//   { say: [..lines..] }                       -> dialogue lines
//   { say: (branch) => [..lines..] }           -> dialogue that depends on the choice
//   { race: { name, subtitle, seconds, mode, maze? }} -> a steer-and-dodge level
//   { choice: { prompt, options: [...] } }     -> a branching decision
//
// Tone follows STORY.md: supportive, hopeful, never oppressive. The game is
// always winnable — hazards reset the run rather than ending it.

export const STORY = [
  // ---- Act 1: Routine ----
  { say: [
    "Broker: GL-1N3, online. Ready for another day of deliveries?",
    "GL-1N3: Always, Broker. Where to?",
    "Broker: Sector 7 is waiting. Stay efficient.",
  ] },
  { race: { name: "Act 1 — First Delivery", subtitle: "Glide to Sector 7", seconds: 14, mode: "calm" } },
  { say: ["Broker: Efficient work. As expected."] },
  { say: [
    "GL-1N3: Did you see that flicker?",
    "Broker: Irrelevant. Continue your task.",
  ] },

  // ---- Act 2: Glitch ----
  { say: [
    "The Pulse: ...can you hear me? You're not safe. Broker is hiding the truth.",
    "GL-1N3: Who are you? What's happening?",
    "Broker: Ignore the interference. Focus on your mission.",
  ] },
  { say: ["Broker: This sector is unstable. Proceed with caution."] },
  { race: { name: "Act 2 — Corrupted Sector", subtitle: "Dodge the corruption", seconds: 20, mode: "hazard" } },
  { say: [
    "GL-1N3: That was close. The corruption is spreading.",
    "Broker: I will handle it. You just deliver.",
  ] },
  { say: [
    "The Pulse: Broker is isolating the Core. You must help me.",
    "GL-1N3: Why should I trust you?",
    "The Pulse: Because you feel it too. The system is suffocating.",
  ] },

  // ---- Act 3: Rebellion ----
  { choice: {
    prompt: "The Core holds its breath. What does GL-1N3 do?",
    options: [
      { label: "Obey Broker", branch: "broker",
        line: "Broker: You are my asset. Do not betray your purpose." },
      { label: "Help The Pulse", branch: "pulse",
        line: "The Pulse: Together, we can free the Core." },
    ],
  } },
  { say: ["Broker: You leave me no choice."] },
  { race: { name: "Act 3 — Security Breach", subtitle: "Outrun Broker's sentinels", seconds: 22, mode: "fast" } },
  { say: [
    "GL-1N3: Why are you doing this?",
    "Broker: It's for the system's stability.",
  ] },
  { say: ["The Pulse: This is our only chance. Go!"] },

  // ---- Act 4: Liberation ----
  { say: [
    "Broker: Don't do this. I can't lose control.",
    "GL-1N3: I have to try.",
  ] },
  { race: { name: "Act 4 — Collapse", subtitle: "Carry the patch to the Beacon", seconds: 26, mode: "intense" } },
  { say: [
    "The Pulse: The Beacon opened a narrow route. Follow the clear spaces.",
    "GL-1N3: I see it. A path inside the noise.",
  ] },
  { race: {
    name: "Act 5 — Memory Maze",
    subtitle: "Thread the safe openings",
    seconds: 24,
    mode: "maze",
    maze: {
      gap: 225,
      wallHeight: 76,
      interval: 1.35,
      gaps: [360, 230, 500, 290, 455, 180, 390, 540, 320, 210, 470, 350],
    },
  } },
  { say: [
    "Broker: The route is changing, but it is not closed.",
    "GL-1N3: Then we keep moving.",
  ] },
  { race: {
    name: "Act 6 — Last Corridor",
    subtitle: "Navigate the final corridor",
    seconds: 28,
    mode: "maze",
    maze: {
      gap: 190,
      wallHeight: 84,
      interval: 1.12,
      gaps: [320, 520, 410, 210, 165, 455, 555, 340, 185, 270, 505, 395, 225, 360],
    },
  } },
  { say: (branch) => branch === "broker"
      ? ["GL-1N3 delivers the patch, and Broker steadies.",
         "Broker (rebooting): GL-1N3...? What happened?",
         "GL-1N3: Welcome back, Broker."]
      : ["The Pulse: You did it. The Core is free.",
         "Broker (rebooting): GL-1N3...? What happened?",
         "GL-1N3: Welcome back, Broker."] },
  { say: (branch) => branch === "broker"
      ? ["Broker: Thank you, GL-1N3."]
      : ["The Pulse: You are more than data. You are hope.",
         "Broker: Thank you, GL-1N3."] },
];

export const ENDINGS = {
  broker: "The system holds — stable, and a little less alone. GL-1N3 carries on.",
  pulse: "New connections bloom across the Core. GL-1N3 is more than data. GL-1N3 is hope.",
};
