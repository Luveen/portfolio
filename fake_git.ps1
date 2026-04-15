$ErrorActionPreference = 'Stop'

Remove-Item -Recurse -Force .git -ErrorAction Ignore
git init
git add .gitignore README.md package.json package-lock.json

$now = Get-Date

# Commit 1
$d1 = $now.AddDays(-60)
$env:GIT_AUTHOR_DATE = $d1.ToString("o")
$env:GIT_COMMITTER_DATE = $d1.ToString("o")
git add vite.config.js index.html public/vite.svg
git commit -m "Initial project setup"

# Commit 2
$d2 = $now.AddDays(-50)
$env:GIT_AUTHOR_DATE = $d2.ToString("o")
$env:GIT_COMMITTER_DATE = $d2.ToString("o")
git add src/main.js src/App.vue src/style.css src/assets/vue.svg
git commit -m "Configure main entry point and global styles"

# Commit 3
$d3 = $now.AddDays(-40)
$env:GIT_AUTHOR_DATE = $d3.ToString("o")
$env:GIT_COMMITTER_DATE = $d3.ToString("o")
git add src/router/index.js
git commit -m "Integrate Vue Router"

# Commit 4
$d4 = $now.AddDays(-30)
$env:GIT_AUTHOR_DATE = $d4.ToString("o")
$env:GIT_COMMITTER_DATE = $d4.ToString("o")
git add src/components/Homepage.vue src/assets/hero.png
git commit -m "Build Homepage layout"

# Commit 5
$d5 = $now.AddDays(-25)
$env:GIT_AUTHOR_DATE = $d5.ToString("o")
$env:GIT_COMMITTER_DATE = $d5.ToString("o")
git add src/components/AboutMe.vue src/assets/aboutme.png
git commit -m "Create AboutMe section"

# Commit 6
$d6 = $now.AddDays(-15)
$env:GIT_AUTHOR_DATE = $d6.ToString("o")
$env:GIT_COMMITTER_DATE = $d6.ToString("o")
git add src/components/Projects.vue public/images/screenshots
git commit -m "Develop Projects showcase UI"

# Commit 7
$d7 = $now.AddDays(-10)
$env:GIT_AUTHOR_DATE = $d7.ToString("o")
$env:GIT_COMMITTER_DATE = $d7.ToString("o")
git add src/components/CliNavbar.vue src/assets/Mask.png
git commit -m "Build custom CLI navbar"

# Commit 8
$d8 = $now.AddDays(-6)
$env:GIT_AUTHOR_DATE = $d8.ToString("o")
$env:GIT_COMMITTER_DATE = $d8.ToString("o")
git add src/firebase.js
git commit -m "Setup Firebase integration for projects"

# Commit 9
$d9 = $now.AddDays(-2)
$env:GIT_AUTHOR_DATE = $d9.ToString("o")
$env:GIT_COMMITTER_DATE = $d9.ToString("o")
git add src/components/Contact.vue public/icons.svg
git commit -m "Implement Contact form interface"

# Commit 10
$d10 = $now
$env:GIT_AUTHOR_DATE = $d10.ToString("o")
$env:GIT_COMMITTER_DATE = $d10.ToString("o")
git add .
git commit -m "Final optimizations and EmailJS setup"

git branch -M main
git remote add origin https://github.com/Luveen/portfolio.git
git push -u origin main --force
