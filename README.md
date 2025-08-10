# 🕵️‍♂️ GitHub OSINT Minor Project

## 📌 Overview
This project demonstrates how to use **Open Source Intelligence (OSINT)** techniques to find sensitive information leaked in public GitHub repositories.  
The tool used is **Gitleaks**, which scans repositories for secrets such as API keys, passwords, and private keys.

---

## 🎯 Objective
The main goal is to identify, analyze, and document leaked secrets in public repositories to raise awareness about secure coding practices.

---

## 🛠 Tools Used
- **Gitleaks** – Detects API keys, passwords, and sensitive info.
- **Git** – For cloning repositories.
- **Linux environment** – Ubuntu / Kali / WSL for running commands.
- **Bash** – For automation scripting.

---

## 📂 Project Structure
```
├── repos_list.txt      # List of GitHub repository URLs to scan
├── repos/              # Cloned repositories
├── reports/            # JSON reports from Gitleaks
├── github_osint_minor_project.docx   # Project report
└── README.md           # This file
```

---

## 📜 How It Works
1. **Collect repository URLs** – Use GitHub search (dorking) to find possible repos with secrets.
2. **Scan with Gitleaks** – Run automated scans on each repo.
3. **Generate reports** – Store results as JSON files for analysis.

---

## ⚙️ Installation & Setup
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Gitleaks
GITLEAKS_VER=$(curl -s "https://api.github.com/repos/gitleaks/gitleaks/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+' )
wget -qO gitleaks.tar.gz "https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks_${GITLEAKS_VER}_linux_x64.tar.gz"
sudo tar xf gitleaks.tar.gz -C /usr/local/bin gitleaks
sudo chmod +x /usr/local/bin/gitleaks
gitleaks version
```

---

## 🚀 Usage
1. Add repository links to `repos_list.txt`:
```
https://github.com/OWASP/owasp-mstg.git
https://github.com/OWASP/juice-shop.git
https://github.com/gitleaks/gitleaks.git
```

2. Run the scan:
```bash
mkdir -p repos reports

while read -r repo; do
  name=$(basename "$repo" .git)
  echo "[*] Cloning $repo ..."
  git clone --depth 1 "$repo" repos/"$name" || continue
  echo "[*] Scanning $name ..."
  gitleaks git --repo-path repos/"$name" --report-path reports/"$name"-gitleaks.json --verbose
done < repos_list.txt
```

3. View reports:
```bash
ls reports/
cat reports/<repo-name>-gitleaks.json
```

---

## 📊 Example Finding
```json
{
  "Description": "Hardcoded AWS Secret Key",
  "File": "config/aws_keys.env",
  "StartLine": 3,
  "EndLine": 3,
  "Secret": "AKIA***************",
  "RuleID": "aws-secret-key"
}
```

---

## ⚠️ Legal & Ethical Notice
- Only scan repositories you **own** or have **explicit permission** to test.
- Do **NOT** publish exposed secrets without responsible disclosure.

---

## 📄 License
This project is licensed under the MIT License.
