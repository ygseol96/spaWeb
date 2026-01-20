필요한 JAR 파일을 이 폴더에 추가하세요.

필수 라이브러리:
==================

1. Jakarta Servlet API 6.0.0
   - 파일명: jakarta.servlet-api-6.0.0.jar
   - 다운로드: https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar
   - 용도: 서블릿 및 필터 개발에 필요

선택 라이브러리:
==================

2. Gson 2.10.1 (JSON 처리)
   - 파일명: gson-2.10.1.jar
   - 다운로드: https://repo1.maven.org/maven2/com/google/code/gson/gson/2.10.1/gson-2.10.1.jar
   - 용도: JSON 직렬화/역직렬화

IntelliJ IDEA 설정:
==================

JAR 파일을 다운로드한 후:
1. File > Project Structure (Ctrl+Alt+Shift+S)
2. Modules > Dependencies 탭
3. + 버튼 > JARs or directories
4. lib 폴더의 JAR 파일들 선택
5. jakarta.servlet-api는 Scope를 "Provided"로 설정
6. Apply > OK

주의사항:
==================
- jakarta.servlet-api는 Tomcat에서 제공하므로 WAR 파일에 포함하지 않습니다 (Provided scope)
- 다른 라이브러리는 WAR 파일의 WEB-INF/lib에 포함되어야 합니다
