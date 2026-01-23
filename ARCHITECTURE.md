# 주말근무 관리 시스템 아키텍처

## 전체 구조

이 프로젝트는 **JSP 브릿지 + Servlet 직접 처리** 방식의 SPA(Single Page Application)입니다.

```
┌─────────────────────────────────────────────────────────────┐
│                         Browser (SPA)                        │
│                    main.html (Hash Routing)                  │
└─────────────────────────────────────────────────────────────┘
                              ↓
                    fetch('/api/weekend-work.jsp')
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                      JSP Bridge Layer                        │
│                   weekend-work.jsp                           │
│         (RequestDispatcher.forward("/weekend-work"))         │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                    Servlet Layer (직접 처리)                  │
│                  WeekendWorkServlet.java                     │
│              - 페이징 로직                                     │
│              - 직접 JDBC 연결                                  │
│              - JSON 응답 생성                                  │
└─────────────────────────────────────────────────────────────┘
                              ↓
                    DBConnection.getConnection()
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                      Database Layer                          │
│                  MySQL (tbl_weekend_work)                    │
└─────────────────────────────────────────────────────────────┘
```

## 계층별 역할

### 1. Frontend (Browser)
- **파일**: `main.html`
- **역할**:
  - SPA 형태의 클라이언트 사이드 라우팅 (Hash Routing)
  - 주말근무 그리드 렌더링
  - 페이징 UI 처리
  - AJAX 통신 (fetch API)

### 2. JSP Bridge Layer
- **파일**: `api/weekend-work.jsp`
- **역할**:
  - 단순 브릿지 역할만 수행
  - RequestDispatcher로 Servlet에 요청 전달
  - 직접적인 비즈니스 로직 없음

```jsp
<%
    request.getRequestDispatcher("/weekend-work").forward(request, response);
%>
```

### 3. Servlet Layer
- **파일**: `servlet/WeekendWorkServlet.java`
- **역할**:
  - 모든 비즈니스 로직 처리
  - 직접 JDBC를 통한 DB 연결
  - 페이징 처리
  - JSON 응답 생성 (Gson 사용)
  - 에러 핸들링

**주요 메서드**:
- `doGet()`: HTTP GET 요청 처리
- `getTotalCount()`: 전체 레코드 수 조회
- `getWeekendWorkList()`: 페이징된 데이터 조회

### 4. Database Utility
- **파일**: `util/DBConnection.java`
- **역할**:
  - MySQL 연결 관리
  - Connection Pool 역할

### 5. Database
- **테이블**: `tbl_weekend_work`
- **레코드**: 25건의 더미 데이터

## 데이터 흐름

### 조회 요청 흐름

```
1. 사용자가 로그인 → main.html 로드
   ↓
2. loadWeekendWorkData() 함수 실행
   ↓
3. fetch('api/weekend-work.jsp?page=1&size=10')
   ↓
4. JSP가 요청을 받아 Servlet으로 forward
   ↓
5. WeekendWorkServlet.doGet() 실행
   ↓
6. 파라미터 검증 (page, size)
   ↓
7. DBConnection.getConnection()으로 DB 연결
   ↓
8. SQL 실행 (SELECT with LIMIT/OFFSET)
   ↓
9. ResultSet → Map<String, Object> 변환
   ↓
10. Gson으로 JSON 변환
   ↓
11. HTTP Response로 JSON 반환
   ↓
12. 브라우저에서 JSON 파싱
   ↓
13. renderWeekendWorkGrid() 함수로 그리드 렌더링
```

## 왜 이 구조를 선택했는가?

### DAO/Model 계층을 제거한 이유
1. **단순성**: 작은 프로젝트에서 과도한 계층화 방지
2. **직접성**: Servlet에서 직접 DB 처리로 명확한 흐름
3. **SPA 특성**: 클라이언트 중심 아키텍처에 적합

### JSP를 브릿지로 사용하는 이유
1. **URL 일관성**: `/api/*.jsp` 형태의 일관된 엔드포인트
2. **유연성**: 필요시 JSP에서 전처리 가능
3. **호환성**: 기존 JSP 기반 프로젝트와의 통합 용이

### Servlet에서 직접 DB 처리하는 이유
1. **성능**: 불필요한 계층 제거로 오버헤드 감소
2. **명확성**: 한 곳에서 모든 로직 확인 가능
3. **유지보수**: 작은 프로젝트에서 관리 포인트 최소화

## 확장 가능성

### 향후 기능 추가 시
1. **검색/필터링**: Servlet의 SQL 쿼리만 수정
2. **등록/수정/삭제**: doPost(), doPut(), doDelete() 메서드 추가
3. **권한 관리**: Servlet에서 세션 체크 로직 추가
4. **파일 업로드**: MultipartConfig 추가

### 계층 분리가 필요한 경우
프로젝트가 커지면 다음과 같이 리팩토링 가능:
```
Servlet → Service → DAO → Database
```

## 보안 고려사항

1. **SQL Injection 방지**: PreparedStatement 사용
2. **XSS 방지**: JSON 응답으로 HTML 직접 출력 없음
3. **세션 관리**: 로그인 체크 필터 적용
4. **인코딩**: UTF-8 일관성 유지

## 성능 최적화

1. **페이징**: LIMIT/OFFSET으로 필요한 데이터만 조회
2. **Connection 관리**: try-with-resources로 자동 close
3. **JSON 직렬화**: Gson 라이브러리 사용
4. **클라이언트 캐싱**: SPA로 페이지 리로드 최소화

## 파일 구조 요약

```
spaWeb/
├── src/main/
│   ├── java/com/example/
│   │   ├── util/
│   │   │   └── DBConnection.java          # DB 연결 유틸
│   │   ├── servlet/
│   │   │   ├── LoginServlet.java          # 로그인 처리
│   │   │   ├── LogoutServlet.java         # 로그아웃 처리
│   │   │   └── WeekendWorkServlet.java    # 주말근무 API
│   │   └── filter/
│   │       └── SessionCheckFilter.java    # 세션 체크
│   ├── resources/
│   │   └── schema.sql                     # DB 스키마
│   └── webapp/
│       ├── api/
│       │   └── weekend-work.jsp           # JSP 브릿지
│       ├── login.html                     # 로그인 페이지
│       └── main.html                      # 메인 페이지 (SPA)
├── DATABASE_SETUP.md                      # DB 설정 가이드
├── WEEKEND_WORK_README.md                 # 사용 가이드
└── ARCHITECTURE.md                        # 이 문서
```

## 결론

이 아키텍처는 **단순성과 효율성**을 추구하는 SPA 프로젝트에 적합합니다.
- JSP는 브릿지 역할만
- Servlet이 모든 비즈니스 로직 처리
- 클라이언트는 SPA로 동적 렌더링

필요에 따라 계층을 추가하거나 마이크로서비스로 분리할 수 있는 유연한 구조입니다.
