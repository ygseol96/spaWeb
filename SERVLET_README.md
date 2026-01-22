# SPA 웹 애플리케이션 - Java 21 서블릿 기반

## 프로젝트 개요

Java 21 기반의 서블릿과 필터를 사용하여 세션 체크 및 인증을 처리하는 SPA(Single Page Application) 웹 애플리케이션입니다.

## 프로젝트 구조

```
spaWeb/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── example/
│       │           ├── servlet/
│       │           │   ├── LoginServlet.java      # 로그인 처리
│       │           │   └── LogoutServlet.java     # 로그아웃 처리
│       │           └── filter/
│       │               └── SessionCheckFilter.java # 세션 체크 필터
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml                        # 웹 애플리케이션 설정
│           ├── index.html                         # 진입점
│           ├── login.html                         # 로그인 페이지
│           └── main.html                          # 메인 SPA 페이지
└── README.md
```

## 주요 컴포넌트

### 1. LoginServlet (`/login`)

- **역할**: 사용자 인증 처리
- **메서드**: POST
- **기능**:
    - 사용자 아이디/비밀번호 검증
    - 세션 생성 및 사용자 정보 저장
    - JSON 응답 반환

**요청 예시**:

```javascript
fetch('login', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: new URLSearchParams({
        'username': 'admin',
        'password': 'admin123'
    })
})
```

**응답 예시**:

```json
{
    "success": true,
    "message": "로그인 성공",
    "username": "admin"
}
```

### 2. LogoutServlet (`/logout`)

- **역할**: 로그아웃 처리
- **메서드**: GET, POST
- **기능**:
    - 세션 무효화
    - 로그인 페이지로 리다이렉트 또는 JSON 응답

### 3. SessionCheckFilter

- **역할**: 모든 요청에 대한 세션 검증
- **적용 범위**: `/*` (모든 URL)
- **제외 URL**:
    - `/login.html` - 로그인 페이지
    - `/login` - 로그인 서블릿
    - `/index.html` - 진입점
    - `/logout` - 로그아웃 서블릿
    - 정적 리소스 (`.css`, `.js`, `.jpg`, `.png` 등)

**동작 방식**:

1. 요청 URL이 제외 목록에 있는지 확인
2. 세션 존재 여부 확인
3. 세션이 없으면:
    - AJAX 요청: JSON 응답 (401 Unauthorized)
    - 일반 요청: `login.html`로 리다이렉트
4. 세션이 있으면: 요청 계속 진행

## 세션 관리

### 세션 속성

- `isLoggedIn` (Boolean): 로그인 상태
- `username` (String): 사용자 아이디
- `loginTime` (Long): 로그인 시간 (밀리초)

### 세션 타임아웃

- **기본값**: 30분
- **설정 위치**: `web.xml`

```xml
<session-config>
    <session-timeout>30</session-timeout>
</session-config>
```

## 기술 스택

- **Java**: 21
- **Jakarta Servlet API**: 6.0.0
- **빌드 도구**: Maven
- **웹 서버**: Tomcat 10+ (Jakarta EE 9+)

## 의존성 (수동 설정)

이 프로젝트는 Maven/Gradle을 사용하지 않고 `lib` 폴더에 직접 JAR 파일을 추가하는 방식을 사용합니다.

### 필요한 JAR 파일

#### 1. Jakarta Servlet API (필수)

- **파일명**: `jakarta.servlet-api-6.0.0.jar`
- **다운로드
  **: [Maven Central](https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar)
- **위치**: `lib/jakarta.servlet-api-6.0.0.jar`

#### 2. Gson (선택사항 - JSON 처리용)

- **파일명**: `gson-2.10.1.jar`
- **다운로드**: [Maven Central](https://repo1.maven.org/maven2/com/google/code/gson/gson/2.10.1/gson-2.10.1.jar)
- **위치**: `lib/gson-2.10.1.jar`

### IntelliJ IDEA에서 라이브러리 추가 방법

1. **File > Project Structure** (Ctrl+Alt+Shift+S)
2. **Modules > Dependencies** 탭 선택
3. **+ 버튼 > JARs or directories** 클릭
4. `lib` 폴더의 JAR 파일들 선택
5. **Scope**를 **Provided**로 설정 (jakarta.servlet-api의 경우)
6. **Apply > OK**

또는 `.iml` 파일에 직접 추가:

```xml
<orderEntry type="module-library" scope="PROVIDED">
  <library>
    <CLASSES>
      <root url="jar://$MODULE_DIR$/lib/jakarta.servlet-api-6.0.0.jar!/" />
    </CLASSES>
  </library>
</orderEntry>
```

## 빌드 및 배포

### WAR 파일 생성 (수동)

1. **컴파일**:

```bash
# src/main/java 디렉토리에서
javac -cp "lib/*" -d WEB-INF/classes com/example/servlet/*.java com/example/filter/*.java
```

2. **WAR 파일 생성**:

```bash
# src/main/webapp 디렉토리에서
jar -cvf spaWeb.war *
```

또는 IntelliJ IDEA의 **Build > Build Artifacts** 사용

### Tomcat 배포

1. Tomcat 10 이상 설치
2. WAR 파일을 `TOMCAT_HOME/webapps/` 디렉토리에 복사
3. Tomcat 시작

```bash
# Windows
TOMCAT_HOME\bin\startup.bat

# Linux/Mac
TOMCAT_HOME/bin/startup.sh
```

4. 브라우저에서 접속

```
http://localhost:8080/spaWeb/
```

### IntelliJ IDEA에서 실행

1. **Run > Edit Configurations**
2. **+ > Tomcat Server > Local**
3. **Deployment 탭**:
    - **+ > Artifact > spaWeb:war exploded**
    - Application context: `/spaWeb`
4. **Run** 버튼 클릭

## 로그인 정보

- **아이디**: `admin`
- **비밀번호**: `admin123`

## 주요 기능

### 1. 자동 세션 체크

- 필터가 모든 요청을 가로채서 세션 확인
- 로그인하지 않은 사용자는 자동으로 `login.html`로 리다이렉트

### 2. 해시 라우팅 (SPA)

- 4개의 GNB 메뉴: 홈, 대시보드, 데이터 관리, 설정
- URL 해시 변경으로 페이지 전환
- 브라우저 뒤로가기/앞으로가기 지원

### 3. 서버 사이드 세션

- `sessionStorage` 대신 서버 세션 사용
- 보안성 향상
- 브라우저를 닫아도 세션 유지 (타임아웃 전까지)

## 보안 고려사항

### 현재 구현 (데모용)

- 하드코딩된 사용자 인증
- 평문 비밀번호 비교

### 프로덕션 환경 권장사항

1. **데이터베이스 연동**
    - 사용자 정보를 DB에 저장
    - PreparedStatement 사용 (SQL Injection 방지)

2. **비밀번호 해싱**
    - BCrypt, PBKDF2 등 사용
    - 솔트(Salt) 추가

3. **HTTPS 사용**
    - SSL/TLS 인증서 적용
    - 세션 쿠키 Secure 플래그 활성화

4. **CSRF 방지**
    - CSRF 토큰 구현
    - SameSite 쿠키 속성 설정

5. **입력값 검증**
    - XSS 방지
    - 입력값 길이 제한

## 커스터마이징

### 세션 타임아웃 변경

`web.xml` 수정:

```xml
<session-config>
    <session-timeout>60</session-timeout> <!-- 60분 -->
</session-config>
```

### 제외 URL 추가

`SessionCheckFilter.java` 수정:

```java
private static final List<String> EXCLUDE_URLS = Arrays.asList(
    "/login.html",
    "/login",
    "/index.html",
    "/logout",
    "/public"  // 추가
);
```

### 데이터베이스 연동 예시

```java
private boolean authenticate(String username, String password) {
    try (Connection conn = dataSource.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(
             "SELECT password FROM users WHERE username = ?")) {

        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            String hashedPassword = rs.getString("password");
            return BCrypt.checkpw(password, hashedPassword);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
```

## 트러블슈팅

### 1. 404 에러 발생

- Tomcat이 정상 실행되었는지 확인
- WAR 파일이 제대로 배포되었는지 확인
- URL 경로 확인 (`/spaWeb/` 포함)

### 2. 세션이 유지되지 않음

- 쿠키가 활성화되어 있는지 확인
- 브라우저 개발자 도구에서 JSESSIONID 쿠키 확인
- 세션 타임아웃 설정 확인

### 3. 필터가 동작하지 않음

- `@WebFilter` 어노테이션 확인
- 서블릿 컨테이너가 어노테이션을 스캔하는지 확인
- `web.xml`에서 `metadata-complete="false"` 설정

### 4. Jakarta vs Javax

- Java EE 8 이하: `javax.servlet.*`
- Jakarta EE 9 이상: `jakarta.servlet.*`
- Tomcat 10+는 Jakarta EE 9+ 사용

## 참고 자료

- [Jakarta Servlet Specification](https://jakarta.ee/specifications/servlet/)
- [Apache Tomcat Documentation](https://tomcat.apache.org/tomcat-10.1-doc/)
- [eGovFrame 표준프레임워크](https://www.egovframe.go.kr/)

## 라이선스

MIT License
