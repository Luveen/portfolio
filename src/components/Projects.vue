<template>
  <div class="page" :class="{ 'is-blurred': selectedProject }" @mousemove="handleMouseMove">
    <!-- Ambient cursor glow -->
    <div class="cursor-glow" :style="{ left: cursor.x + 'px', top: cursor.y + 'px' }"></div>

    <!-- Top-left logo -->
    <router-link to="/" class="logo-group animate-logo">
      <div class="logo-icon">
        <svg width="24" height="22" viewBox="0 0 36 32" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M0 32 L8 0 L18 20 L28 0 L36 32 L28 32 L18 14 L8 32 Z" fill="#e8622a"/>
        </svg>
      </div>
    </router-link>

    <div class="projects-container">
      <!-- ── TITLE ── -->
      <header class="header" v-show="activeProject">
        <h1 class="projects-title"><span class="accent">P</span>rojects</h1>
      </header>

      <!-- ── CENTRAL DISPLAY ── -->
      <section class="display-area">
        <transition name="fade-up" mode="out-in">
          <!-- Hovered Project View -->
          <div 
            v-if="activeProject"
            :key="activeProject.id" 
            class="glass-card"
            :style="{ '--liquid-color': activeProject.color || 'rgba(232, 98, 42, 0.15)' }"
          >
            <div class="glass-content">
              <h2 class="project-name">{{ activeProject.title }}</h2>
              <p class="project-subtitle">{{ activeProject.subtitle }}</p>
              
              <div class="tech-section" v-if="activeProject.techStack">
                <span class="tech-label">Tech Stack</span>
                <div class="tech-icons">
                  <div v-for="tech in activeProject.techStack" :key="tech.name" class="tech-icon-wrapper" :title="tech.name">
                    <img :src="tech.icon" :alt="tech.name" class="tech-icon" v-if="tech.icon" />
                  </div>
                </div>
              </div>
            </div>
            <div class="liquid-bg"></div>
          </div>

          <!-- Default Hero View (On Load) -->
          <div v-else key="hero" class="hero-title-container">
            <!-- Floating Background Tech Stack -->
            <div class="floating-tech-bg">
              <div v-for="(icon, idx) in floatingIcons" :key="idx" class="floating-icon" :class="`float-${idx}`">
                <img :src="icon" />
              </div>
            </div>

            <h1 class="hero-projects-title">PROJECTS</h1>
            <div class="hero-glow"></div>
          </div>
        </transition>
      </section>

      <!-- ── MAC DOCK ── -->
      <footer class="dock-wrapper">
        <div class="mac-dock">
          <div 
            v-for="project in projects" 
            :key="project.id" 
            class="dock-item"
            :class="{ active: activeProject?.id === project.id }"
            @mouseenter="activeProject = project"
            @click="selectProject(project)"
          >
            <!-- Label tooltip -->
            <div class="dock-label">{{ project.title }}</div>
            
            <div class="dock-icon-box">
              <img :src="project.logo" :alt="project.title" v-if="project.logo" />
              <div v-else class="placeholder-icon" :style="{ backgroundColor: project.color }">
                {{ project.title.charAt(0) }}
              </div>
            </div>
          </div>
        </div>
      </footer>
    </div>

    <!-- CLI bottom navbar via shared component -->
    <CliNavbar hint="type 'help' for commands..." />

    <!-- ── PROJECT DETAIL OVERLAY ── -->
    <transition name="overlay-fade">
      <div v-if="selectedProject" class="project-overlay" @click.self="closeProject">
        <div class="overlay-frame">
          <!-- SVG border overlay with rounded corners to match the frame radius -->
          <svg class="frame-border-svg" viewBox="0 0 1000 1000" preserveAspectRatio="none">
            <path 
              d="M 40,1.5 
                 L 350,1.5 
                 L 410,80.5 
                 L 960,80.5 
                 A 40,40 0 0 1 998.5,120.5 
                 L 998.5,960 
                 A 40,40 0 0 1 960,998.5 
                 L 40,998.5 
                 A 40,40 0 0 1 1.5,960 
                 L 1.5,40 
                 A 40,40 0 0 1 40,1.5 
                 Z" 
              fill="none" 
              stroke="#e8622a" 
              stroke-width="3"
              stroke-linejoin="round"
              vector-effect="non-scaling-stroke"
            />
          </svg>
          
          <button class="close-btn" @click="closeProject">✕</button>
          
          <div class="overlay-content">
            <div class="overlay-grid">
              <!-- Left Column: Content -->
              <div class="info-column">
                <header class="project-header">
                  <h1 class="huge-title">{{ selectedProject.title }}</h1>
                  <p class="mono-subtitle">{{ selectedProject.subtitle }}</p>
                </header>
                
                <div class="project-description">
                  <p>{{ selectedProject.longDescription }}</p>
                </div>
                
                <div class="screenshot-gallery" v-if="selectedProject.screenshots && selectedProject.screenshots.length > 0">
                  <!-- Poster Image (First in array) fill its original proportions -->
                  <div class="poster-item">
                    <img :src="selectedProject.screenshots[0]" class="poster-img" />
                  </div>
                  
                  <!-- Additional Mobile Screenshots (Rest of array) -->
                  <div class="gallery-grid" v-if="selectedProject.screenshots.length > 1">
                    <div v-for="(img, idx) in selectedProject.screenshots.slice(1)" :key="idx" class="screenshot-item">
                      <img :src="img" class="screenshot-img" />
                    </div>
                  </div>
                </div>
                
                <div class="project-description secondary" v-if="selectedProject.bottomDescription">
                  <p>{{ selectedProject.bottomDescription }}</p>
                </div>
              </div>
              
              <!-- Right Column: Tech & CTA -->
              <div class="action-column">
                <div class="cta-wrapper">
                  <a :href="selectedProject.githubUrl" target="_blank" class="github-cta">
                    GITHUB REPO
                  </a>
                </div>
                
                <div class="giant-tech-stack">
                  <div v-for="tech in selectedProject.techStack" :key="tech.name" class="giant-tech-icon" :title="tech.name">
                    <img :src="tech.icon" :alt="tech.name" />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'
import { getProjects } from '../firebase'
import CliNavbar from './CliNavbar.vue'

const floatingIcons = [
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/vuejs/vuejs-original.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/react/react-original.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/firebase/firebase-plain.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/threejs/threejs-original.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/python/python-original.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/nodejs/nodejs-original.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/figma/figma-original.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/csharp/csharp-original.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/unity/unity-original.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/android/android-plain.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/kotlin/kotlin-original.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/java/java-original.svg',
  'https://raw.githubusercontent.com/devicons/devicon/master/icons/swift/swift-original.svg',
  

 
]

const cursor = ref({ x: -200, y: -200 })
const rawProjects = ref([])
const activeProject = ref(null)
const selectedProject = ref(null)

function selectProject(project) {
  selectedProject.value = project
  document.body.style.overflow = 'hidden' // Prevent scroll when overlay is open
}

function closeProject() {
  selectedProject.value = null
  document.body.style.overflow = ''
}



const projects = computed(() => {
  if (rawProjects.value && rawProjects.value.length > 0) {
    return rawProjects.value.map(project => {
      const p = { ...project }
      // Normalize techStack in case it was stored as [{ "TechName": "url" }] instead of [{ name: "TechName", icon: "url" }]
      if (p.techStack && Array.isArray(p.techStack)) {
        p.techStack = p.techStack.map(tech => {
          if (!tech.name && !tech.icon && tech && typeof tech === 'object') {
            const keys = Object.keys(tech)
            if (keys.length === 1) {
              return { name: keys[0], icon: tech[keys[0]] }
            }
          }
          return tech
        })
      }
      return p
    })
  }
  return []
})

onMounted(async () => {
  rawProjects.value = await getProjects()
  activeProject.value = null
})

function handleMouseMove(e) {
  cursor.value = { x: e.clientX, y: e.clientY }
}



</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@100..900&display=swap');

.page {
  width: 100vw;
  height: 100vh;
  background-color: #050505;
  position: relative;
  overflow: hidden;
  font-family: 'Outfit', -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
  color: #fff;
  display: flex;
  flex-direction: column;
}

.cursor-glow {
  position: fixed;
  width: 800px; height: 800px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(232, 98, 42, 0.08) 0%, transparent 70%);
  transform: translate(-50%, -50%);
  pointer-events: none;
  z-index: 0;
  transition: left 0.1s ease-out, top 0.1s ease-out;
}

.logo-group {
  position: absolute; top: 2rem; left: 2.5rem; z-index: 100;
}

.projects-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  padding: 0 4rem 12rem;
  z-index: 1;
}

/* ── Header ── */
.header {
  text-align: center;
  margin-bottom: 2rem;
  transition: opacity 0.4s ease, transform 0.4s ease;
}

.projects-title {
  font-family: "Roboto Slab", serif;
  font-optical-sizing: auto;
  font-size: 5rem;
  font-weight: 800;
  letter-spacing: -0.02em;
  margin: 10;
}

.projects-title .accent {
  color: #e8622a;
}

/* ── Hero Title Mode ── */
.hero-title-container {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  position: relative;
}

.hero-projects-title {
  font-family: "Roboto Slab", serif;
  font-optical-sizing: auto;
  font-size: clamp(3rem, 15vw, 10rem);
  font-weight: 800;
  letter-spacing: -0.02em;
  color: #fff;
  z-index: 2;
  text-align: center;
  text-transform: uppercase;
  margin-top: 1rem; /* Added safe space at the top */
}

.hero-glow {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 50vw;
  height: 30vh;
  background: radial-gradient(ellipse, rgba(232, 98, 42, 0.4) 0%, transparent 70%);
  filter: blur(80px);
  z-index: 1;
  pointer-events: none;
}

/* ── Floating Tech Background ── */
.floating-tech-bg {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  overflow: hidden;
  pointer-events: none;
  z-index: 1;
}

.floating-icon {
  position: absolute;
  width: 60px;
  height: 60px;
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.02);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.05);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 12px;
  opacity: 0.15;
  animation: float-around 15s infinite alternate ease-in-out;
  box-shadow: 0 10px 30px rgba(0,0,0,0.5);
}

.floating-icon img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  filter: grayscale(100%) brightness(150%);
}

.float-0 { top: 10%; left: 15%; animation-delay: 0s; width: 70px; height: 70px; }
.float-1 { top: 75%; left: 10%; animation-delay: -3s; animation-duration: 20s; }
.float-2 { top: 15%; right: 15%; animation-delay: -7s; width: 50px; height: 50px; }
.float-3 { top: 60%; right: 12%; animation-delay: -2s; animation-duration: 18s; }
.float-4 { top: 40%; left: 25%; animation-delay: -5s; width: 45px; height: 45px; }
.float-5 { top: 38%; right: 28%; animation-delay: -10s; animation-duration: 22s; padding: 15px; }
.float-6 { top: 85%; left: 45%; animation-delay: -1s; width: 80px; height: 80px; padding: 18px; }
.float-7 { top: 5%; left: 45%; animation-delay: -4s; width: 55px; height: 55px; }
.float-8 { top: 25%; left: 8%; animation-delay: -8s; animation-duration: 19s; width: 65px; height: 65px; }
.float-9 { top: 85%; right: 25%; animation-delay: -11s; width: 105px; height: 75px; padding: 14px; }
.float-10 { top: 55%; left: 8%; animation-delay: -6s; animation-duration: 25s; width: 85px; height: 85px; }
.float-11 { top: 48%; right: 10%; animation-delay: -14s; width: 60px; height: 60px; }
.float-12 { top: 18%; left: 35%; animation-delay: -9s; animation-duration: 21s; width: 50px; height: 50px; }

@keyframes float-around {
  0% { transform: translateY(0) rotate(0deg) scale(1); }
  50% { transform: translateY(-40px) rotate(10deg) scale(1.05); }
  100% { transform: translateY(20px) rotate(-10deg) scale(0.95); }
}

/* ── Display Area (Glass Card) ── */
.display-area {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  perspective: 1000px;
}

.glass-card {
  width: 100%;
  max-width: 900px;
  height: 400px;
  background: rgba(255, 255, 255, 0.03);
  backdrop-filter: blur(25px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 32px;
  position: relative;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 4rem;
  transition: all 0.5s cubic-bezier(0.23, 1, 0.32, 1);
  box-shadow: 0 40px 100px rgba(0, 0, 0, 0.5);
}

.glass-content {
  position: relative;
  z-index: 2;
}

.project-name {
  font-size: 6rem;
  font-weight: 800;
  line-height: 1;
  margin-bottom: 1rem;
  text-transform: uppercase;
  letter-spacing: -0.04em;
}

.project-subtitle {
  font-size: 1.5rem;
  font-weight: 400;
  color: rgba(255, 255, 255, 0.7);
  margin-bottom: 3rem;
}

.tech-section {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.tech-label {
  font-size: 0.9rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: rgba(255, 255, 255, 0.5);
}

.tech-icons {
  display: flex;
  gap: 1.5rem;
}

.tech-icon-wrapper {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  /* Filter removed to show original colors immediately as requested */
  transition: 0.3s;
}

.tech-icon-wrapper:hover {
  filter: none;
  transform: translateY(-5px);
}

.tech-icon {
  max-width: 100%;
  max-height: 100%;
}

/* Liquid background decoration */
.liquid-bg {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: radial-gradient(circle at 30% 30%, var(--liquid-color), transparent 70%);
  opacity: 0.4;
  filter: blur(60px);
  z-index: -1;
  transition: background 1s ease;
  animation: liquidMove 10s infinite alternate ease-in-out;
}

@keyframes liquidMove {
  0% { transform: scale(1) rotate(0deg); }
  100% { transform: scale(1.2) rotate(10deg); }
}

/* ── Poster View ── */
.poster-view {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 100%;
}

.poster-header {
  display: flex;
  justify-content: space-between;
  font-family: 'SF Mono', monospace;
  font-size: 0.6rem;
  color: rgba(255, 255, 255, 0.4);
  letter-spacing: 0.25em;
  text-transform: uppercase;
}

.poster-title {
  display: flex;
  flex-direction: column;
  line-height: 0.9;
  margin: 1.5rem 0;
}

.poster-title span { display: block; }

.poster-title .word-1 {
  font-size: clamp(3rem, 8vw, 6.5rem);
  font-weight: 800;
  color: transparent;
  -webkit-text-stroke: 1px rgba(255, 255, 255, 0.15);
  letter-spacing: -0.02em;
}

.poster-title .word-2 {
  font-size: clamp(3rem, 8vw, 6.5rem);
  font-weight: 800;
  color: #fff;
  letter-spacing: -0.04em;
  margin-left: 0.05em;
}

.poster-title .dot {
  color: #e8622a;
  font-style: normal;
}

.poster-footer {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  gap: 2rem;
}

.status-block {
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
}

.status-line {
  display: flex;
  gap: 0.8rem;
  font-family: 'SF Mono', monospace;
  font-size: 0.6rem;
}

.status-label { color: rgba(255, 255, 255, 0.2); }
.status-value { color: rgba(255, 255, 255, 0.8); font-weight: 600; }
.status-value.highlight { color: #e8622a; }

.poster-desc {
  max-width: 280px;
  font-size: 0.75rem;
  line-height: 1.6;
  color: rgba(255, 255, 255, 0.4);
  text-align: right;
  font-weight: 400;
}

.poster-accent-bar {
  position: absolute;
  right: 0;
  top: 15%;
  bottom: 15%;
  width: 1px;
  background: linear-gradient(to bottom, transparent, rgba(232, 98, 42, 0.4), transparent);
}

.glass-card.is-poster {
  background: rgba(15, 15, 15, 0.5);
  border-color: rgba(255, 255, 255, 0.05);
}

/* ── Mac Dock ── */
.dock-wrapper {
  position: absolute;
  bottom: 3.5rem;
  left: 50%;
  transform: translateX(-50%);
  z-index: 10;
}

.mac-dock {
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(15px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  padding: 0.75rem;
  border-radius: 20px;
  display: flex;
  gap: 1rem;
  align-items: flex-end;
  height: 65px;
}

.dock-item {
  position: relative;
  cursor: pointer;
  transition: transform 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.dock-icon-box {
  width: 45px;
  height: 45px;
  /* background: #fff removed to show full-sized logos without white container */
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  /* subtle shadow instead of heavy container shadow */
  transition: all 0.3s ease;
}

.dock-icon-box img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.dock-label {
  position: absolute;
  top: -40px;
  left: 50%;
  transform: translateX(-50%) translateY(10px);
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(5px);
  color: #000;
  padding: 0.15rem 0.75rem;
  border-radius: 10px;
  font-size: 0.45rem;
  font-weight: 600;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
  opacity: 0;
  pointer-events: none;
  transition: 0.2s;
  white-space: nowrap;
}

.dock-item:hover {
  transform: scale(1.5) translateY(-10px);
  margin: 0 0.8rem;
}

.dock-item:hover .dock-label {
  opacity: 1;
  transform: translateX(-50%) translateY(0);
}

.dock-item.active .dock-icon-box {
  border: 2px solid #e8622a;
}

.placeholder-icon {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 800;
  font-size: 1.5rem;
  color: #fff;
}

/* ── CLI Navbar is managed by CliNavbar.vue ── */

/* Transitions */
.fade-up-enter-active, .fade-up-leave-active {
  transition: all 0.5s ease;
}
.fade-up-enter-from {
  opacity: 0;
  transform: translateY(20px);
}
.fade-up-leave-to {
  opacity: 0;
  transform: translateY(-20px);
}

/* Mobile Responsive */
@media (max-width: 1024px) {
  .project-name { font-size: 3rem; }
  .glass-card { padding: 2rem; height: auto; min-height: 320px; }
  .mac-dock { gap: 0.5rem; height: 58px; padding: 0.6rem; }
  .dock-icon-box { width: 42px; height: 42px; }
  .dock-wrapper { bottom: 3rem; }
  .floating-icon { width: 50px !important; height: 50px !important; }
  .cli-prompt-prefix { display: none; }

  .cli-links {
    width: 100%;
    justify-content: space-around;
    gap: 0;
  }

  .cli-link { font-size: 0.68rem; }
}

@media (max-width: 480px) {
  .projects-container { padding: 1.5rem 1.2rem 6.5rem; }
  .projects-title { font-size: 2.5rem; }
  .project-name { font-size: 2.2rem; }
  .hero-projects-title { font-size: clamp(2.2rem, 18vw, 4rem); }
  .floating-tech-bg { opacity: 0.6; }
  .mac-dock { gap: 0.4rem; height: 50px; padding: 0.5rem; }
  .dock-icon-box { width: 36px; height: 36px; }
  .dock-wrapper { bottom: 2.8rem; }
}

/* ── Project Detail Overlay ── */
.project-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 2000;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 0, 0, 0.4);
  backdrop-filter: blur(5px);
  padding: 2rem;
}

.overlay-frame {
  position: relative;
  width: 95%;
  max-width: 1200px;
  height: 90vh;
  background: #000;
  border-radius: 40px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  box-shadow: 0 0 50px rgba(196, 52, 52, 0.15);
  
  /* The custom orange industrial cutout shape matching the reference */
  clip-path: polygon(
    0% 0%, 
    35% 0%, 
    41% 8%, 
    100% 8%, 
    100% 100%, 
    0% 100%
  );
  margin-top: 1rem;
}

.frame-border-svg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 100;
}

/* Adjust frame content to account for clip-path gap */
.overlay-content {
  flex: 1;
  padding: 8rem 4rem 4rem;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch; /* Smooth scrolling for iOS/Mac */
  transform: translateZ(0); /* Hardware acceleration to prevent scroll jank with clip-path */
  will-change: transform;
  scrollbar-width: none; /* Firefox */
  -ms-overflow-style: none; /* IE, Edge */
}

.overlay-content::-webkit-scrollbar {
  display: none; /* Chrome, Safari, Opera */
}

.close-btn {
  position: absolute;
  top: 4rem;
  right: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  width: 30px;
  height: 30px;
  border-radius: 50%;
  color: #fff;
  font-size: 1.2rem;
  cursor: pointer;
  z-index: 200; /* Above the frame border SVG */
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s;
}

.close-btn:hover {
  background: #e8622a;
  border-color: #e8622a;
  transform: rotate(90deg);
}

.overlay-grid {
  display: grid;
  grid-template-columns: 1fr 300px;
  gap: 4rem;
}

/* Left Column Styling */
.huge-title {
  font-size: clamp(3rem, 10vw, 8rem);
  font-weight: 800;
  line-height: 0.9;
  margin: 0;
  letter-spacing: -0.04em;
  text-transform: uppercase;
  color: #fff;
}

.mono-subtitle {
  font-family: 'SF Mono', 'Studio Terminal', monospace;
  font-size: 1.2rem;
  color: rgba(255, 255, 255, 0.8);
  margin: 1.5rem 0 3rem;
}

.project-description {
  max-width: 800px;
  font-size: 1.1rem;
  line-height: 1.7;
  color: rgba(255, 255, 255, 0.7);
  margin-bottom: 3rem;
  font-weight: 400;
}

.project-description.secondary {
  margin-top: 3rem;
  font-size: 0.95rem;
  color: rgba(255, 255, 255, 0.5);
}

.screenshot-gallery {
  margin: 4rem 0;
  display: flex;
  flex-direction: column;
  gap: 2.5rem;
}

.poster-item {
  width: 100%;
  border-radius: 20px;
  overflow: hidden;
  border: 1px solid rgba(255, 255, 255, 0.05);
  background: #111;
  display: flex;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
}

.poster-img {
  width: 100%;
  height: auto;
  object-fit: contain;
}

.gallery-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1.5rem;
}

.screenshot-item {
  background: #111;
  border-radius: 20px;
  overflow: hidden;
  border: 1px solid rgba(255, 255, 255, 0.05);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.screenshot-img {
  width: 100%;
  height: auto;
  object-fit: contain;
  display: block;
}

/* Right Column Styling */
.action-column {
  display: flex;
  flex-direction: column;
  gap: 6rem;
  align-items: center; /* Centered under each other as requested */
}

.github-cta {
  background: #fff;
  color: #e8622a;
  padding: 0.6rem 1.5rem;
  border-radius: 8px;
  font-weight: 700;
  font-size: 1.1rem;
  text-decoration: none;
  transition: all 0.3s;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
  display: inline-block;
  text-align: center;
}

.github-cta:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 40px rgba(255, 255, 255, 0.2);
}

.giant-tech-stack {
  display: flex;
  flex-direction: column;
  gap: 4rem;
}

.giant-tech-icon {
  width: 70px;
  height: 70px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.giant-tech-icon img {
  max-width: 100%;
  max-height: 100%;
  filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.1));
}

/* Transitions */
.overlay-fade-enter-active, .overlay-fade-leave-active {
  transition: opacity 0.4s ease;
}
.overlay-fade-enter-from, .overlay-fade-leave-to {
  opacity: 0;
}

.page.is-blurred .projects-container,
.page.is-blurred .cli-nav,
.page.is-blurred .logo-group {
  filter: blur(20px) grayscale(0.2);
  opacity: 0.3;
  pointer-events: none;
  transition: all 0.5s ease;
}

/* Tablet refinements */
@media (max-width: 1200px) {
  .overlay-content { padding: 5rem 2rem 3rem; }
  .overlay-grid { grid-template-columns: 1fr; gap: 3rem; }
  .action-column { align-items: center; flex-direction: row; justify-content: space-between; gap: 2rem; margin-top: 2rem; }
  .giant-tech-stack { flex-direction: row; flex-wrap: wrap; gap: 2rem; justify-content: center; }
  .huge-title { font-size: 3.5rem; }
  .project-description { font-size: 1rem; margin-bottom: 2rem; }
}

@media (max-width: 600px) {
  .overlay-frame {
    /* Simple flat top on very small screens to prevent content cutoff */
    clip-path: none;
    border: 1px solid #e8622a;
    border-radius: 20px;
  }
  .frame-border-svg { display: none; }
  .overlay-content { padding: 4rem 1.2rem 4rem; }
  .huge-title { font-size: 2.2rem; }
  .action-column { flex-direction: column-reverse; gap: 3rem; }
  .giant-tech-stack { gap: 1.5rem; }
  .giant-tech-icon { width: 50px; height: 50px; }
  .github-cta { width: 100%; }
  .screenshot-gallery { margin: 2rem 0; gap: 1.5rem; }
  .close-btn { 
    top: 2rem; /* More offset from the border */
    right: 2rem; 
    width: 32px; 
    height: 32px; 
    font-size: 1.1rem; 
    background: rgba(232, 98, 42, 0.95);
    border: none;
    box-shadow: 0 4px 15px rgba(0,0,0,0.6);
  }
}
</style>