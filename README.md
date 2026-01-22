# SPA 해시 라우팅 시스템

## 프로젝트 개요

이 프로젝트는 해시 라우팅을 사용하는 Single Page Application (SPA)입니다. 세션 기반 로그인 시스템과 4개의 GNB(Global Navigation Bar) 메뉴를 제공합니다.

## 파일 구조

```
spaWeb/
├── index.html      # 진입점 (세션 체크 후 리다이렉트)
├── login.html      # 로그인 페이지
├── main.html       # 메인 SPA 페이지 (해시 라우팅)
└── README.md       # 프로젝트 문서
```

## 주요 기능

### 1. 세션 기반 인증

- **로그인 체크**: 세션이 없으면 자동으로 `login.html`로 리다이렉트
- **세션 유지**: 로그인 성공 시 sessionStorage에 사용자 정보 저장
- **로그아웃**: 세션 삭제 후 로그인 페이지로 이동

### 2. 해시 라우팅 (Hash Routing)

- URL 해시를 사용한 클라이언트 사이드 라우팅
- 페이지 새로고침 없이 컨텐츠 전환
- 브라우저 뒤로가기/앞으로가기 지원

### 3. GNB (Global Navigation Bar)

4개의 메뉴 항목:

1. **홈** (`#home`) - 대시보드 통계 및 빠른 링크
2. **대시보드** (`#dashboard`) - 실시간 데이터 및 이벤트 로그
3. **데이터 관리** (`#data`) - 데이터 조회 및 관리
4. **설정** (`#settings`) - 시스템 설정 관리

## 사용 방법

### 1. 실행

브라우저에서 `index.html` 파일을 열거나 웹 서버를 통해 접근합니다.

```bash
# 간단한 HTTP 서버 실행 (Python 3)
python -m http.server 8000

# 또는 Node.js http-server 사용
npx http-server
```

브라우저에서 `http://localhost:8000` 접속

### 2. 로그인

- **아이디**: admin
- **비밀번호**: admin123

### 3. 네비게이션

- GNB 메뉴를 클릭하여 페이지 이동
- URL 해시를 직접 입력하여 접근 가능 (예: `main.html#dashboard`)
- 브라우저의 뒤로가기/앞으로가기 버튼 사용 가능

## 기술 스택

- **HTML5**: 마크업
- **CSS3**: 스타일링 (Flexbox, Grid, Gradient)
- **Vanilla JavaScript**: 로직 구현
- **SessionStorage**: 세션 관리
- **Hash Routing**: SPA 라우팅

## 주요 코드 설명

### 세션 체크 (login.html, main.html)

```javascript
// 로그인 페이지: 이미 로그인되어 있으면 main.html로
if (sessionStorage.getItem('isLoggedIn') === 'true') {
    window.location.href = 'main.html';
}

// 메인 페이지: 로그인되어 있지 않으면 login.html로
if (sessionStorage.getItem('isLoggedIn') !== 'true') {
    window.location.href = 'login.html';
}
```

### 해시 라우팅 (main.html)

```javascript
// 해시 변경 감지
window.addEventListener('hashchange', function() {
    const hash = window.location.hash.substring(1) || 'home';
    loadPage(hash);
});

// 페이지 로드 함수
function loadPage(pageName) {
    const page = pages[pageName] || pages.home;
    contentArea.innerHTML = page.content;
    // GNB 활성화 상태 업데이트
}
```

### 로그인 처리 (login.html)

```javascript
// 로그인 성공 시
sessionStorage.setItem('isLoggedIn', 'true');
sessionStorage.setItem('username', username);
window.location.href = 'main.html';
```

### 로그아웃 처리 (main.html)

```javascript
// 로그아웃 버튼 클릭 시
sessionStorage.clear();
window.location.href = 'login.html';
```

## 커스터마이징

### 새로운 페이지 추가

`main.html`의 `pages` 객체에 새로운 페이지를 추가:

```javascript
const pages = {
    // 기존 페이지들...
    newpage: {
        title: '새 페이지',
        content: `
            <div class="page-content">
                <p>새로운 페이지 내용</p>
            </div>
        `
    }
};
```

GNB에 메뉴 항목 추가:

```html
<a href="#newpage" class="gnb-item" data-page="newpage">새 메뉴</a>
```

### 로그인 인증 변경

실제 서버 API를 사용하려면 `login.html`의 로그인 처리 부분을 수정:

```javascript
// 서버 API 호출 예시
fetch('/api/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password })
})
.then(response => response.json())
.then(data => {
    if (data.success) {
        sessionStorage.setItem('isLoggedIn', 'true');
        sessionStorage.setItem('username', data.username);
        window.location.href = 'main.html';
    }
});
```

## 브라우저 호환성

- Chrome (최신)
- Firefox (최신)
- Safari (최신)
- Edge (최신)

## 라이선스

MIT License

## 참고사항

- 이 프로젝트는 데모/학습 목적으로 제작되었습니다.
- 실제 프로덕션 환경에서는 서버 사이드 인증을 사용해야 합니다.
- sessionStorage는 브라우저를 닫으면 삭제됩니다.
