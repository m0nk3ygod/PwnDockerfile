# 🐧 x64 Ubuntu Pwnable Docker Environment

시스템 해킹(pwnable) 실습을 위한 x86_64(amd64) Ubuntu 환경 Dockerfile 입니다.

Windows, Intel Mac, Apple Silicon (M1/M2)에서도 동일한 x64 환경을 사용할 수 있습니다.

---

## 🛠️ 포함된 환경 및 도구

| 구성 요소             | 설명 |
|----------------------|------|
| **Ubuntu 22.04 (x86_64)** | 최신 GLIBC 2.35 포함 실습용 OS 환경 |
| **Ruby 3.1.4**         | `one_gadget` 실행용 (패키지 설치) |
| **pwndbg (2023.03.19)** | GDB 디버거 확장 도구 |
| **pwntools**          | Python 기반 익스플로잇 작성 라이브러리 |
| **one_gadget**        | libc 기준 RCE 가젯 자동 추출 도구 |
| **unicorn (v2.0.0-rc5)** | 에뮬레이터용 CPU 바이너리 분석 도구 |
| **gcc, g++, gdb, make, cmake** | C/C++ 실습과 빌드용 기본 도구 전체 포함 |

---

## 📦 사전 준비

### Docker Desktop 설치
- [Windows용 Docker 설치](https://docs.docker.com/desktop/install/windows-install/)
- [Mac용 Docker 설치](https://docs.docker.com/desktop/install/mac-install/)

> ⚠️ **M1/M2 Mac은 반드시 Rosetta를 설치하고 `--platform=linux/amd64` 옵션을 사용해야 합니다.**

### git 설치
- git은 검색해서 다운...

---

## 🐵 Dockerfile

### Docker file clone
```bash
git clone https://github.com/m0nk3ygod/PwnDockerfile.git
cd PwnDockerfile
```

---

## 🧪 Docker 이미지 빌드

### ✅ Intel/Windows/Mac (Intel)
```bash
docker build -t pwnable-env .
```

### ✅ Mac M1/M2 (Apple Silicon) 환경
```bash
docker buildx build --platform=linux/amd64 -t pwnable-env .
```
--platform=linux/amd64 옵션은 ARM 칩셋에서도 x86_64 환경을 에뮬레이션해줍니다.

---

## 🐚 자주 쓰는 Docker 명령어 정리
### 💡 이미지 빌드
```bash
docker build -t pwnable-env .
```
### 💡 컨테이너 실행
```bash
docker run -it --name my_pwn_env --platform linux/amd64 pwnable-env
```
### 💡 현재 실행 중인 컨테이너 보기
```bash
docker ps
```
### 💡 전체 컨테이너 보기 (종료된 것도 포함)
```bash
docker ps -a
```
### 💡 컨테이너 종료
```bash
docker stop my_pwn_env
```
### 💡 종료된 컨테이너 재시작
```bash
docker start -ai my_pwn_env
```
### 💡 컨테이너 삭제
```bash
docker rm my_pwn_env
```
### 💡 이미지 삭제
```bash
docker rmi pwnable-env
```
### 💡 로컬에 저장된 이미지 목록 보기
```bash
docker images
```
### 💡 실행 중인 컨테이너 안으로 접속
```bash
docker exec -it my_pwn_env /bin/bash
```
---

## 🔁 로컬 <-> 컨테이너 파일 복사하기
### ✅ (1) 로컬 → 컨테이너
```bash
docker cp ./파일명 my_pwn_env:/root/
```
```bash
docker cp vuln my_pwn_env:/root/
```

### ✅ (2) 컨테이너 → 로컬
```bash
docker cp my_pwn_env:/root/파일명 ./로컬폴더/
```
```bash
docker cp my_pwn_env:/root/flag ./downloads/
```

---

## 🧪 Pwnable 실습 예시
### ✅ 바이너리 실행
```bash
chmod +x vuln
./vuln
```
### ✅ 디버깅 (pwndbg)
```bash
gdb ./vuln
```
### ✅ pwntools 익스플로잇 예시
```python
from pwn import *

context.arch = 'amd64'
context.os = 'linux'

io = process('./vuln')
io.sendline(b"A" * 64)
io.interactive()
```
