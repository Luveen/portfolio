<template>
  <div class="page" @mousemove="handleMouseMove">

    <!-- Ambient cursor glow -->
    <div class="cursor-glow" :style="{ left: cursor.x + 'px', top: cursor.y + 'px' }"></div>

    <!-- Top-left logo -->
    <div class="logo animate-logo">
      <svg width="36" height="32" viewBox="0 0 36 32" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M0 32 L8 0 L18 20 L28 0 L36 32 L28 32 L18 14 L8 32 Z" fill="#e8622a"/>
      </svg>
    </div>

    <!-- Main hero layout -->
    <div class="hero">

      <!-- Left side -->
      <div class="hero-left">
        <span class="label animate-item" style="--delay: 0.1s">PORTFOLIO</span>
        <h1 class="name-primary animate-item" style="--delay: 0.25s">
          <span class="glow-core">Mishan</span>
        </h1>
        <h1 class="name-secondary animate-item" style="--delay: 0.4s">Luveen.</h1>
        <p class="tagline animate-item" style="--delay: 0.6s">
          <span>Code<em>.</em></span>
          <span>Create<em>.</em></span>
          <span>Succeed<em>.</em></span>
        </p>
      </div>

      <!-- Right side (Code Prism Experience) -->
      <div class="hero-right">
        <div class="prism-experience animate-prism" :style="prismStyle">
          <!-- Fluid Amber Background - Removed as per user request -->
          
          <!-- Layered Glass Panels -->
          <div class="glass-deck">
            <!-- Front Layer: Core Focus -->
            <div class="glass-panel panel-front">
              <div class="liquid-outline"></div>
              <div class="panel-header">
                <span class="dot"></span><span class="dot"></span><span class="dot"></span>
                <span class="file-name">App.vue</span>
              </div>
              <pre class="code-line"><code><span class="syntax-keyword">const</span> <span class="syntax-var">logic</span> = () => {</code></pre>
              <pre class="code-line"><code>  <span class="syntax-func">build</span>(<span class="syntax-str">"future"</span>);</code></pre>
              <pre class="code-line"><code>};</code></pre>
            </div>

            <!-- Middle Layer: System Stats -->
            <div class="glass-panel panel-mid">
              <div class="liquid-outline"></div>
              <div class="panel-header">
                <span class="file-name">Terminal</span>
              </div>
              <div class="terminal-line">> System Ready...</div>
              <div class="terminal-line">> Performance: 100%</div>
              <div class="terminal-line active-line">> Loading Core..._</div>
            </div>

            <!-- Back Layer: Abstract UI -->
            <div class="glass-panel panel-back">
              <div class="liquid-outline"></div>
              <div class="abstract-nodes">
                <div class="node-icon csharp">C#</div>
                <div class="node-icon unity">Unity</div>
                <div class="node-icon dotnet">.NET</div>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>


    <!-- CLI bottom navbar via shared component -->
    <CliNavbar hint="type 'help' for commands..." />

  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import CliNavbar from './CliNavbar.vue'

const cursor    = ref({ x: -200, y: -200 })
const mouse     = ref({ x: 0, y: 0 })

function handleMouseMove(e) {
  const { innerWidth: w, innerHeight: h } = window
  // Normalize mouse coords (-1 to 1)
  mouse.value = {
    x: (e.clientX - w / 2) / (w / 2),
    y: (e.clientY - h / 2) / (h / 2),
  }
  cursor.value = { x: e.clientX, y: e.clientY }
}

const prismStyle = computed(() => {
  const rotateY = mouse.value.x * 12 // Up to 12 degrees
  const rotateX = -mouse.value.y * 12
  return {
    transform: `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg)`,
    transition: 'transform 0.15s cubic-bezier(0.23, 1, 0.32, 1)'
  }
})
</script>

<style scoped>
/* ── Page shell ── */
.page {
  width: 100vw;
  height: 100vh;
  background-color: #0b0b0b;
  position: relative;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

/* ── Cursor ambient glow ── */
.cursor-glow {
  position: fixed;
  width: 420px;
  height: 420px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(232, 98, 42, 0.1) 0%, transparent 70%);
  transform: translate(-50%, -50%);
  pointer-events: none;
  z-index: 0;
  transition: left 0.08s ease, top 0.08s ease;
}

/* ── Logo ── */
.logo {
  position: absolute;
  top: 2rem;
  left: 2.5rem;
  z-index: 10;
}

/* ── Entry animation ── */
@keyframes fadeUp {
  from { opacity: 0; transform: translateY(28px); }
  to   { opacity: 1; transform: translateY(0); }
}

@keyframes fadeIn {
  from { opacity: 0; }
  to   { opacity: 1; }
}

.animate-logo {
  animation: fadeIn 0.6s ease forwards;
}

.animate-item {
  opacity: 0;
  animation: fadeUp 0.7s cubic-bezier(0.22, 1, 0.36, 1) forwards;
  animation-delay: var(--delay, 0s);
}

.animate-prism {
  opacity: 0;
  animation: fadeIn 1.2s ease 0.4s forwards;
}

/* ── Hero layout ── */
.hero {
  flex: 1;
  display: flex;
  align-items: center;
  padding: 0 2.5rem 0 3rem;
  position: relative;
  z-index: 1;
}

/* ── Left ── */
.hero-left {
  flex: 0 0 45%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding-right: 2rem;
}

.label {
  display: block;
  font-size: 0.7rem;
  font-weight: 600;
  letter-spacing: 0.18em;
  color: #ffffff;
  margin-bottom: 0.75rem;
  text-transform: uppercase;
}

.name-primary {
  position: relative;
  font-size: clamp(3.2rem, 12vw, 7.5rem);
  font-weight: 900;
  line-height: 1;
  color: transparent;
  -webkit-text-stroke: 1.5px #e8622a;
  letter-spacing: -0.03em;
  margin-bottom: 0.05em;
}

.glow-core {
  position: relative;
  z-index: 1;
}

.name-secondary {
  font-size: clamp(3.2rem, 12vw, 7.5rem);
  font-weight: 900;
  line-height: 1;
  color: #e8622a;
  letter-spacing: -0.03em;
  margin-bottom: 1.5rem;
}

.tagline {
  display: flex;
  gap: 1.6rem;
  align-items: center;
  font-size: 1.05rem;
  font-weight: 500;
  letter-spacing: 0.04em;
  text-transform: uppercase;
}

.tagline span {
  color: #555555;
  transition: color 0.3s ease;
}

.tagline span:hover { color: #ffffff; }

.tagline em {
  font-style: normal;
  color: #e8622a;
}

/* ── Right (Code Prism) ── */
.hero-right {
  flex: 0 0 55%;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  height: 100%;
}

.prism-experience {
  width: 100%;
  height: 80%;
  max-width: 800px;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  transform-style: preserve-3d;
}

.glass-deck {
  position: relative;
  width: 100%;
  height: 100%;
  transform-style: preserve-3d;
}

.glass-panel {
  position: absolute;
  background: rgba(15, 15, 15, 0.4);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.05); /* Razor thin border */
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 30px 60px -12px rgba(0, 0, 0, 0.8);
  transition: all 0.5s ease;
  overflow: hidden; /* For liquid outline */
}

/* Liquid Outline Animation */
.liquid-outline {
  position: absolute;
  inset: -1px;
  padding: 1px;
  border-radius: inherit;
  background: conic-gradient(from 0deg, transparent 0% 15%, #e8622a 25%, transparent 35% 100%);
  -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
  mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
  -webkit-mask-composite: xor;
  mask-composite: exclude;
  animation: liquidFlow 4s linear infinite;
  z-index: 10;
  pointer-events: none;
  opacity: 0.6;
}

@keyframes liquidFlow {
  from { transform: rotate(0deg); }
  to   { transform: rotate(360deg); }
}

/* Varying outline speeds */
.panel-mid .liquid-outline { animation-duration: 6s; animation-direction: reverse; }
.panel-back .liquid-outline { animation-duration: 8s; opacity: 0.3; }

.panel-header {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.03);
  padding-bottom: 0.5rem;
}

.file-name {
  font-family: 'Fira Code', monospace;
  font-size: 0.7rem;
  color: #444;
  margin-left: 0.5rem;
}

.dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
}

/* Specific Panel Placements */
.panel-front {
  width: 320px;
  z-index: 30;
  top: 15%;
  right: 10%;
  transform: translateZ(80px);
}

.panel-mid {
  width: 280px;
  z-index: 20;
  top: 45%;
  left: 5%;
  transform: translateZ(40px);
}

.panel-back {
  width: 400px;
  height: 250px;
  z-index: 10;
  top: 20%;
  left: 15%;
  transform: translateZ(0px);
  opacity: 0.45;
}

/* Code Styles */
.code-line {
  font-family: 'Fira Code', monospace;
  font-size: 0.82rem;
  line-height: 1.6;
  margin: 0;
}
.syntax-keyword { color: #e8622a; font-weight: 600; }
.syntax-func { color: #888; }
.syntax-var { color: #555; }
.syntax-str { color: #333; }

/* Terminal Styles */
.terminal-line {
  font-family: 'SF Mono', monospace;
  font-size: 0.7rem;
  color: #444;
  margin-bottom: 0.4rem;
}
.active-line {
  color: #e8622a;
}

/* Abstract UI */
.abstract-nodes {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  height: 100%;
  align-content: center;
  justify-content: center;
}

.node-icon {
  background: rgba(232, 98, 42, 0.02);
  border: 1px solid rgba(232, 98, 42, 0.1);
  color: #e8622a;
  padding: 0.4rem 0.8rem;
  font-size: 0.6rem;
  font-weight: 700;
  letter-spacing: 0.1em;
  text-transform: uppercase;
}

/* ── Abstract UI (end of hero) ── */

/* ── Responsive & Mobile Refinements ── */
@media (max-width: 991px) {
  .logo { top: 1.5rem; left: 1.5rem; }

  .hero {
    flex-direction: column;
    padding: 7rem 1.5rem 6.5rem 1.5rem;
    gap: 2rem;
    justify-content: flex-start;
    overflow-y: auto;
  }

  .hero-left {
    flex: unset;
    width: 100%;
    align-items: flex-start;
    padding: 0;
    text-align: left;
  }

  .label { font-size: 0.65rem; }

  .name-primary,
  .name-secondary {
    font-size: clamp(3rem, 15vw, 4.5rem);
    letter-spacing: -0.02em;
    margin-bottom: 0.1em;
  }

  .tagline {
    font-size: 0.8rem;
    gap: 1rem;
    margin-top: 1rem;
  }

  .hero-right {
    flex: unset;
    width: 100%;
    height: 380px; /* Controlled height for the prism on mobile */
    perspective: 1500px; /* Deeper perspective for mobile */
    margin-top: 1rem;
    overflow: visible;
  }

  .prism-experience {
    height: 100%;
    max-width: 100%;
  }

  .panel-front {
    width: 220px;
    top: 50%;
    right: 2%;
    transform: translateZ(60px);
    padding: 1.1rem;
  }

  .panel-mid {
    width: 200px;
    top: 25%;
    left: 2%;
    transform: translateZ(30px);
    padding: 1.1rem;
  }

  .panel-back {
    display: none; /* Keep hidden on mobile to avoid clutter */
  }

  /* Mobile stacking for component mostly handled inside CliNavbar.vue 
     Just kept for backwards compatibility of hero sizing */
}

@media (max-width: 480px) {
  .hero { padding-top: 5.5rem; gap: 1.2rem; }
  .name-primary, .name-secondary { font-size: 3rem; }
  .hero-right { height: 340px; }
  .panel-front { width: 190px; top: 48%; }
  .panel-mid { width: 170px; top: 20%; }
  .tagline { gap: 0.8rem; font-size: 0.75rem; }
}
</style>