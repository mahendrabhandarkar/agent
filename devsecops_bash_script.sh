#!/bin/bash

# -----------------------------------------------
# Unified DevSecOps Scanning Script
# Author: OpenAI / ChatGPT
# Run this script with: ./scan.sh
# -----------------------------------------------

# Variables
TARGET_DIR=$(pwd)
#TARGET_IMAGE="your-image-name"   # Change this to your built podman image name
TARGET_IMAGE="ksfinalb"
APP_URL="http://localhost:8080"  # Change this if your app runs on a different URL
REPORT_DIR="./scan-reports"
mkdir -p "$REPORT_DIR"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}[+] Starting DevSecOps Scans...${NC}"

# -----------------------------------------------
# 1. Run Gitleaks (Secrets scanning)
# -----------------------------------------------
echo -e "${GREEN}[1/7] Running Gitleaks...${NC}"
podman run --rm -v "$TARGET_DIR:/path" zricethezav/gitleaks detect -s /path -r /path/scan-reports/gitleaks-report.json --report-format json || echo -e "${RED}[-] Gitleaks failed.${NC}"

# -----------------------------------------------
# 2. Run Semgrep (Static Analysis)
# -----------------------------------------------
echo -e "${GREEN}[2/7] Running Semgrep...${NC}"
podman run --rm -v "$TARGET_DIR:/src" returntocorp/semgrep semgrep scan --config auto /src --json > "$REPORT_DIR/semgrep-report.json" || echo -e "${RED}[-] Semgrep failed.${NC}"

# -----------------------------------------------
# 3. Run Checkov (IaC Security)
# -----------------------------------------------
echo -e "${GREEN}[3/7] Running Checkov...${NC}"
podman run --rm -v "$TARGET_DIR:/tf" bridgecrew/checkov --directory /tf --output json > "$REPORT_DIR/checkov-report.json" || echo -e "${RED}[-] Checkov failed.${NC}"

# -----------------------------------------------
# 4. Run Trivy (Image and filesystem scan)
# -----------------------------------------------
echo -e "${GREEN}[4/7] Running Trivy...${NC}"
podman run --rm -v /var/run/docker.sock:/var/run/docker.sock -v "$REPORT_DIR:/output" aquasec/trivy image "$TARGET_IMAGE" --format json --output /output/trivy-report.json || echo -e "${RED}[-] Trivy image scan failed.${NC}"

# -----------------------------------------------
# 5. Run Hadolint (Dockerfile linter)
# -----------------------------------------------
if [ -f Dockerfile ]; then
  echo -e "${GREEN}[5/7] Running Hadolint...${NC}"
  podman run --rm -i hadolint/hadolint < Dockerfile > "$REPORT_DIR/hadolint-report.txt" || echo -e "${RED}[-] Hadolint failed.${NC}"
else
  echo -e "${RED}[-] Dockerfile not found. Skipping Hadolint.${NC}"
fi

# -----------------------------------------------
# 6. Run Nuclei (DAST scanner)
# -----------------------------------------------
echo -e "${GREEN}[6/7] Running Nuclei on $APP_URL...${NC}"
podman run --rm projectdiscovery/nuclei -u "$APP_URL" -json -o "$REPORT_DIR/nuclei-report.json" || echo -e "${RED}[-] Nuclei failed.${NC}"

# -----------------------------------------------
# 7. Run OWASP ZAP (DAST)
# -----------------------------------------------
echo -e "${GREEN}[7/7] Running OWASP ZAP Baseline Scan...${NC}"
podman run --rm -v "$REPORT_DIR:/zap/wrk" owasp/zap2docker-stable zap-baseline.py -t "$APP_URL" -r zap-report.html || echo -e "${RED}[-] ZAP baseline scan failed.${NC}"

# -----------------------------------------------
# Summary
# -----------------------------------------------
echo -e "${GREEN}[✓] Scans completed. Reports saved in: $REPORT_DIR${NC}"
ls -lh "$REPORT_DIR"
