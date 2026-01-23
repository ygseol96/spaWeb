# 주말근무 관리 시스템

## 개요

로그인 성공 시 메인 화면에 주말근무 관리 그리드가 표시되며, 페이징 기능을 포함한 데이터 조회가 가능합니다.

## 구현 내용

### 1. 데이터베이스

**테이블**: `tbl_weekend_work`
- 25건의 더미 데이터 포함
- 직원명, 부서, 근무일자, 시간, 근무유형, 승인상태 등 관리

**위치**: `src/main/resources/schema.sql`

### 2. 백엔드 (Java Servlet)

#### 파일 구조
```
src/main/java/com/example/
├── util/
│   └── DBConnection.java          # 데이터베이스 연결 유틸리티
└── servlet/
    └── WeekendWorkServlet.java    # 주말근무 서블릿 (직접 DB 처리)

src/main/webapp/api/
└── weekend-work.jsp               # JSP 브릿지 (Servlet으로 전달)
```

#### API 엔드포인트

**GET** `/api/weekend-work.jsp` → **Servlet** `/weekend-work`
- 주말근무 목록 조회 (페이징)
- **아키텍처**: JSP 브릿지 → Servlet (직접 DB 처리)
- 파라미터:
  - `page`: 페이지 번호 (기본값: 1)
  - `size`: 페이지당 레코드 수 (기본값: 10)
- 응답 예시:
```json
{
  "success": true,
  "data": [...],
  "pagination": {
    "currentPage": 1,
    "pageSize": 10,
    "totalCount": 25,
    "totalPages": 3
  }
}
```

**Note**:
- JSP는 브릿지 역할만 수행 (RequestDispatcher로 Servlet에 전달)
- Servlet에서 직접 DB 연결 및 비즈니스 로직 처리
- DAO/Model 계층 없이 SPA 형태로 구현

### 3. 프론트엔드 (HTML/JavaScript)

**파일**: `src/main/webapp/main.html`

#### 주요 기능
- ✅ 로그인 성공 시 메인 화면에 주말근무 그리드 표시
- ✅ 페이징 기능 (이전/다음, 페이지 번호)
- ✅ 반응형 테이블 디자인
- ✅ 승인 상태별 색상 구분 (승인/대기/반려)
- ✅ 실시간 데이터 로딩

#### 그리드 컬럼
1. 번호
2. 직원명
3. 부서
4. 근무일자
5. 시작시간
6. 종료시간
7. 근무시간
8. 근무유형
9. 근무사유
10. 상태 (배지 형태)

## 설치 및 실행

### 1. 데이터베이스 설정

```bash
# MySQL 접속
mysql -u root -p

# 데이터베이스 생성
CREATE DATABASE spa_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# 테이블 생성 및 더미 데이터 삽입
USE spa_db;
source src/main/resources/schema.sql;
```

자세한 내용은 `DATABASE_SETUP.md` 참조

### 2. 데이터베이스 연결 정보 확인

`src/main/java/com/example/util/DBConnection.java` 파일에서 연결 정보를 확인하고 필요시 수정:

```java
private static final String URL = "jdbc:mysql://localhost:3306/spa_db?useSSL=false&serverTimezone=Asia/Seoul&characterEncoding=UTF-8";
private static final String USER = "root";
private static final String PASSWORD = "root";
```

### 3. 애플리케이션 실행

1. Tomcat 서버 시작
2. 브라우저에서 `http://localhost:8080/spaWeb` 접속
3. 로그인 (admin / admin123)
4. 메인 화면에서 주말근무 관리 그리드 확인

## 사용 방법

### 로그인
- 아이디: `admin`
- 비밀번호: `admin123`

### 주말근무 데이터 조회
1. 로그인 성공 시 자동으로 메인 화면에 주말근무 그리드가 표시됩니다
2. 페이지 하단의 페이징 버튼으로 다른 페이지 조회 가능
3. 각 페이지당 10건의 데이터가 표시됩니다

### 페이징 기능
- **이전/다음 버튼**: 이전/다음 페이지로 이동
- **페이지 번호**: 특정 페이지로 직접 이동
- **페이지 정보**: 현재 페이지 및 전체 데이터 건수 표시

## 화면 구성

### 메인 화면 (로그인 후)
```
┌─────────────────────────────────────────┐
│ SPA System              사용자 [로그아웃] │
├─────────────────────────────────────────┤
│  홈  │ 대시보드 │ 데이터관리 │ 설정      │
├─────────────────────────────────────────┤
│                                         │
│  주말근무 관리                           │
│  ─────────────────────────────────────  │
│                                         │
│  전체 25건 (1 / 3 페이지)               │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │ 번호│직원명│부서│근무일자│...│상태│  │
│  ├───────────────────────────────────┤  │
│  │  1  │김철수│개발│2024-01-06│...│승인│  │
│  │  2  │이영희│기획│2024-01-07│...│승인│  │
│  │ ...                               │  │
│  └───────────────────────────────────┘  │
│                                         │
│  [이전] [1] [2] [3] [다음]              │
│                                         │
└─────────────────────────────────────────┘
```

## 기술 스택

- **Backend**: Java Servlet (직접 DB 처리), JSP (브릿지), JDBC
- **Frontend**: HTML5, CSS3, Vanilla JavaScript (SPA)
- **Database**: MySQL 8.x
- **Server**: Apache Tomcat 10.x
- **Library**: Gson (JSON 처리)

## 아키텍처

```
[Browser]
    ↓ fetch('/api/weekend-work.jsp')
[JSP Bridge] (weekend-work.jsp)
    ↓ RequestDispatcher.forward()
[Servlet] (WeekendWorkServlet.java)
    ↓ Direct JDBC
[MySQL Database] (tbl_weekend_work)
```

**특징**:
- DAO/Model 계층 없이 Servlet에서 직접 DB 처리
- JSP는 단순 브릿지 역할만 수행
- SPA 형태로 클라이언트 사이드 라우팅

## 주요 특징

1. **SPA (Single Page Application)**: 해시 라우팅을 통한 페이지 전환
2. **RESTful API**: JSON 기반 데이터 통신
3. **페이징 처리**: 서버 사이드 페이징으로 성능 최적화
4. **반응형 디자인**: 다양한 화면 크기 지원
5. **상태 관리**: 세션 기반 인증 및 상태 관리

## 향후 개선 사항

- [ ] 검색 기능 추가
- [ ] 정렬 기능 추가
- [ ] 상세 보기 모달
- [ ] 등록/수정/삭제 기능
- [ ] 엑셀 다운로드 기능
- [ ] 필터링 기능 (부서별, 상태별)

## 문제 해결

### 데이터가 표시되지 않는 경우
1. 데이터베이스 연결 확인
2. 브라우저 콘솔에서 에러 메시지 확인
3. JSP 파일 경로 확인 (`/api/weekend-work.jsp`)
4. Servlet 매핑 확인 (`@WebServlet("/weekend-work")`)
5. MySQL 서버 실행 상태 확인

### 한글이 깨지는 경우
1. 데이터베이스 문자셋 확인 (utf8mb4)
2. JSP 페이지 인코딩 설정 확인 (UTF-8)
3. HTML meta charset 확인

## 라이선스

MIT License
