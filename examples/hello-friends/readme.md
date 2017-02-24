## Hello-Friends 서버 사용법 
[Web에서 확인하기](https://github.com/sshyun33/devops/blob/master/examples/hello-friends/readme.md)

### 1. 준비하기
```bash
$docker --version # Docker 설치 확인 
$git clone https://github.com/sshyun33/devops  # 인프라 코드 다운
$cd devops/examples/hello-friends  # 디렉토리 이동
```

### 2. 서버 스택(NGINX/Tomcat/MariaDB) 조작 방법
>**서버 스택**은 여러 대의 서버로 이루어진 그룹을 지칭합니다. 
하나의 명령어로 다수의 서버를 조작할 수 있습니다.

#### - 실행하기
```bash
$docker-compose up -d --build
```
#### - 종료하기 
```bash
$docker-compose down # -v 옵션 추가시 DB 데이터도 삭제
```
#### - 상태 확인하기 
```bash
$docker-compose ps
```
#### - 로그 확인하기 
```bash
$docker-compose logs # -f 옵션 추가시 실시간으로 로그 추적
```

### 3. 단일 서버 조작 방법
>단일 서버를 조작하려면 명령어 실행 시 서버명을 추가합니다.
이 때 가능한 서버명은 **[nginx, tomcat, mariadb]** 중 하나입니다.

NGINX 예시)
#### - 실행하기
```bash
$docker-compose up -d --build nginx
```
#### - 종료하기 
```bash
$docker-compose down nginx
```
#### - 상태 확인하기 
```bash
$docker-compose ps
```
#### - 로그 확인하기 
```bash
$docker-compose logs -f nginx
```

### 4. 기타 참고사항
- **NGINX:** 
  - 접속 정보: `http://도메인`
  - html,css,js 위치: `devops/examples/hello-friends/nginx/html` (실시간 동기화)
- **Tomcat:**
  - 접속 정보: `http://도메인:8080`
  - 계정 정보: `devops/examples/hello-friends/tomcat/conf/tomcat-users.xml`에서 확인 가능 (단, 변경 시 Tomcat 재시작 필요)
- **MariaDB:**
  - 접속 정보: `docker-compose.yml->mariadb->environment`부분에서 확인 및 변경 가능 (단, 변경 시 MariaDB 재시작 필요)
  - root계정은 기본적으로 외부에서 접근 불가합니다.

### 
