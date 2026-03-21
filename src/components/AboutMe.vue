<template>
  <div class="page" @mousemove="handleMouseMove">
    <!-- Ambient cursor glow -->
    <div class="cursor-glow" :style="{ left: cursor.x + 'px', top: cursor.y + 'px' }"></div>

    <!-- Top-left logo -->
    <router-link to="/" class="logo-icon animate-logo" style="position: absolute; top: 1.5rem; left: 2rem; z-index: 50;">
      <svg width="36" height="32" viewBox="0 0 36 32" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M0 32 L8 0 L18 20 L28 0 L36 32 L28 32 L18 14 L8 32 Z" fill="#e8622a"/>
      </svg>
    </router-link>

    <!-- Main Content Grid -->
    <div class="split-layout">
      
      <!-- Left Column -->
      <div class="col-left animate-item" style="--delay: 0.1s">
        <!-- About Me -->
        <div class="section-block">
          <h2 class="fancy-title">ABOUT ME</h2>
          <div class="hero-bio">
            I'm a versatile <span class="highlight">Full-Stack Engineer</span> who partners with teams to build <span class="highlight">high-performance systems</span> and seamless digital experiences. I focus on robust architecture, sharp logic, and fast execution.
          </div>
         
        </div>

        <!-- Education Workspace -->
        <div class="section-block mt-lg">
          <h2 class="fancy-title">EDUCATION</h2>
          <div class="education-list hover-focus-list">
            <div class="timeline-row hover-target left-target">
              <span class="time-range">Oct. 2025</span>
              <div class="timeline-details">
                <strong>University of Bedfordshire – SLIIT</strong><br/>
                BSc (Hons) Software Engineering
              </div>
            </div>
            <div class="timeline-row hover-target left-target">
              <span class="time-range">May 2024</span>
              <div class="timeline-details">
                <strong>British College of Applied Studies</strong><br/>
                Higher National Diploma in Software Eng.
              </div>
            </div>
            <div class="timeline-row hover-target left-target">
              <span class="time-range">Dec. 2020</span>
              <div class="timeline-details">
                <strong>National Institute of Business Management</strong><br/>
                Foundation in Software Engineering
              </div>
            </div>
            <div class="timeline-row hover-target left-target">
              <span class="time-range">2007 - 2018</span>
              <div class="timeline-details">
                <strong>S. Thomas’ College Bandarawela</strong><br/>
                Ordinary Level Education
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Center Column (Photo) -->
      <div class="col-center animate-image">
        <div class="photo-wrapper" :style="imageParallax">
          <img src="../assets/aboutme.png" alt="Mishan Luveen Portrait" class="center-photo" />
        </div>
      </div>

      <!-- Right Column -->
      <div class="col-right animate-item" style="--delay: 0.3s">
        
        <div class="section-block">
          <h2 class="fancy-title">SKILLS</h2>
          <div class="softwares-grid">
            <div class="skill-pill pill-csharp">
              <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/csharp/csharp-original.svg" class="tech-icon" />
              C#
            </div>
            <div class="skill-pill pill-dotnet">
              <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/dotnetcore/dotnetcore-original.svg" class="tech-icon" />
              .NET
            </div>
            <div class="skill-pill pill-react">
              <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/react/react-original.svg" class="tech-icon" />
              React
            </div>
            <div class="skill-pill pill-java">
              <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/java/java-original.svg" class="tech-icon" />
              Java
            </div>
            <div class="skill-pill pill-javascript">
              <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/javascript/javascript-original.svg" class="tech-icon" />
              JavaScript
            </div>
            <div class="skill-pill pill-python">
              <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/python/python-original.svg" class="tech-icon" />
              Python
            </div>
            <div class="skill-pill pill-figma">
              <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/figma/figma-original.svg" class="tech-icon" />
              Figma
            </div>
            <div class="skill-pill pill-php">
              <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/php/php-original.svg" class="tech-icon" />
              PHP
            </div>
            <div class="skill-pill pill-sql">
              <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/azuresqldatabase/azuresqldatabase-original.svg" class="tech-icon" />
              SQL
            </div>
            <div class="skill-pill pill-docker">
              <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/docker/docker-original.svg" class="tech-icon" />
              Docker
            </div>
            <div class="skill-pill pill-firebase">
              <img src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/firebase/firebase-original.svg" class="tech-icon" />
              Firebase
            </div>
          </div>
        </div>

        <!-- Experiences -->
        <div class="section-block mt-xl">
          <h2 class="fancy-title">EXPERIENCES</h2>
          
          <div class="experience-timeline hover-focus-list">
            
            <div class="exp-row hover-target right-target">
              <div class="exp-date">Apr. 2023 - Jun. 2025</div>
              <div class="exp-content">
                <strong>HSBC</strong><br/>
                <span class="role">Web Production Officer</span>
              </div>
            </div>

            <div class="exp-row hover-target right-target">
              <div class="exp-date">Jul. 2022 - Mar. 2023</div>
              <div class="exp-content">
                <strong>RR Donnelley – BCG</strong><br/>
                <span class="role">Document Specialist</span>
              </div>
            </div>

            <div class="exp-row hover-target right-target">
              <div class="exp-date">Jan. 2022 - Jun. 2022</div>
              <div class="exp-content">
                <strong>Paradym Consulting</strong><br/>
                <span class="role">Software Engineering Intern</span>
              </div>
            </div>

          </div>
        </div>

        <div class="section-block mt-xl">
          <h2 class="fancy-title">HOBBIES</h2>
          <div class="hobbies-grid">
            
            <div class="hobby-item">
              <div class="hobby-circle" data-tooltip="Playing Guitar">
                <i class="fa-solid fa-guitar"></i>
              </div>
              <span class="hobby-name">Guitar</span>
            </div>

            <div class="hobby-item">
              <div class="hobby-circle" data-tooltip="Camping">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m8 3 4 8 5-5 5 15H2L8 3z"/></svg>
              </div>
              <span class="hobby-name">Camping</span>
            </div>

            <div class="hobby-item">
              <div class="hobby-circle" data-tooltip="EDM Music">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="20" height="20" x="2" y="2" rx="2"/><circle cx="7" cy="7" r="2"/><circle cx="17" cy="7" r="2"/><circle cx="7" cy="17" r="2"/><circle cx="17" cy="17" r="2"/></svg>
              </div>
              <span class="hobby-name">EDM</span>
            </div>

            <div class="hobby-item">
              <div class="hobby-circle" data-tooltip="Gaming">
                <i class="fa-solid fa-gamepad"></i>
              </div>
              <span class="hobby-name">Gaming</span>
            </div>

            <div class="hobby-item">
              <div class="hobby-circle" data-tooltip="Soccer">
                <i class="fa-solid fa-futbol"></i>
              </div>
              <span class="hobby-name">Soccer</span>
            </div>

          </div>
        </div>

      </div>
    </div> <!-- /split-layout -->

    <!-- CLI bottom navbar via shared component -->
    <CliNavbar hint="type 'help' for commands..." />
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import CliNavbar from './CliNavbar.vue'

// Ambient + Parallax
const cursor = ref({ x: -200, y: -200 })
const mouse  = ref({ x: 0, y: 0 })

function handleMouseMove(e) {
  const { innerWidth: w, innerHeight: h } = window
  mouse.value = {
    x: (e.clientX - w / 2) / w,
    y: (e.clientY - h / 2) / h,
  }
  cursor.value = { x: e.clientX, y: e.clientY }
}

const imageParallax = computed(() => ({
  transform: `translate(${mouse.value.x * 12}px, ${mouse.value.y * 12}px)`,
  transition: 'transform 0.6s cubic-bezier(0.23, 1, 0.32, 1)'
}))


</script>

<style>
/* Clean minimalist style */
</style>

<style scoped>
/* ── Page shell ── */
.page {
  width: 100vw;
  height: 100vh;
  background-color: #111111; /* Keep the strict dark theme */
  position: relative;
  overflow: hidden; /* Removed scroll as requested */
  font-family: 'SF Pro Display', sans-serif;
  color: #fff;
  display: flex;
  flex-direction: column;
}

/* ── Cursor ambient ── */
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

.logo-icon {
  display: block;
  transition: transform 0.3s ease;
  cursor: pointer;
}
.logo-icon:hover { transform: scale(1.05); }

/* ── Utilities ── */
.mt-lg { margin-top: 0.8rem; }
.mt-xl { margin-top: 1rem; }

/* ── Main Grid Layout (Left - Photo - Right) ── */
.split-layout {
  display: grid;
  grid-template-columns: 1.15fr 0.9fr 1.15fr; /* 3-column split mapping perfectly to the mockup */
  gap: 1.5rem;
  width: 100%;
  height: 100vh; /* Fixed height to remove scroll */
  max-width: 1600px;
  margin: 0 auto;
  padding: 2.5rem 2.5rem 5.5rem 2.5rem; /* Tightened padding for the single-page fit */
  box-sizing: border-box;
  z-index: 10;
  position: relative;
  overflow: hidden;
}

.col-left {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  padding-top: 4.5rem; /* Shifted down to avoid the logo area */
  padding-right: 2rem;
  z-index: 10;
}

.col-right {
  display: flex;
  flex-direction: column;
  justify-content: flex-start; /* Changed from center to top for better scrolling */
  padding-top: 0.5rem;
  padding-left: 1rem;
  z-index: 10;
}

/* ── The Center Portrait Focus ── */
.col-center {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: flex-end; /* Ground the image to the bottom */
  z-index: 5;
}

.photo-wrapper {
  position: sticky;
  bottom: 0;
  width: 130%; /* Enlarged width */
  max-height: 95vh; /* Larger vertical footprint */
  display: flex;
  justify-content: center;
  will-change: transform;
  margin-bottom: -6.5rem; /* Pulls the photo down past the grid padding to meet the navbar */
  z-index: 5;
}

.center-photo {
  width: 100%;
  height: auto;
  max-height: 90vh; /* Scaled up the photo */
  object-fit: contain;
  object-position: bottom center;
  /* Black and white, intense contrast/clarity, orange outline/glow */
  filter: grayscale(100%)
          contrast(1.1)
          brightness(1)
          drop-shadow(0 0 1px #e8622a) 
          drop-shadow(0 0 10px rgba(232, 98, 42, 0.4));
  
  /* Feathering the edges slightly to mask imperfect cutouts */
  mask-image: radial-gradient(circle at center, black 96%, transparent 100%);
  -webkit-mask-image: radial-gradient(circle at center, black 96%, transparent 100%);
  
  transition: filter 0.5s ease, transform 0.5s ease;
}

.center-photo:hover {
  filter: grayscale(0%) contrast(1.05) brightness(1.1)
          drop-shadow(0 0 15px rgba(232, 98, 42, 0.6));
  transform: scale(1.02);
}

/* ── Section Titles & Typography ── */
.section-block {
  margin-bottom: 0.8rem;
}

.fancy-title {
  display: block;
  margin-top: 0.8rem;
  margin-bottom: 1.2rem;
  font-family: 'SF Mono', 'Menlo', 'Monaco', 'Courier New', monospace;
  font-size: 1.2rem;
  font-weight: 600;
  letter-spacing: 0.15em;
  color: #ffffff;
  position: relative;
  text-transform: uppercase;
}

.fancy-title::first-letter {
  font-size: clamp(1.6rem, 8vw, 2.2rem); /* Scaled for responsiveness */
  color: #ffffff; /* Exact Logo Orange */
  font-weight: 800;
  margin-right: 0.2rem;
  float: left; /* Helps with alignment since it's much larger */
  line-height: 0.8;
}

/* ── Hero Bio Typography ── */
.hero-bio {
  font-family: 'SF Pro Display', -apple-system, sans-serif;
  font-size: 1.4rem;
  line-height: 1.25;
  font-weight: 700;
  letter-spacing: -0.03em; /* Tight kerning like Apple designs */
  color: #ffffff;
  margin-top: 1rem;
  margin-bottom: 1.2rem;
  max-width: 460px;
}
.hero-bio .highlight {
  color: #e8622a;
}
.sub-bio {
  font-size: 0.75rem;
  line-height: 1.5;
  color: #777777;
  max-width: 380px;
  margin-bottom: 1.5rem;
  font-weight: 400;
}
.bio-skills {
  font-size: 0.65rem;
  font-weight: 800;
  letter-spacing: 0.18em;
  color: #bbbbbb;
  display: flex;
  align-items: center;
  gap: 0.7rem;
}
.bio-dot {
  width: 5px;
  height: 5px;
  background-color: #e8622a;
  border-radius: 50%;
  box-shadow: 0 0 6px rgba(232, 98, 42, 0.8);
}

/* ── Education Timeline Row (Left Col) ── */
.education-list {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  position: relative;
}
.education-list::before {
  content: '';
  position: absolute;
  top: 6px;
  bottom: 0;
  left: 135px; /* Standardized to match Experience timeline */
  width: 1px;
  background-color: rgba(255, 255, 255, 0.3);
  z-index: 0;
}
.timeline-row {
  display: flex;
  flex-direction: row; /* Removed row-reverse to align dates left */
  align-items: flex-start;
  position: relative;
  z-index: 1;
  width: 100%;
}
.time-range {
  font-size: 0.78rem;
  color: #888;
  width: 115px;
  margin-right: 20px;
  text-align: left; /* Aligned with heading */
  flex-shrink: 0;
  transition: color 0.3s ease;
}
.timeline-details {
  font-size: 0.85rem;
  line-height: 1.4;
  color: #fff;
  position: relative;
  padding-left: 15px;
  text-align: left;
  flex: 1;
}
.timeline-details::before {
  content: '';
  position: absolute;
  left: -4px; /* Centered on the left line */
  top: 5px;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background-color: #e8622a;
  transition: box-shadow 0.3s ease, background-color 0.3s ease;
}
.timeline-details strong { color: #e8622a; font-weight: 600; letter-spacing: 0.05em; transition: text-shadow 0.3s ease; }

/* ── Softwares Grid (Skill Pills) ── */
.softwares-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 0.8rem;
  max-width: 500px;
  margin-top: 1.2rem;
}

.skill-pill {
  display: inline-flex;
  align-items: center;
  gap: 0.6rem;
  padding: 0.5rem 1rem;
  border-radius: 50px;
  font-size: 0.85rem;
  font-weight: 700;
  letter-spacing: 0.02em;
  transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1);
  cursor: default;
  border: 1px solid rgba(255, 255, 255, 0.05);
  background: rgba(255, 255, 255, 0.02);
  backdrop-filter: blur(5px);
  position: relative;
  overflow: hidden;
}

.skill-pill:hover {
  transform: translateY(-3px) scale(1.03);
  border-color: var(--brand-color);
  box-shadow: 0 10px 20px -5px var(--glow-color);
  background: var(--bg-hover);
}

.tech-icon {
  width: 16px;
  height: 16px;
  object-fit: contain;
  /* Make the icon monochromatic to match the text color */
  filter: grayscale(100%) brightness(200%);
  transition: filter 0.3s ease;
}

.skill-pill:hover .tech-icon {
  filter: none; /* Restore original logo color on hover for premium feel */
}

/* Brand Specific Colors */
.pill-csharp   { --brand-color: #a179dc; --glow-color: rgba(161, 121, 220, 0.3); --bg-hover: rgba(161, 121, 220, 0.1); color: var(--brand-color); }
.pill-dotnet   { --brand-color: #512bd4; --glow-color: rgba(81, 43, 212, 0.3); --bg-hover: rgba(81, 43, 212, 0.1); color: var(--brand-color); }
.pill-react    { --brand-color: #61dafb; --glow-color: rgba(97, 218, 251, 0.3); --bg-hover: rgba(97, 218, 251, 0.1); color: var(--brand-color); }
.pill-java     { --brand-color: #f89820; --glow-color: rgba(248, 152, 32, 0.3); --bg-hover: rgba(248, 152, 32, 0.1); color: var(--brand-color); }
.pill-javascript { --brand-color: #f7df1e; --glow-color: rgba(247, 223, 30, 0.3); --bg-hover: rgba(247, 223, 30, 0.1); color: var(--brand-color); }
.pill-python   { --brand-color: #3776ab; --glow-color: rgba(55, 118, 171, 0.3); --bg-hover: rgba(55, 118, 171, 0.1); color: var(--brand-color); }
.pill-figma    { --brand-color: #f24e1e; --glow-color: rgba(242, 78, 30, 0.3); --bg-hover: rgba(242, 78, 30, 0.1); color: var(--brand-color); }
.pill-php      { --brand-color: #777bb4; --glow-color: rgba(119, 123, 180, 0.3); --bg-hover: rgba(119, 123, 180, 0.1); color: var(--brand-color); }
.pill-sql      { --brand-color: #00bcff; --glow-color: rgba(0, 188, 255, 0.3); --bg-hover: rgba(0, 188, 255, 0.1); color: var(--brand-color); }
.pill-docker   { --brand-color: #2496ed; --glow-color: rgba(36, 150, 237, 0.3); --bg-hover: rgba(36, 150, 237, 0.1); color: var(--brand-color); }
.pill-firebase { --brand-color: #ffca28; --glow-color: rgba(255, 202, 40, 0.3); --bg-hover: rgba(255, 202, 40, 0.1); color: var(--brand-color); }

/* ── Experiences Timeline (Right Col) ── */
.experience-timeline {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  position: relative;
}
.experience-timeline::before {
  content: '';
  position: absolute;
  top: 6px;
  bottom: 0;
  left: 135px; /* Traces exactly through the geometric center of the dots */
  width: 1px;
  background-color: rgba(255, 255, 255, 0.3);
  z-index: 0;
}
.exp-row {
  display: flex;
  align-items: flex-start;
  position: relative;
  z-index: 1;
}
.exp-date {
  font-size: 0.78rem;
  color: #888;
  width: 115px;
  margin-right: 20px; /* 115 + 20 = 135px barrier */
  text-align: left; /* Aligned with heading */
  flex-shrink: 0;
  transition: color 0.3s ease;
}
.exp-content {
  font-size: 0.85rem;
  line-height: 1.4;
  color: #fff;
  position: relative;
  padding-left: 15px;
  flex: 1;
}
.exp-content::before {
  content: '';
  position: absolute;
  left: -4px; /* Pull back half the width (8px/2) so center is exactly on the 135px line */
  top: 5px;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background-color: #e8622a;
  transition: box-shadow 0.3s ease, background-color 0.3s ease;
}
.role {
  color: #ccc;
  font-size: 0.85rem;
  transition: color 0.3s ease;
}

/* ── Interactive Focus Animations ── */
.hover-focus-list:hover .hover-target:not(:hover) {
  opacity: 0.35;
  filter: blur(1.5px);
}

.hover-target {
  transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1);
  will-change: transform, opacity, filter;
  cursor: default;
}

.left-target:hover {
  transform: translateX(-6px) scale(1.02);
}
.right-target:hover {
  transform: translateX(6px) scale(1.02);
}

/* Specific lighting & glows on hover */
.left-target:hover .timeline-details::before,
.right-target:hover .exp-content::before {
  box-shadow: 0 0 15px 2px #e8622a;
  background-color: #ff8552;
}
.hover-target:hover .time-range,
.hover-target:hover .exp-date {
  color: #fff;
}
.hover-target:hover strong,
.hobby-item:hover .hobby-label {
  text-shadow: 0 0 8px rgba(232, 98, 42, 0.5);
}

/* ── Hobbies Grid (Circular Icons) ── */
.hobbies-grid {
  display: flex;
  flex-direction: row;
  gap: 1.5rem;
  margin-top: 1.2rem;
}

.hobby-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.6rem;
}

.hobby-circle {
  width: 44px;
  height: 44px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.06);
  border-radius: 50%;
  color: #888;
  transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1);
  cursor: help;
  position: relative;
  backdrop-filter: blur(10px);
}

.hobby-name {
  font-family: 'SF Mono', monospace;
  font-size: 0.55rem;
  font-weight: 600;
  color: #555;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  transition: color 0.3s ease;
}

.hobby-circle i {
  font-size: 1.1rem;
  transition: transform 0.3s ease, color 0.3s ease;
}

.hobby-circle svg {
  transition: transform 0.3s ease, color 0.3s ease;
}

.hobby-item:hover .hobby-circle {
  background: rgba(232, 98, 42, 0.1);
  border-color: #e8622a;
  color: #e8622a;
  transform: translateY(-3px) scale(1.05);
  box-shadow: 0 8px 20px -5px rgba(232, 98, 42, 0.4);
}

.hobby-item:hover .hobby-circle i,
.hobby-item:hover .hobby-circle svg {
  transform: scale(1.2);
}

.hobby-item:hover .hobby-name {
  color: #e8622a;
}

/* ── Animations ── */
@keyframes fadeUp {
  from { opacity: 0; transform: translateY(20px); }
  to   { opacity: 1; transform: translateY(0); }
}
@keyframes fadeIn {
  from { opacity: 0; }
  to   { opacity: 1; }
}
.animate-logo { animation: fadeIn 0.6s ease forwards; }
.animate-item {
  opacity: 0;
  animation: fadeUp 0.7s cubic-bezier(0.22, 1, 0.36, 1) forwards;
  animation-delay: var(--delay, 0s);
}
.animate-image {
  opacity: 0;
  transform: translateY(30px);
  animation: fadeUp 1s ease 0.2s forwards;
}

/* ── Fallback Media Queries ── */
/* ── Mobile Responsiveness & Layout Shifting ── */
@media (max-width: 991px) {
  .page {
    overflow-y: auto !important; /* Force scrollable on mobile */
    height: auto !important;
    min-height: 100vh;
  }

  .split-layout {
    display: flex;
    flex-direction: column;
    padding: 6rem 1.2rem 8rem 1.2rem; /* More generous mobile padding */
    height: auto !important;
    gap: 3rem;
  }

  /* Reorder columns to show Bio first, then Portrait, then the rest */
  .col-left { order: 1; padding: 0; }
  .col-center { order: 2; height: auto; min-height: 400px; padding: 0; margin-top: -1rem; margin-bottom: 2rem; }
  .col-right { order: 3; padding: 0; }

  .photo-wrapper {
    position: relative;
    bottom: auto;
    width: 100%;
    margin-bottom: 0;
  }

  .center-photo {
    max-height: 50vh; /* Shorter for mobile to keep stack efficient */
    width: auto;
  }

  .fancy-title {
    font-size: 1.1rem;
    letter-spacing: 0.15em;
  }
  .fancy-title::first-letter {
    font-size: 1.5rem; /* Scaled down for mobile */
  }

  .sub-bio {
    max-width: 100%;
    font-size: 0.8rem;
  }

  .timeline-row,
  .exp-row {
    flex-direction: column;
    gap: 0.5rem;
  }

  .time-range,
  .exp-date {
    width: auto;
    margin: 0;
    font-weight: 700;
    letter-spacing: 0.05em;
  }

  .education-list::before,
  .experience-timeline::before {
    left: -15px; /* Shift timeline line to the far left edge */
  }

  .timeline-details,
  .exp-content {
    padding-left: 15px;
    border-left: 1px solid rgba(232, 98, 42, 0.4); /* Use a simple border as timeline line on mobile */
  }
  .timeline-details::before,
  .exp-content::before {
    left: -19.5px; /* Aligns with the shifted line at -15px */
  }
}

/* Extra small screens */
@media (max-width: 480px) {
  .logo-group { left: 1.5rem; top: 1.2rem; }
}
</style>
