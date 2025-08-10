#!/bin/bash
# Minor Project: GitHub OSINT Automation Script

echo "[*] Starting GitHub OSINT Scan..."

# Check for repos_list.txt
if [ ! -f repos_list.txt ]; then
    echo "[!] repos_list.txt not found. Please create it with repository URLs."
    exit 1
fi

# Create directories
mkdir -p repos reports

# Loop through each repo and scan
while read -r repo; do
  name=$(basename "$repo" .git)
  echo "[*] Cloning $repo ..."
  git clone --depth 1 "$repo" repos/"$name" || continue
  echo "[*] Scanning $name ..."
  gitleaks git --repo-path repos/"$name" --report-path reports/"$name"-gitleaks.json --verbose
done < repos_list.txt

echo "[*] Scan complete. Reports saved in ./reports"
