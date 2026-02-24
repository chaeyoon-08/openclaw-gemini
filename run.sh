#!/bin/bash
# ============================================================
# OpenClaw WebUI - Run
# 게이트웨이 실행 + 접속 URL 안내
# ============================================================
set -e

CONFIG_DIR="$HOME/.openclaw"

# ── 설정 파일 확인 ─────────────────────────────────────────
if [ ! -f "$CONFIG_DIR/openclaw.json" ]; then
  echo "❌ 설정 파일이 없습니다. 먼저 setup.sh를 실행하세요."
  exit 1
fi

# ── API 키 로드 ────────────────────────────────────────────
if [ -f "$CONFIG_DIR/.env" ]; then
  export $(grep -v '^#' "$CONFIG_DIR/.env" | grep -v '^$' | xargs)
fi

# ── 게이트웨이 토큰 추출 ───────────────────────────────────
TOKEN=$(python3 -c "import json; d=json.load(open('$CONFIG_DIR/openclaw.json')); print(d['gateway']['auth']['token'])")
ACCESS_URL="http://localhost:18789/?token=${TOKEN}"

echo ""
echo "🦞 OpenClaw WebUI"
echo "=============================="
echo ""

# ── 이미 실행 중인 gateway 종료 ────────────────────────────
if pgrep -f "openclaw gateway" > /dev/null 2>&1; then
  echo "🔄 기존 gateway 종료 중..."
  pkill -f "openclaw gateway" 2>/dev/null || true
  sleep 1
fi

# ── gateway 백그라운드 실행 ────────────────────────────────
echo "🚀 Gateway 시작 중..."
nohup openclaw gateway --port 18789 > "$CONFIG_DIR/gateway.log" 2>&1 &
GATEWAY_PID=$!
sleep 3

# ── 실행 확인 ──────────────────────────────────────────────
if ! ps -p $GATEWAY_PID > /dev/null 2>&1; then
  echo "❌ Gateway 실행 실패. 로그를 확인하세요:"
  cat "$CONFIG_DIR/gateway.log"
  exit 1
fi

echo "✅ Gateway 실행 중 (PID: $GATEWAY_PID)"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
printf '🌐 접속: \e]8;;%s\e\\OpenClaw WebUI 열기\e]8;;\e\\\n' "$ACCESS_URL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  [종료]  $ pkill -f 'openclaw gateway'"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"