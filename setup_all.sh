# Master script
cat << 'EOF' > setup_all.sh
#!/bin/bash
# Master Setup Script: Phase 1–4

set -e

echo ">>> Running Phase 1: Basic Setup"
bash phase1_setup.sh
echo "### Phase 1 complete: Base system updated, non-root sudo user ensured, firewall (UFW) configured, SSH keys reminder. ###"

echo ">>> Running Phase 2: Security Hardening"
bash phase2_security.sh
echo "### Phase 2 complete: SSH hardened (no root, no passwords), Fail2ban active, Certbot installed. ###"

echo ">>> Running Phase 3: Web Server Enhancements"
bash phase3_webserver.sh
echo "### Phase 3 complete: Static site deployed, Nginx server block configured, optional reverse proxy support prepared. ###"

echo ">>> Running Phase 4: Operations & Monitoring"
bash phase4_monitoring.sh
echo "### Phase 4 complete: Nginx log rotation ensured, monitoring tools installed, quick service check done. ###"

echo "=== All Phases 1–4 Complete ==="
EOF
