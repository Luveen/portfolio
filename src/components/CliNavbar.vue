<template>
  <div class="cli-navbar-container">
    <!-- Terminal Output Floating Box -->
    <transition name="terminal-fade">
      <div v-if="history.length > 0" class="terminal-output-window">
        <div class="terminal-header">
          <span class="dot red"></span>
          <span class="dot yellow"></span>
          <span class="dot green"></span>
          <span class="terminal-title">mishan@portfolio:~</span>
          <button class="terminal-close" @click="history = []">×</button>
        </div>
        <div class="terminal-body" ref="terminalBody">
          <div v-for="(line, idx) in history" :key="idx" class="history-line" :class="line.type">
            <span v-if="line.type === 'input'" class="prompt-prefix">
              <span class="cli-user">mishan</span><span class="cli-sep">@</span><span class="cli-host">portfolio</span><span class="cli-colon">:</span><span class="cli-tilde">~</span><span class="cli-dollar">$</span>
            </span>
            <span v-if="line.type === 'output'" class="output-prefix">></span>
            <span class="history-text" v-html="line.text"></span>
          </div>
        </div>
      </div>
    </transition>

    <!-- CLI bottom navbar (fixed) -->
    <nav class="cli-nav animate-item" style="--delay: 0.6s">
      <div class="cli-prompt-prefix" @click="focusCli">
        <span class="cli-user">mishan</span><span class="cli-sep">@</span><span class="cli-host">portfolio</span><span class="cli-colon">:</span><span class="cli-tilde">~</span><span class="cli-dollar">$</span>
        <span class="cli-typed">{{ typedText }}</span>
        <span class="cli-cursor" :class="{ paused: isTyping }"></span>
        <form @submit.prevent="submitCommand" class="cli-form">
          <input
            ref="cliInput"
            class="cli-hidden-input"
            v-model="typedText"
            @focus="isFocused = true"
            @blur="isFocused = false"
            @keydown="onKeydown"
            autocomplete="off"
            spellcheck="false"
          />
        </form>
        <span v-if="!isFocused && !typedText" class="cli-hint">{{ hint }}</span>
      </div>
      <div class="cli-links">
        <router-link to="/" class="cli-link" exact-active-class="active"><span class="cli-arrow">&gt;</span> Home</router-link>
        <router-link to="/about" class="cli-link" exact-active-class="active"><span class="cli-arrow">&gt;</span> About</router-link>
        <router-link to="/projects" class="cli-link" exact-active-class="active"><span class="cli-arrow">&gt;</span> Projects</router-link>
        <router-link to="/contact" class="cli-link" exact-active-class="active"><span class="cli-arrow">&gt;</span> Contact</router-link>
      </div>
    </nav>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import { getProjects } from '../firebase'

const props = defineProps({
  hint: {
    type: String,
    default: 'click to type...'
  }
})

const router = useRouter()

const typedText = ref('')
const isFocused = ref(false)
const isTyping = ref(false)
const cliInput = ref(null)
let typingTimer = null

const history = ref([])
const terminalBody = ref(null)
const projectList = ref([])

onMounted(async () => {
  projectList.value = await getProjects()
})

function focusCli() {
  cliInput.value?.focus()
}

function onKeydown(e) {
  isTyping.value = true
  clearTimeout(typingTimer)
  typingTimer = setTimeout(() => { isTyping.value = false }, 800)
}

function submitCommand() {
  const cmd = typedText.value.trim()
  if (!cmd) return

  // Add input to history
  history.value.push({ type: 'input', text: cmd })
  typedText.value = ''

  const lowerCmd = cmd.toLowerCase()
  
  // Logic parsing
  if (lowerCmd === 'clear') {
    history.value = []
    return
  }
  
  let response = ''
  
  // Navigation commands
  if (lowerCmd === 'cd /home' || lowerCmd === 'cd ~' || lowerCmd === 'cd /') {
    router.push('/')
    response = 'Navigating to Home...'
  } else if (lowerCmd === 'cd /about' || lowerCmd === 'cd about') {
    router.push('/about')
    response = 'Navigating to About...'
  } else if (lowerCmd === 'cd /projects' || lowerCmd === 'cd projects') {
    router.push('/projects')
    response = 'Navigating to Projects...'
  } else if (lowerCmd === 'cd /contact' || lowerCmd === 'cd contact') {
    router.push('/contact')
    response = 'Navigating to Contact...'
  } 
  
  // Project Search & details
  else if (lowerCmd === 'projects' || lowerCmd === 'ls projects') {
    if (projectList.value.length === 0) {
      response = 'Searching for projects... No projects found in system.'
    } else {
      const names = projectList.value.map(p => `<span style="color:#e8622a;">${p.title || p.name}</span>`).join('<br/>')
      response = `<b>Detected Projects:</b><br/>${names}<br/><br/>Type "project [name]" for more details.`
    }
  } else if (lowerCmd.startsWith('project ')) {
    const searchName = lowerCmd.replace('project ', '').trim()
    const found = projectList.value.find(p => (p.title || p.name || '').toLowerCase().includes(searchName))
    
    if (found) {
      const techStr = found.techStack ? (Array.isArray(found.techStack) ? found.techStack.map(t => typeof t === 'string' ? t : (t.name || '')).join(', ') : found.techStack) : 'N/A'
      response = `<b>${found.title || found.name}</b><br/><i>${found.tagline || found.category || ''}</i><br/><br/>${found.description || ''}<br/><br/><b>Stack:</b> ${techStr}`
      if (found.demoUrl || found.githubUrl) {
         response += `<br/><br/><b>Links:</b> ${found.demoUrl ? `<a href="${found.demoUrl}" style="color:#e8622a;" target="_blank">Demo</a>` : ''} ${found.githubUrl ? `<a href="${found.githubUrl}" style="color:#e8622a;" target="_blank">Github</a>` : ''}`
      }
    } else {
      response = `Project "<i>${searchName}</i>" not found. Type "projects" to see the full list.`
    }
  }

  // Q&A Logic
  else if (lowerCmd.includes('experience') || lowerCmd.includes('work') || lowerCmd.includes('job')) {
    response = '<b>3+ Years Experience:</b><br/>- Web Production Officer @ HSBC (2023-Present)<br/>- Document Specialist @ RR Donnelley (2022-2023)<br/>- Software Eng Intern @ Paradym Consulting (2022)'
  } else if (lowerCmd.includes('skill') || lowerCmd.includes('stack') || lowerCmd.includes('tech')) {
    response = '<b>Tech Stack:</b> Vue.js, React, C#, .NET, Python, Java, JavaScript, PHP, SQL, Docker, Firebase, Figma.'
  } else if (lowerCmd.includes('education') || lowerCmd.includes('study') || lowerCmd.includes('degree') || lowerCmd.includes('school')) {
    response = '<b>Education:</b><br/>- BSc (Hons) Software Engineering @ SLIIT<br/>- Higher National Diploma in Software Eng. @ BCAS<br/>- Foundation in Software Eng. @ NIBM'
  } else if (lowerCmd.includes('hobby') || lowerCmd.includes('hobbies') || lowerCmd.includes('interest') || lowerCmd.includes('fun')) {
    response = '<b>Hobbies:</b> Playing Guitar, Camping, EDM Music, Gaming, and Soccer.'
  } else if (lowerCmd.includes('contact') || lowerCmd.includes('email') || lowerCmd.includes('reach') || lowerCmd.includes('phone')) {
    response = '<b>Contact:</b><br/>- Email: <a href="mailto:mishanluveen08@gmail.com" style="color:#e8622a;">mishanluveen08@gmail.com</a><br/>- LinkedIn: <a href="https://linkedin.com/in/mishan-luveen" style="color:#e8622a;" target="_blank">in/mishan-luveen</a><br/>Or type "cd /contact" to use the form!'
  } else if (lowerCmd.includes('hello') || lowerCmd.includes('hi') || lowerCmd.includes('hey')) {
    response = 'Hello there! Feel free to ask about my experience, skills, or projects. Type "help" for options.'
  } else if (lowerCmd === 'help') {
    response = '<b>Available queries:</b><br/>- "projects": List all my work<br/>- "project [name]": View details<br/>- "experience": See my work history<br/>- "skills": View tech stack<br/>- "education": View my degrees<br/>- "hobbies": What I do for fun<br/>- "contact": Get my email<br/>- "cd /[page]": Navigate site<br/>- "clear": Clean terminal'
  } else if (lowerCmd.includes('who are you') || lowerCmd.includes('about')) {
    response = 'I am Mishan Luveen, a passionate developer creating highly functional, visually striking front-end applications.'
  } else {
    response = `Command not recognized: <i>${cmd}</i><br/>Type "help" for available commands.`
  }

  // Delay output slightly for realism
  setTimeout(() => {
    history.value.push({ type: 'output', text: response })
    scrollToBottom()
  }, 300)
}

function scrollToBottom() {
  nextTick(() => {
    if (terminalBody.value) {
      terminalBody.value.scrollTop = terminalBody.value.scrollHeight
    }
  })
}

onUnmounted(() => {
  clearTimeout(typingTimer)
})
</script>

<style scoped>
/* ── Terminal Floating Window ── */
.terminal-output-window {
  position: fixed;
  bottom: 80px; /* Right above the navbar */
  left: 3rem;
  width: 500px;
  max-width: 90vw;
  max-height: 400px;
  background: rgba(10, 10, 10, 0.95);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  z-index: 1000;
  display: flex;
  flex-direction: column;
  box-shadow: 0 10px 40px rgba(0,0,0,0.8);
  font-family: 'SF Mono', 'Fira Code', 'Cascadia Code', 'Consolas', monospace;
  overflow: hidden;
}

.terminal-header {
  padding: 0.6rem 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
  display: flex;
  align-items: center;
  position: relative;
}

.dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  margin-right: 6px;
}
.dot.red { background: #ff5f56; }
.dot.yellow { background: #ffbd2e; }
.dot.green { background: #27c93f; }

.terminal-title {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
  font-size: 0.7rem;
  color: #888;
  font-weight: 600;
}

.terminal-close {
  margin-left: auto;
  background: transparent;
  border: none;
  color: #888;
  font-size: 1.2rem;
  cursor: pointer;
  line-height: 1;
  padding: 0;
}
.terminal-close:hover { color: #fff; }

.terminal-body {
  padding: 1rem;
  overflow-y: auto;
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 0.8rem;
  font-size: 0.75rem;
  line-height: 1.5;
}

.history-line {
  display: flex;
  gap: 0.5rem;
  align-items: flex-start;
  flex-direction: column;
}

.history-line.input {
  flex-direction: row;
  color: #fff;
}

.history-line.output {
  flex-direction: row;
  color: #ccc;
  padding-left: 0.5rem;
}

.prompt-prefix {
  display: flex;
  align-items: center;
  gap: 0;
  font-size: 0.7rem;
  flex-shrink: 0;
}
.output-prefix {
  color: #e8622a;
  font-weight: bold;
}

.history-text {
  word-break: break-word;
}

.terminal-fade-enter-active,
.terminal-fade-leave-active {
  transition: opacity 0.3s ease, transform 0.3s ease;
}
.terminal-fade-enter-from,
.terminal-fade-leave-to {
  opacity: 0;
  transform: translateY(10px);
}

/* ── CLI Navbar ── */
.cli-nav {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.85rem 3rem;
  border-top: 1px solid rgba(255, 255, 255, 0.08); /* Keeping the solid line for separation */
  background: rgba(11, 11, 11, 0.98);
  backdrop-filter: blur(20px);
  z-index: 2100; /* Above overlay */
  font-family: 'SF Mono', 'Fira Code', 'Cascadia Code', 'Consolas', monospace;
  box-sizing: border-box;
}

.cli-form {
  position: absolute;
  opacity: 0;
  width: 1px;
  height: 1px;
  pointer-events: none;
}

.cli-hidden-input {
  border: none;
  outline: none;
  background: transparent;
  width: 100%;
  color: transparent;
}

.cli-prompt-prefix {
  display: flex;
  align-items: center;
  gap: 0;
  font-size: 0.72rem;
  cursor: text;
  position: relative;
}

.cli-user   { color: #e8622a; font-weight: 700; }
.cli-sep    { color: #555; }
.cli-host   { color: #888; }
.cli-colon  { color: #555; }
.cli-tilde  { color: #888; }
.cli-dollar { color: #e8622a; margin: 0 0.5rem; }

.cli-cursor {
  display: inline-block;
  width: 8px;
  height: 13px;
  background: #e8622a;
  animation: blink 1.1s step-end infinite;
  vertical-align: middle;
  border-radius: 1px;
  flex-shrink: 0;
}

.cli-cursor.paused { animation: none; opacity: 1; }

@keyframes blink { 
  0%, 100% { opacity: 1; } 
  50% { opacity: 0; } 
}

.cli-typed {
  color: #e8622a;
  margin-left: 0.3rem;
  letter-spacing: 0.02em;
  max-width: 300px;
  overflow: hidden;
  white-space: nowrap;
}

.cli-hint {
  color: #333;
  margin-left: 0.4rem;
  font-style: italic;
  letter-spacing: 0.03em;
  animation: fadeHint 1.5s ease-in-out infinite alternate;
}

@keyframes fadeHint {
  from { opacity: 0.3; }
  to   { opacity: 0.7; }
}

.cli-links {
  display: flex;
  align-items: center;
  gap: 2.5rem;
}

.cli-link {
  font-size: 0.72rem;
  font-weight: 500;
  color: #4a4a4a;
  text-decoration: none;
  letter-spacing: 0.06em;
  display: flex;
  align-items: center;
  gap: 0.4rem;
  transition: color 0.25s ease;
  cursor: pointer;
}

.cli-link:hover { color: #ffffff; }
.cli-link.active { color: #e8622a; }

.cli-arrow {
  color: #e8622a;
  font-weight: 700;
  opacity: 0;
  transform: translateX(-4px);
  transition: opacity 0.2s ease, transform 0.2s ease;
}

.cli-link:hover .cli-arrow,
.cli-link.active .cli-arrow {
  opacity: 1;
  transform: translateX(0);
}

/* ── Fallback Media Queries ── */
@media (max-width: 991px) {
  .cli-nav {
    padding: 0.8rem 1.2rem;
    flex-direction: column;
    gap: 0.8rem;
    height: auto;
  }
  .cli-prompt-prefix { display: none; }
  .cli-links {
    width: 100%;
    justify-content: space-between;
    gap: 0.5rem;
  }
  .cli-link { font-size: 0.65rem; padding: 0.4rem 0.2rem; }
  .terminal-output-window {
    left: 1rem;
    right: 1rem;
    width: auto;
    bottom: 100px;
  }
}
@media (max-width: 480px) {
  .cli-nav { padding-bottom: 1.2rem; }
  .cli-links { justify-content: space-around; }
  .cli-link { font-size: 0.62rem; letter-spacing: 0.04em; }
}
</style>
