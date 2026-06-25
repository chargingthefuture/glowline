// Dialogue overlay — ports scripts/dialogue_manager.gd to the DOM.
// Typewriter reveal; tap/click/Space completes the line, then advances.
// say(lines) -> Promise(resolved when all lines shown)
// choose(prompt, options) -> Promise(resolved with the chosen option)

import * as audio from "./audio.js";

const box = document.getElementById("dialogue");
const textEl = document.getElementById("dialogueText");
const hintEl = document.getElementById("dialogueHint");
const choicesEl = document.getElementById("choices");

let revealTimer = null;

function show() { box.classList.add("visible"); }
function hide() { box.classList.remove("visible"); }

function typewrite(line) {
  return new Promise((resolve) => {
    clearInterval(revealTimer);
    textEl.textContent = "";
    hintEl.style.opacity = "0";
    let i = 0;
    let done = false;
    const speaker = line.split(":")[0];
    box.dataset.speaker = /pulse/i.test(speaker) ? "pulse"
      : /broker/i.test(speaker) ? "broker"
      : /gl-1n3/i.test(speaker) ? "player" : "narrator";

    const finish = () => {
      done = true;
      clearInterval(revealTimer);
      textEl.textContent = line;
      hintEl.style.opacity = "1";
      cleanup();
      resolve();
    };
    const onInput = (e) => {
      if (e.type === "keydown" && e.code !== "Space" && e.code !== "Enter") return;
      e.preventDefault();
      if (!done) finish();           // first tap completes the reveal...
      else { cleanup(); resolve("advance"); } // ...but we resolve immediately on complete anyway
    };
    function cleanup() {
      box.removeEventListener("pointerdown", onInput);
      window.removeEventListener("keydown", onInput);
    }
    box.addEventListener("pointerdown", onInput);
    window.addEventListener("keydown", onInput);

    revealTimer = setInterval(() => {
      i++;
      textEl.textContent = line.slice(0, i);
      if (i % 2 === 0) audio.blip();
      if (i >= line.length) finish();
    }, 22);
  });
}

function waitForAdvance() {
  return new Promise((resolve) => {
    const go = (e) => {
      if (e.type === "keydown" && e.code !== "Space" && e.code !== "Enter") return;
      e.preventDefault();
      box.removeEventListener("pointerdown", go);
      window.removeEventListener("keydown", go);
      resolve();
    };
    box.addEventListener("pointerdown", go);
    window.addEventListener("keydown", go);
  });
}

export async function say(lines) {
  choicesEl.innerHTML = "";
  show();
  for (const line of lines) {
    await typewrite(line);
    await waitForAdvance();
    audio.blip();
  }
  hide();
}

export function choose(prompt, options) {
  return new Promise((resolve) => {
    show();
    box.dataset.speaker = "narrator";
    textEl.textContent = prompt;
    hintEl.style.opacity = "0";
    choicesEl.innerHTML = "";
    options.forEach((opt) => {
      const btn = document.createElement("button");
      btn.className = "choice";
      btn.textContent = opt.label;
      btn.addEventListener("click", () => {
        audio.choose();
        choicesEl.innerHTML = "";
        resolve(opt);
      });
      choicesEl.appendChild(btn);
    });
  });
}

export function hideDialogue() { hide(); }
