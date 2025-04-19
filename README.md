# 🐧 x64 Ubuntu Pwnable Docker Environment

시스템 해킹(pwnable) 실습을 위한 x86_64(amd64) Ubuntu 환경 Dockerfile을 제공하고 있습니다.
Windows, Intel Mac, Apple Silicon (M1/M2)에서도 동일한 x64 환경을 사용할 수 있습니다.

---

## 🛠️ 포함된 환경 및 도구

| 구성 요소          | 설명 |
|-------------------|------|
| Ubuntu 18.04 (x86_64) | 실습용 OS 환경 |
| Ruby 3.1.4         | one_gadget 실행용 (소스 빌드) |
| pwndbg             | GDB 확장 (2023.03.19) |
| pwntools           | Python 기반 익스플로잇 라이브러리 |
| one_gadget         | libc 기준 RCE 가젯 검색기 |
| gcc, gdb, make 등  | C언어 실습 도구 일체 |

---

## 📦 사전 준비

### Docker Desktop 설치
- [Windows용 Docker 설치](https://docs.docker.com/desktop/install/windows-install/)
- [Mac용 Docker 설치](https://docs.docker.com/desktop/install/mac-install/)

> ⚠️ **M1/M2 Mac은 반드시 Rosetta를 설치하고 `--platform=linux/amd64` 옵션을 사용해야 합니다.**

---

## 🧪 Docker 이미지 빌드

### ✅ Intel/Windows/Mac (Intel)
```bash
git clone https://github.com/your-username/pwnable-docker.git
cd pwnable-docker
docker build -t pwnable-env .

