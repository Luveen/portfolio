<template>
  <div class="page" @mousemove="handleMouseMove">
    <!-- Ambient cursor glow -->
    <div class="cursor-glow" :style="{ left: cursor.x + 'px', top: cursor.y + 'px' }"></div>

    <!-- Decorative grid lines -->
    <div class="grid-bg"></div>

    <!-- Top-left logo -->
    <router-link to="/" class="logo-icon animate-logo">
      <svg width="36" height="32" viewBox="0 0 36 32" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M0 32 L8 0 L18 20 L28 0 L36 32 L28 32 L18 14 L8 32 Z" fill="#e8622a"/>
      </svg>
    </router-link>

    <!-- Page Header -->
      <div class="page-header animate-item" style="--delay: 0.05s">
        <span class="page-label">GET IN TOUCH</span>
        <h1 class="page-title">
          <span class="title-outline">Let's</span>
          <span class="title-solid">Connect<em>.</em></span>
        </h1>
        <p class="page-subtitle">Open to new opportunities, collaborations, and interesting conversations.</p>
      </div>

      <!-- Main contact grid -->
      <div class="contact-grid">

        <!-- Left: Info Cards -->
        <div class="info-col animate-item" style="--delay: 0.2s">

          <!-- Contact details card -->
          <div class="glass-card contact-card">
            <div class="liquid-outline"></div>
            <div class="card-header">
              <span class="dot"></span><span class="dot"></span><span class="dot"></span>
              <span class="card-file">contact.json</span>
            </div>

            <div class="contact-details-list">
              <div
                class="contact-detail"
                v-for="item in contactItems"
                :key="item.label"
                @mouseenter="item.hovered = true"
                @mouseleave="item.hovered = false"
                :class="{ 'is-hovered': item.hovered }"
              >
                <div class="detail-icon" v-html="item.icon"></div>
                <div class="detail-body">
                  <span class="detail-label">{{ item.label }}</span>
                  <a :href="item.href" class="detail-value" target="_blank" rel="noopener">{{ item.value }}</a>
                </div>
                <span class="detail-arrow">→</span>
              </div>
            </div>
          </div>

        </div>

        <!-- Right: Contact Form -->
        <div class="form-col animate-item" style="--delay: 0.3s">
          <div class="glass-card form-card">
            <div class="liquid-outline reverse"></div>
            <div class="card-header">
              <span class="dot"></span><span class="dot"></span><span class="dot"></span>
              <span class="card-file">message.send</span>
            </div>

            <form class="contact-form" @submit.prevent="sendMessage" novalidate>
              <div class="form-row">
                <div class="form-field" :class="{ 'has-value': form.name, 'has-error': errors.name }">
                  <label class="form-label" for="contact-name">
                    <span class="label-prompt">$</span> name
                  </label>
                  <input
                    id="contact-name"
                    v-model="form.name"
                    type="text"
                    class="form-input"
                    placeholder="Your full name"
                    autocomplete="name"
                    @blur="validateField('name')"
                  />
                  <span class="field-error" v-if="errors.name">{{ errors.name }}</span>
                </div>
                <div class="form-field" :class="{ 'has-value': form.email, 'has-error': errors.email }">
                  <label class="form-label" for="contact-email">
                    <span class="label-prompt">$</span> email
                  </label>
                  <input
                    id="contact-email"
                    v-model="form.email"
                    type="email"
                    class="form-input"
                    placeholder="your@email.com"
                    autocomplete="email"
                    @blur="validateField('email')"
                  />
                  <span class="field-error" v-if="errors.email">{{ errors.email }}</span>
                </div>
              </div>

              <div class="form-field" :class="{ 'has-value': form.subject, 'has-error': errors.subject }">
                <label class="form-label" for="contact-subject">
                  <span class="label-prompt">$</span> subject
                </label>
                <input
                  id="contact-subject"
                  v-model="form.subject"
                  type="text"
                  class="form-input"
                  placeholder="What's this about?"
                  @blur="validateField('subject')"
                />
                <span class="field-error" v-if="errors.subject">{{ errors.subject }}</span>
              </div>

              <div class="form-field textarea-field" :class="{ 'has-value': form.message, 'has-error': errors.message }">
                <label class="form-label" for="contact-message">
                  <span class="label-prompt">$</span> message
                </label>
                <textarea
                  id="contact-message"
                  v-model="form.message"
                  class="form-input form-textarea"
                  rows="6"
                  placeholder="Tell me what you're thinking..."
                  @blur="validateField('message')"
                ></textarea>
                <span class="field-error" v-if="errors.message">{{ errors.message }}</span>
              </div>

              <!-- Submit -->
              <div class="form-footer">
                <div class="char-count">
                  <span :class="{ 'over-limit': form.message.length > 600 }">{{ form.message.length }}</span>
                  <span class="char-limit"> / 600</span>
                </div>
                <button type="submit" class="send-btn" :disabled="isSending || sent">
                  <span v-if="!isSending && !sent" class="btn-inner">
                    <span class="btn-text">Submit</span>
                    <span class="btn-icon">
                      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="22" y1="2" x2="11" y2="13"/>
                        <polygon points="22 2 15 22 11 13 2 9 22 2"/>
                      </svg>
                    </span>
                  </span>
                  <span v-else-if="isSending" class="btn-inner btn-loading">
                    <span class="spinner"></span>
                    SENDING...
                  </span>
                  <span v-else class="btn-inner btn-sent">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                      <polyline points="20 6 9 17 4 12"/>
                    </svg>
                    SENT!
                  </span>
                </button>
              </div>
            </form>
          </div>
        </div>

      </div>

    <!-- CLI bottom navbar via shared component -->
    <CliNavbar hint="type 'help' for commands..." />

  </div>
</template>

<script setup>
import { ref, reactive, onUnmounted } from 'vue'
import CliNavbar from './CliNavbar.vue'
import emailjs from '@emailjs/browser'

// ── Cursor ──
const cursor    = ref({ x: -200, y: -200 })
const mouse     = ref({ x: 0, y: 0 })

function handleMouseMove(e) {
  cursor.value = { x: e.clientX, y: e.clientY }
  const { innerWidth: w, innerHeight: h } = window
  mouse.value = { x: (e.clientX - w / 2) / (w / 2), y: (e.clientY - h / 2) / (h / 2) }
}

// ── Contact Info Items ──
const contactItems = reactive([
  {
    label: 'EMAIL',
    value: 'mishanluveen08@gmail.com',
    href: 'mailto:mishanluveen08@gmail.com',
    hovered: false,
    icon: `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect width="20" height="16" x="2" y="4" rx="2"/><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/></svg>`
  },
  {
    label: 'LOCATION',
    value: 'Colombo, Sri Lanka',
    href: 'https://maps.google.com/?q=Colombo,Sri+Lanka',
    hovered: false,
    icon: `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"/><circle cx="12" cy="10" r="3"/></svg>`
  },
  {
    label: 'LINKEDIN',
    value: 'linkedin.com/in/mishan-luveen',
    href: 'https://www.linkedin.com/in/mishan-luveen/',
    hovered: false,
    icon: `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"/><rect width="4" height="12" x="2" y="9"/><circle cx="4" cy="4" r="2"/></svg>`
  },
  {
    label: 'GITHUB',
    value: 'github.com/Luveen',
    href: 'https://github.com/Luveen',
    hovered: false,
    icon: `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M15 22v-4a4.8 4.8 0 0 0-1-3.5c3 0 6-2 6-5.5.08-1.25-.27-2.48-1-3.5.28-1.15.28-2.35 0-3.5 0 0-1 0-3 1.5-2.64-.5-5.36-.5-8 0C6 2 5 2 5 2c-.3 1.15-.3 2.35 0 3.5A5.403 5.403 0 0 0 4 9c0 3.5 3 5.5 6 5.5-.39.49-.68 1.05-.85 1.65-.17.6-.22 1.23-.15 1.85v4"/><path d="M9 18c-4.51 2-5-2-7-2"/></svg>`
  },
  {
    label: 'INSTAGRAM',
    value: '__luvee.n__',
    href: 'https://www.instagram.com/__luvee.n__/',
    hovered: false,
    icon: `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect width="20" height="20" x="2" y="2" rx="5" ry="5"/><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"/><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"/></svg>`
  }
])

// ── Social Links ──
const socials = [
  {
    label: 'GitHub',
    ext: '/Luveen',
    href: 'https://github.com/Luveen',
    colorClass: 'social-github',
    icon: `<svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M12 0C5.37 0 0 5.373 0 12c0 5.303 3.438 9.8 8.207 11.387.6.11.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23A11.509 11.509 0 0 1 12 5.803c1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576C20.566 21.797 24 17.3 24 12c0-6.627-5.373-12-12-12z"/></svg>`
  },
  {
    label: 'Instagram',
    ext: '__luvee.n__',
    href: 'https://www.instagram.com/__luvee.n__/',
    colorClass: 'social-instagram',
    icon: `<svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.052.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98C8.333 23.986 8.741 24 12 24c3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 1 0 0 12.324 6.162 6.162 0 0 0 0-12.324zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm6.406-11.845a1.44 1.44 0 1 0 0 2.881 1.44 1.44 0 0 0 0-2.881z"/></svg>`
  },
  {
    label: 'Email',
    ext: 'mishanluveen08@gmail.com',
    href: 'mailto:mishanluveen08@gmail.com',
    colorClass: 'social-email',
    icon: `<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="20" height="16" x="2" y="4" rx="2"/><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/></svg>`
  }
]

// ── Form ──
const form = reactive({ name: '', email: '', subject: '', message: '' })
const errors = reactive({ name: '', email: '', subject: '', message: '' })
const isSending = ref(false)
const sent = ref(false)

function validateField(field) {
  errors[field] = ''
  if (field === 'name' && !form.name.trim()) errors.name = 'Name is required.'
  if (field === 'email') {
    if (!form.email.trim()) errors.email = 'Email is required.'
    else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email)) errors.email = 'Invalid email address.'
  }
  if (field === 'subject' && !form.subject.trim()) errors.subject = 'Subject is required.'
  if (field === 'message' && !form.message.trim()) errors.message = 'Message cannot be empty.'
}

function validateAll() {
  ['name', 'email', 'subject', 'message'].forEach(f => validateField(f))
  return !Object.values(errors).some(e => e)
}

async function sendMessage() {
  if (!validateAll()) return
  isSending.value = true

  try {
    const serviceID = import.meta.env.VITE_EMAILJS_SERVICE_ID;
    const templateID = import.meta.env.VITE_EMAILJS_TEMPLATE_ID;
    const publicKey = import.meta.env.VITE_EMAILJS_PUBLIC_KEY;

    if (!serviceID || serviceID === 'your_service_id_here') {
      console.warn("EmailJS credentials are missing. Please check your .env file.");
      throw new Error("Missing EmailJS configuration");
    }

    const templateParams = {
      name: form.name,
      email: form.email,
      subject: form.subject,
      message: form.message,
    };

    await emailjs.send(serviceID, templateID, templateParams, {
      publicKey: publicKey,
    });

    sent.value = true;
    setTimeout(() => {
      sent.value = false;
      form.name = '';
      form.email = '';
      form.subject = '';
      form.message = '';
    }, 3000);
  } catch (error) {
    console.error('FAILED...', error);
    // Notify the user or log
    alert('Oops! Something went wrong while sending the message.');
  } finally {
    isSending.value = false;
  }
}
</script>

<style scoped>
/* ── Page Shell ── */
.page {
  width: 100vw;
  height: 100vh;
  background-color: #0b0b0b;
  position: relative;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  font-family: 'SF Pro Display', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  color: #fff;
}

/* ── Grid Background ── */
.grid-bg {
  position: fixed;
  inset: 0;
  background-image:
    linear-gradient(rgba(232, 98, 42, 0.03) 1px, transparent 1px),
    linear-gradient(90deg, rgba(232, 98, 42, 0.03) 1px, transparent 1px);
  background-size: 60px 60px;
  pointer-events: none;
  z-index: 0;
}

/* ── Cursor Ambient Glow ── */
.cursor-glow {
  position: fixed;
  width: 500px;
  height: 500px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(232, 98, 42, 0.09) 0%, transparent 70%);
  transform: translate(-50%, -50%);
  pointer-events: none;
  z-index: 0;
  transition: left 0.08s ease, top 0.08s ease;
}

/* ── Logo ── */
.logo-icon {
  position: fixed;
  top: 1.8rem;
  left: 2.5rem;
  z-index: 200;
  display: block;
  transition: transform 0.3s ease;
  cursor: pointer;
}
.logo-icon:hover { transform: scale(1.08); }

/* ── Animations ── */
@keyframes fadeUp {
  from { opacity: 0; transform: translateY(24px); }
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

/* ── Page Header ── */
.page-header {
  position: relative;
  z-index: 10;
  padding: 4.5rem 2.5rem 0.5rem 2.5rem;
  display: flex;
  flex-direction: column;
  gap: 0.2rem;
  flex-shrink: 0;
}

.page-label {
  font-family: 'SF Mono', 'Fira Code', monospace;
  font-size: 0.65rem;
  font-weight: 700;
  letter-spacing: 0.22em;
  color: #e8622a;
  text-transform: uppercase;
}

.page-title {
  display: flex;
  align-items: baseline;
  gap: 0.6rem;
  margin: 0;
  line-height: 1;
}

.title-outline {
  font-size: clamp(1.6rem, 3.5vw, 2.8rem);
  font-weight: 900;
  color: transparent;
  -webkit-text-stroke: 1.5px #e8622a;
  letter-spacing: -0.03em;
}

.title-solid {
  font-size: clamp(1.6rem, 3.5vw, 2.8rem);
  font-weight: 900;
  color: #e8622a;
  letter-spacing: -0.03em;
}

.title-solid em {
  font-style: normal;
  color: #fff;
}

.page-subtitle {
  font-size: 0.75rem;
  color: #555;
  font-weight: 400;
  letter-spacing: 0.03em;
  max-width: 460px;
  margin-top: 0.1rem;
}

/* ── Contact Grid ── */
.contact-grid {
  flex: 1;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.2rem;
  padding: 0 2.5rem 4.5rem 2.5rem;
  position: relative;
  z-index: 10;
  min-height: 0;
  overflow: hidden;
}

.info-col {
  display: flex;
  flex-direction: column;
  min-height: 0;
}

/* ── Glass Card (shared) ── */
.glass-card {
  background: rgba(15, 15, 15, 0.6);
  backdrop-filter: blur(14px);
  border: 1px solid rgba(255, 255, 255, 0.06);
  border-radius: 14px;
  padding: 1rem 1.3rem;
  position: relative;
  overflow: hidden;
  box-sizing: border-box;
  height: 100%;
  transition: border-color 0.3s ease;
}
.glass-card:hover {
  border-color: rgba(232, 98, 42, 0.18);
}

/* ── Liquid Outline Animation ── */
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
  z-index: 0;
  pointer-events: none;
  opacity: 0.5;
}
.liquid-outline.slow    { animation-duration: 7s; animation-direction: reverse; opacity: 0.3; }
.liquid-outline.reverse { animation-duration: 5.5s; animation-direction: reverse; }

@keyframes liquidFlow {
  from { transform: rotate(0deg); }
  to   { transform: rotate(360deg); }
}

/* ── Card Header ── */
.card-header {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  margin-bottom: 0.6rem;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.04);
  position: relative;
  z-index: 1;
}
.dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.12);
}
.card-file {
  font-family: 'SF Mono', 'Fira Code', monospace;
  font-size: 0.68rem;
  color: #444;
  margin-left: 0.4rem;
  letter-spacing: 0.04em;
}

/* ── Contact Detail Items ── */
.contact-detail {
  display: flex;
  align-items: center;
  gap: 0.7rem;
  padding: 0.45rem 0.4rem;
  border-radius: 8px;
  cursor: pointer;
  transition: background 0.25s ease, transform 0.25s ease;
  position: relative;
  z-index: 1;
}
.contact-detail:hover,
.contact-detail.is-hovered {
  background: rgba(232, 98, 42, 0.06);
  transform: translateX(4px);
}

.detail-icon {
  width: 30px;
  height: 30px;
  background: rgba(232, 98, 42, 0.08);
  border: 1px solid rgba(232, 98, 42, 0.15);
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #e8622a;
  flex-shrink: 0;
  transition: background 0.25s ease, box-shadow 0.25s ease;
}
.contact-detail.is-hovered .detail-icon {
  background: rgba(232, 98, 42, 0.15);
  box-shadow: 0 4px 14px rgba(232, 98, 42, 0.2);
}

.detail-body {
  display: flex;
  flex-direction: column;
  gap: 0.1rem;
  flex: 1;
  min-width: 0;
}
.detail-label {
  font-family: 'SF Mono', monospace;
  font-size: 0.52rem;
  color: #555;
  letter-spacing: 0.15em;
  text-transform: uppercase;
}
.detail-value {
  font-size: 0.8rem;
  color: #aaa;
  text-decoration: none;
  letter-spacing: 0.01em;
  transition: color 0.2s ease;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.contact-detail.is-hovered .detail-value { color: #e8622a; }

.detail-arrow {
  color: #e8622a;
  font-size: 0.9rem;
  opacity: 0;
  transform: translateX(-6px);
  transition: opacity 0.2s ease, transform 0.2s ease;
  flex-shrink: 0;
}
.contact-detail.is-hovered .detail-arrow {
  opacity: 1;
  transform: translateX(0);
}



/* ── Contact Info Card ── */
.contact-card {
  display: flex;
  flex-direction: column;
}

.contact-details-list {
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;
  flex: 1;
  gap: 0.25rem;
}

/* ── Contact Form Card ── */
.form-card {
  display: flex;
  flex-direction: column;
}

.contact-form {
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
  position: relative;
  z-index: 1;
  flex: 1;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 0.6rem;
}

/* ── Form Fields ── */
.form-field {
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
  position: relative;
}

.form-label {
  font-family: 'SF Mono', 'Fira Code', monospace;
  font-size: 0.63rem;
  letter-spacing: 0.12em;
  color: #444;
  text-transform: uppercase;
  transition: color 0.2s ease;
}
.form-field:focus-within .form-label { color: #e8622a; }

.label-prompt {
  color: #e8622a;
  margin-right: 0.2rem;
  font-weight: 700;
}

.form-input {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.07);
  border-radius: 8px;
  padding: 0.45rem 0.8rem;
  color: #fff;
  font-size: 0.78rem;
  font-family: inherit;
  outline: none;
  transition: border-color 0.25s ease, background 0.25s ease, box-shadow 0.25s ease;
  width: 100%;
  box-sizing: border-box;
}
.form-input::placeholder { color: #333; }
.form-input:focus {
  border-color: rgba(232, 98, 42, 0.5);
  background: rgba(232, 98, 42, 0.04);
  box-shadow: 0 0 0 3px rgba(232, 98, 42, 0.08);
}

.textarea-field {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.form-textarea {
  resize: none;
  line-height: 1.5;
  min-height: 70px;
  flex: 1;
}

.has-error .form-input {
  border-color: rgba(200, 60, 60, 0.5);
}
.field-error {
  font-family: 'SF Mono', monospace;
  font-size: 0.58rem;
  color: #c83c3c;
  letter-spacing: 0.06em;
}

/* ── Form Footer ── */
.form-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 0.1rem;
}

.char-count {
  font-family: 'SF Mono', monospace;
  font-size: 0.6rem;
  color: #333;
}
.char-count .over-limit { color: #c83c3c; }
.char-limit { color: #333; }

/* ── Send Button ── */
.send-btn {
  display: inline-flex;
  align-items: center;
  cursor: pointer;
  background: #e8622a;
  border: none;
  border-radius: 8px;
  padding: 0.7rem 1.4rem;
  color: #fff;
  font-family: 'SF Mono', 'Fira Code', monospace;
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 0.1em;
  transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
  position: relative;
  overflow: hidden;
}
.send-btn::before {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, rgba(255,255,255,0.12) 0%, transparent 60%);
  opacity: 0;
  transition: opacity 0.3s ease;
}
.send-btn:hover:not(:disabled)::before { opacity: 1; }
.send-btn:hover:not(:disabled) {
  background: #ff7540;
  box-shadow: 0 8px 24px rgba(232, 98, 42, 0.45);
  transform: translateY(-2px);
}
.send-btn:active:not(:disabled) { transform: translateY(0); }
.send-btn:disabled { opacity: 0.7; cursor: not-allowed; }

.btn-inner { display: flex; align-items: center; gap: 0.6rem; }
.btn-sent  { color: #fff; }

/* ── Spinner ── */
.spinner {
  width: 12px;
  height: 12px;
  border: 2px solid rgba(255,255,255,0.3);
  border-top-color: #fff;
  border-radius: 50%;
  animation: spin 0.7s linear infinite;
}
@keyframes spin { to { transform: rotate(360deg); } }

/* ── CLI Navbar is managed by CliNavbar.vue ── */

/* ── Responsive ── */
@media (max-width: 1024px) {
  .contact-grid { gap: 1.2rem; }
}

@media (max-width: 860px) {
  .page { overflow-y: auto; }
  .contact-grid {
    grid-template-columns: 1fr;
    padding: 0 1.5rem 1rem 1.5rem;
    flex: unset;
  }
  .page-header { padding: 5rem 1.2rem 1rem 1.2rem; }
}

@media (max-width: 540px) {
  .form-row { grid-template-columns: 1fr; }
  .title-outline, .title-solid { font-size: 2rem; }
  .logo-icon { top: 1.2rem; left: 1.5rem; }
  .contact-grid { padding: 0 1rem 3rem 1rem; }
  .page-header { padding: 4.5rem 1.2rem 0.8rem 1.2rem; }
}
</style>
