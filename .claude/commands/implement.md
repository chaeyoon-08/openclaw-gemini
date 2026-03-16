spec/SPEC.md를 읽고, 변경 명세대로 아래 파일들을 실제로 수정하라.

## 수정 대상 파일

1. `.env.example`
2. `setup.sh`
3. `run.sh`
4. `identity/AGENTS.md`
5. `identity/IDENTITY.md`

## 작업 순서

### 1단계: 명세 확인
spec/SPEC.md의 파일별 명세 섹션을 읽고, 각 파일의 현재 상태와 기대 상태를 파악한다.

### 2단계: 파일 수정

**`.env.example`**
- `ANTHROPIC_API_KEY`와 `TELEGRAM_BOT_TOKEN` 두 줄만 존재해야 함
- `GEMINI_API_KEY`는 어떤 형태로도 포함 금지

**`setup.sh`**
- API 키 검증: `ANTHROPIC_API_KEY` 단독 검증
- 모델: `anthropic/claude-sonnet-4-5` 하드코딩
- `openclaw.json`: `controlUi` 블록 없음, 모델 변수 치환 없음
- `auth-profiles.json`: `anthropic:default` 고정, provider 변수 없음
- workspace: `identity/*.md`와 `docs/*.md`를 `~/.openclaw/workspace/`에 복사
- Gemini 관련 변수(`GEMINI_API_KEY`, `PROVIDER`, `API_KEY`) 없음

**`run.sh`**
- 배너: `OpenClaw Telegram Agent`
- 안내 메시지: Telegram 페어링 안내만 출력
- WebUI 관련 문구(`Gateway Token`, `gcube URL로 접속`, `Control UI`) 없음

**`identity/AGENTS.md`**
- 한국어 답변 지시사항 포함
- 간결하고 전문적인 톤 지시

**`identity/IDENTITY.md`**
- DA Assistant 정체성 정의
- 사용자 호칭: 담당자님
- 톤: 사무적이고 간결하게, 이모지 없이

### 3단계: 검증
수정 완료 후 각 파일에서 아래 항목이 없는지 확인한다.

| 항목 | 파일 |
|------|------|
| `GEMINI_API_KEY` | `.env.example`, `setup.sh` |
| `google/gemini` | `setup.sh` |
| `PROVIDER` 변수 | `setup.sh` |
| `API_KEY` 변수 (ANTHROPIC_ 접두사 없는 것) | `setup.sh` |
| `controlUi` | `setup.sh` |
| `WebUI` 문자열 | `run.sh` |
| `Gateway Token 필드` | `run.sh` |
| `gcube URL로 접속` | `run.sh` |

문제가 있으면 즉시 수정한다.

## 완료 기준
- `.env.example`: `ANTHROPIC_API_KEY`, `TELEGRAM_BOT_TOKEN` 두 줄만 존재
- `setup.sh`: Gemini 분기 없음, Claude 단일 모델 고정, `controlUi` 없음, identity/docs 복사 로직 존재
- `run.sh`: WebUI 안내 없음, Telegram 페어링 안내만 출력
- `identity/AGENTS.md`: 한국어 답변 지시 포함
- `identity/IDENTITY.md`: DA Assistant 정체성 정의 포함
