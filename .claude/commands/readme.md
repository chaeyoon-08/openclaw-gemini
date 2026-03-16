spec/PRD.md와 spec/SPEC.md를 읽고, README.md를 Telegram 전용 배포 가이드로 재작성하라.

## 작업 순서

### 1단계: 명세 읽기
- spec/PRD.md: 프로젝트 개요, 목표, 기술 스택, 배포 흐름 확인
- spec/SPEC.md: 파일별 명세, workspace bootstrap 시스템 확인

### 2단계: 현재 README.md 읽기
기존 내용을 파악하여 유지할 섹션과 제거할 섹션을 구분한다.

### 3단계: README.md 재작성

아래 구조로 작성한다.

---

**포함할 섹션 (순서대로)**

1. **제목 및 한 줄 소개**
   - Telegram 봇 `@openclaw_claude_da_bot` + Claude AI 게이트웨이임을 명시

2. **전체 흐름**
   - mermaid 플로우차트: Telegram 전용 흐름만 표현 (WebUI 노드 금지)

3. **gcube 워크로드 설정**
   - 이미지: `coollabsio/openclaw:latest`
   - 포트: `8080`
   - 초기명령어: `bash -c "apt-get update -qq && apt-get install -y nano vim && sleep infinity"`

4. **사전 준비**
   - Anthropic API 키 발급 방법 (console.anthropic.com)
   - Telegram 봇 토큰 발급 방법 (BotFather, `/newbot`)
   - Gemini 관련 내용 포함 금지

5. **실행 방법** (5단계)
   1. `git clone` → `cd openclaw-claude`
   2. `cp .env.example .env` → `nano .env` (ANTHROPIC_API_KEY, TELEGRAM_BOT_TOKEN 입력)
   3. `bash setup.sh`
   4. `bash run.sh`
   5. Telegram 봇에 메시지 전송 → 페어링 코드 수신 → `openclaw pairing approve telegram [코드]`

6. **Knowledge Base 문서**
   - `docs/` 폴더의 .md 파일이 `~/.openclaw/workspace/`에 자동 복사됨
   - `identity/` 폴더의 bootstrap 파일도 자동 복사 (AGENTS.md, IDENTITY.md)

7. **테스트 성공 기준**
   - Telegram 봇에 메시지 전송 → Claude AI 한국어 텍스트 응답 수신
   - 문서 기반 Q&A 검증

8. **파일 구조**
   - repo 파일 목록 (identity/, docs/, spec/ 포함)
   - 런타임 생성 디렉토리 (~/.openclaw/)

9. **문제 해결**
   - gateway 실행 실패: `cat ~/.openclaw/gateway.log`
   - 프로세스 정리 및 재시작
   - Telegram 봇 미응답: 페어링 재시도

10. **주요 명령어**
    - 자주 사용하는 openclaw 명령어 모음

---

**제거할 섹션 (포함 금지)**

- Gemini API 키 발급 안내
- WebUI(Control UI) 브라우저 접속 흐름
- `openclaw devices list / approve` Device Pairing 안내 (WebUI용)
- Gateway Token 브라우저 입력 안내
- Gemini rate limit 안내

---

**작성 원칙**

- 한국어로 작성한다.
- 봇 이름은 `@openclaw_claude_da_bot` 으로 고정한다.
- 코드 블록을 활용하여 명령어를 명확히 표시한다.
- 불필요한 내용 없이 간결하게 작성한다.
- mermaid 플로우차트를 포함할 경우 Telegram 전용 흐름만 표현한다 (WebUI 노드 금지).

### 4단계: 완료 확인

작성 후 README.md에서 아래 문자열이 없는지 확인한다.
- `GEMINI_API_KEY`
- `aistudio.google.com`
- `Gateway Token 필드`
- `gcube URL로 접속`
- `openclaw devices`
- `Control UI`

존재하면 즉시 해당 부분을 수정한다.
