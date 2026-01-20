# 빠른 시작 가이드

## 1단계: 필수 라이브러리 다운로드

### Jakarta Servlet API 다운로드 (필수)
1. 브라우저에서 다음 링크 열기:
   ```
   https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar
   ```
2. 다운로드한 파일을 `lib` 폴더에 저장

### Gson 다운로드 (선택사항)
1. 브라우저에서 다음 링크 열기:
   ```
   https://repo1.maven.org/maven2/com/google/code/gson/gson/2.10.1/gson-2.10.1.jar
   ```
2. 다운로드한 파일을 `lib` 폴더에 저장

## 2단계: IntelliJ IDEA 설정

### 방법 1: 자동 인식 (권장)
1. IntelliJ IDEA에서 프로젝트 열기
2. 프로젝트가 자동으로 `.iml` 파일을 읽어 라이브러리 인식
3. 만약 인식되지 않으면 **File > Invalidate Caches / Restart** 실행

### 방법 2: 수동 추가
1. **File > Project Structure** (Ctrl+Alt+Shift+S)
2. **Modules > Dependencies** 탭 선택
3. **+ 버튼 > JARs or directories** 클릭
4. `lib/jakarta.servlet-api-6.0.0.jar` 선택
5. **Scope**를 **Provided**로 변경
6. 다시 **+ 버튼 > JARs or directories** 클릭
7. `lib/gson-2.10.1.jar` 선택 (Scope는 Compile 유지)
8. **Apply > OK**

## 3단계: Tomcat 설정

### Tomcat 다운로드 및 설치
1. [Apache Tomcat 10](https://tomcat.apache.org/download-10.cgi) 다운로드
2. 압축 해제 (예: `C:/apache-tomcat-10.1.x`)

### IntelliJ에서 Tomcat 설정
1. **Run > Edit Configurations**
2. **+ > Tomcat Server > Local**
3. **Configure** 버튼 클릭하여 Tomcat 설치 경로 지정
4. **Deployment** 탭으로 이동
5. **+ > Artifact > spaWeb:war exploded** 선택
6. **Application context** 입력: `/spaWeb`
7. **Apply > OK**

## 4단계: 프로젝트 실행

1. **Run** 버튼 클릭 (Shift+F10)
2. Tomcat이 시작되고 브라우저가 자동으로 열림
3. 또는 수동으로 접속: `http://localhost:8080/spaWeb/`

## 5단계: 로그인

- **아이디**: `admin`
- **비밀번호**: `admin123`

## 프로젝트 구조 확인

```
spaWeb/
├── lib/                                    # JAR 파일 위치
│   ├── jakarta.servlet-api-6.0.0.jar      # 다운로드 필요
│   ├── gson-2.10.1.jar                    # 다운로드 필요 (선택)
│   └── README.txt
├── src/
│   └── main/
│       ├── java/
│       │   └── com/example/
│       │       ├── servlet/
│       │       │   ├── LoginServlet.java
│       │       │   └── LogoutServlet.java
│       │       └── filter/
│       │           └── SessionCheckFilter.java
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml
│           ├── index.html
│           ├── login.html
│           └── main.html
└── spaWeb.iml
```

## 문제 해결

### 컴파일 에러: "Cannot resolve symbol 'jakarta'"
- `lib` 폴더에 `jakarta.servlet-api-6.0.0.jar` 파일이 있는지 확인
- IntelliJ에서 **File > Invalidate Caches / Restart** 실행
- **File > Project Structure > Modules > Dependencies**에서 라이브러리가 추가되었는지 확인

### 404 에러
- Tomcat이 정상 실행되었는지 확인
- URL이 `http://localhost:8080/spaWeb/`인지 확인 (마지막 슬래시 포함)
- **Run > Edit Configurations > Deployment**에서 Application context가 `/spaWeb`인지 확인

### 로그인 후 바로 로그인 페이지로 돌아감
- 브라우저 쿠키가 활성화되어 있는지 확인
- 개발자 도구(F12) > Application > Cookies에서 JSESSIONID 쿠키 확인

### 필터가 동작하지 않음
- `@WebFilter` 어노테이션이 있는지 확인
- Tomcat 10 이상을 사용하는지 확인 (Jakarta EE 9+ 필요)

## 다음 단계

- **SERVLET_README.md**: 상세한 기술 문서
- **README.md**: 프로젝트 개요 및 기능 설명

## 개발 팁

### 코드 수정 후 재배포
1. **Build > Build Project** (Ctrl+F9)
2. Tomcat이 자동으로 재배포 (Hot Swap)
3. 브라우저 새로고침

### 디버깅
1. 중단점 설정 (코드 라인 번호 옆 클릭)
2. **Debug** 버튼 클릭 (Shift+F9)
3. 브라우저에서 동작 수행
4. IntelliJ에서 변수 값 확인

### 로그 확인
- IntelliJ 하단의 **Run** 탭에서 Tomcat 로그 확인
- `System.out.println()` 출력 확인
- 필터 초기화 메시지: "SessionCheckFilter initialized"

## 추가 리소스

- [Jakarta Servlet Specification](https://jakarta.ee/specifications/servlet/)
- [Apache Tomcat Documentation](https://tomcat.apache.org/tomcat-10.1-doc/)
- [IntelliJ IDEA Web Development](https://www.jetbrains.com/help/idea/developing-a-java-ee-application.html)
