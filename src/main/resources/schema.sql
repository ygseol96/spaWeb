-- 일용직 주말 근태관리 시스템 회원 더미 데이터 삽입
INSERT INTO `tbl_weekend_member` (
    `user_id`,
    `user_password`,
    `user_name`,
    `user_tel`,
    `user_level`,
    `writer`,
    `created_at`
) VALUES
-- 1~5번
('user_001', '123', '김철수', '010-1234-0001', 'A', 'admin', UNIX_TIMESTAMP(NOW())),
('user_002', '123', '이영희', '010-1234-0002', 'B', 'admin', UNIX_TIMESTAMP(NOW())),
('user_003', '123', '박민수', '010-1234-0003', 'A', 'admin', UNIX_TIMESTAMP(NOW())),
('user_004', '123', '정수진', '010-1234-0004', 'B', 'admin', UNIX_TIMESTAMP(NOW())),
('user_005', '123', '최동욱', '010-1234-0005', 'A', 'admin', UNIX_TIMESTAMP(NOW())),

-- 6~10번
('user_006', '123', '강민지', '010-1234-0006', 'B', 'admin', UNIX_TIMESTAMP(NOW())),
('user_007', '123', '윤서준', '010-1234-0007', 'A', 'admin', UNIX_TIMESTAMP(NOW())),
('user_008', '123', '한지민', '010-1234-0008', 'B', 'admin', UNIX_TIMESTAMP(NOW())),
('user_009', '123', '오태양', '010-1234-0009', 'A', 'admin', UNIX_TIMESTAMP(NOW())),
('user_010', '123', '신하늘', '010-1234-0010', 'B', 'admin', UNIX_TIMESTAMP(NOW())),

-- 11~15번
('user_011', '123', '배준호', '010-1234-0011', 'A', 'admin', UNIX_TIMESTAMP(NOW())),
('user_012', '123', '임소라', '010-1234-0012', 'B', 'admin', UNIX_TIMESTAMP(NOW())),
('user_013', '123', '조현우', '010-1234-0013', 'A', 'admin', UNIX_TIMESTAMP(NOW())),
('user_014', '123', '송미래', '010-1234-0014', 'B', 'admin', UNIX_TIMESTAMP(NOW())),
('user_015', '123', '홍길동', '010-1234-0015', 'A', 'admin', UNIX_TIMESTAMP(NOW())),

-- 16~20번
('user_016', '123', '김나라', '010-1234-0016', 'B', 'admin', UNIX_TIMESTAMP(NOW())),
('user_017', '123', '이세계', '010-1234-0017', 'A', 'admin', UNIX_TIMESTAMP(NOW())),
('user_018', '123', '박하늘', '010-1234-0018', 'B', 'admin', UNIX_TIMESTAMP(NOW())),
('user_019', '123', '정바다', '010-1234-0019', 'A', 'admin', UNIX_TIMESTAMP(NOW())),
('user_020', '123', '최별', '010-1234-0020', 'B', 'admin', UNIX_TIMESTAMP(NOW())),

-- 21~25번
('user_021', '123', '강산', '010-1234-0021', 'A', 'admin', UNIX_TIMESTAMP(NOW())),
('user_022', '123', '윤달', '010-1234-0022', 'B', 'admin', UNIX_TIMESTAMP(NOW())),
('user_023', '123', '한별', '010-1234-0023', 'A', 'admin', UNIX_TIMESTAMP(NOW())),
('user_024', '123', '오늘', '010-1234-0024', 'B', 'admin', UNIX_TIMESTAMP(NOW())),
('user_025', '123', '신세계', '010-1234-0025', 'A', 'admin', UNIX_TIMESTAMP(NOW()));

INSERT INTO `tbl_weekend_work` (
    `user_id`,
    `user_name`,
    `user_tel`,
    `user_level`,
    `user_dept`,
    `start_at`,
    `end_at`,
    `etc_comment`,
    `week_flag`,
    `confirm_yn`,
    `writer`,
    `created_at`
) VALUES

-- 일용직 주말 근태관리 시스템 근태 현황 더미 데이터 삽입
('user_001', '김철수', '010-1234-0001', 'A', 'D', UNIX_TIMESTAMP('2024-01-06 09:00:00'), UNIX_TIMESTAMP('2024-01-06 18:00:00'), '긴급 시스템 점검', '0', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 2. 이영희 (기획팀, 2024-01-07 일)
('user_002', '이영희', '010-1234-0002', 'B', 'P', UNIX_TIMESTAMP('2024-01-07 10:00:00'), UNIX_TIMESTAMP('2024-01-07 15:00:00'), '프로젝트 마감', '1', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 3. 박민수 (개발팀, 2024-01-13 토)
('user_003', '박민수', '010-1234-0003', 'A', 'D', UNIX_TIMESTAMP('2024-01-13 09:00:00'), UNIX_TIMESTAMP('2024-01-13 17:00:00'), '서버 업그레이드', '0', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 4. 정수진 (디자인팀, 2024-01-14 일)
('user_004', '정수진', '010-1234-0004', 'B', 'S', UNIX_TIMESTAMP('2024-01-14 13:00:00'), UNIX_TIMESTAMP('2024-01-14 18:00:00'), 'UI 개선 작업', '1', 'N', 'admin', UNIX_TIMESTAMP(NOW())),

-- 5. 최동욱 (개발팀, 2024-01-20 토)
('user_005', '최동욱', '010-1234-0005', 'A', 'D', UNIX_TIMESTAMP('2024-01-20 09:00:00'), UNIX_TIMESTAMP('2024-01-20 18:00:00'), '데이터베이스 마이그레이션', '0', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 6. 강민지 (마케팅팀, 2024-01-21 일)
('user_006', '강민지', '010-1234-0006', 'B', 'M', UNIX_TIMESTAMP('2024-01-21 10:00:00'), UNIX_TIMESTAMP('2024-01-21 16:00:00'), '캠페인 준비', '1', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 7. 윤서준 (개발팀, 2024-01-27 토)
('user_007', '윤서준', '010-1234-0007', 'A', 'D', UNIX_TIMESTAMP('2024-01-27 09:00:00'), UNIX_TIMESTAMP('2024-01-27 19:00:00'), '보안 패치 적용', '0', 'N', 'admin', UNIX_TIMESTAMP(NOW())),

-- 8. 한지민 (QA팀, 2024-01-28 일)
('user_008', '한지민', '010-1234-0008', 'B', 'Q', UNIX_TIMESTAMP('2024-01-28 11:00:00'), UNIX_TIMESTAMP('2024-01-28 17:00:00'), '테스트 진행', '1', 'N', 'admin', UNIX_TIMESTAMP(NOW())),

-- 9. 오태양 (개발팀, 2024-02-03 토)
('user_009', '오태양', '010-1234-0009', 'A', 'D', UNIX_TIMESTAMP('2024-02-03 09:00:00'), UNIX_TIMESTAMP('2024-02-03 18:00:00'), '신규 기능 개발', '0', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 10. 신하늘 (기획팀, 2024-02-04 일)
('user_010', '신하늘', '010-1234-0010', 'B', 'P', UNIX_TIMESTAMP('2024-02-04 10:00:00'), UNIX_TIMESTAMP('2024-02-04 15:00:00'), '요구사항 분석', '1', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 11. 배준호 (개발팀, 2024-02-10 토)
('user_011', '배준호', '010-1234-0011', 'A', 'D', UNIX_TIMESTAMP('2024-02-10 09:00:00'), UNIX_TIMESTAMP('2024-02-10 20:00:00'), '긴급 버그 수정', '0', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 12. 임소라 (디자인팀, 2024-02-11 일)
('user_012', '임소라', '010-1234-0012', 'B', 'S', UNIX_TIMESTAMP('2024-02-11 13:00:00'), UNIX_TIMESTAMP('2024-02-11 19:00:00'), '디자인 시안 작업', '1', 'N', 'admin', UNIX_TIMESTAMP(NOW())),

-- 13. 조현우 (개발팀, 2024-02-17 토)
('user_013', '조현우', '010-1234-0013', 'A', 'D', UNIX_TIMESTAMP('2024-02-17 09:00:00'), UNIX_TIMESTAMP('2024-02-17 18:00:00'), 'API 개발', '0', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 14. 송미래 (마케팅팀, 2024-02-18 일)
('user_014', '송미래', '010-1234-0014', 'B', 'M', UNIX_TIMESTAMP('2024-02-18 10:00:00'), UNIX_TIMESTAMP('2024-02-18 16:00:00'), '이벤트 기획', '1', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 15. 홍길동 (개발팀, 2024-02-24 토)
('user_015', '홍길동', '010-1234-0015', 'A', 'D', UNIX_TIMESTAMP('2024-02-24 09:00:00'), UNIX_TIMESTAMP('2024-02-24 17:00:00'), '성능 최적화', '0', 'N', 'admin', UNIX_TIMESTAMP(NOW())),

-- 16. 김나라 (QA팀, 2024-02-25 일)
('user_016', '김나라', '010-1234-0016', 'B', 'Q', UNIX_TIMESTAMP('2024-02-25 11:00:00'), UNIX_TIMESTAMP('2024-02-25 18:00:00'), '통합 테스트', '1', 'N', 'admin', UNIX_TIMESTAMP(NOW())),

-- 17. 이세계 (개발팀, 2024-03-02 토)
('user_017', '이세계', '010-1234-0017', 'A', 'D', UNIX_TIMESTAMP('2024-03-02 09:00:00'), UNIX_TIMESTAMP('2024-03-02 18:00:00'), '코드 리팩토링', '0', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 18. 박하늘 (기획팀, 2024-03-03 일)
('user_018', '박하늘', '010-1234-0018', 'B', 'P', UNIX_TIMESTAMP('2024-03-03 10:00:00'), UNIX_TIMESTAMP('2024-03-03 15:00:00'), '문서 작성', '1', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 19. 정바다 (개발팀, 2024-03-09 토)
('user_019', '정바다', '010-1234-0019', 'A', 'D', UNIX_TIMESTAMP('2024-03-09 09:00:00'), UNIX_TIMESTAMP('2024-03-09 19:00:00'), '배포 작업', '0', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 20. 최별 (디자인팀, 2024-03-10 일)
('user_020', '최별', '010-1234-0020', 'B', 'S', UNIX_TIMESTAMP('2024-03-10 13:00:00'), UNIX_TIMESTAMP('2024-03-10 18:00:00'), '아이콘 제작', '1', 'N', 'admin', UNIX_TIMESTAMP(NOW())),

-- 21. 강산 (개발팀, 2024-03-16 토)
('user_021', '강산', '010-1234-0021', 'A', 'D', UNIX_TIMESTAMP('2024-03-16 09:00:00'), UNIX_TIMESTAMP('2024-03-16 18:00:00'), '모니터링 시스템 구축', '0', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 22. 윤달 (마케팅팀, 2024-03-17 일)
('user_022', '윤달', '010-1234-0022', 'B', 'M', UNIX_TIMESTAMP('2024-03-17 10:00:00'), UNIX_TIMESTAMP('2024-03-17 16:00:00'), 'SNS 콘텐츠 제작', '1', 'Y', 'admin', UNIX_TIMESTAMP(NOW())),

-- 23. 한별 (개발팀, 2024-03-23 토)
('user_023', '한별', '010-1234-0023', 'A', 'D', UNIX_TIMESTAMP('2024-03-23 09:00:00'), UNIX_TIMESTAMP('2024-03-23 20:00:00'), '긴급 장애 대응', '0', 'N', 'admin', UNIX_TIMESTAMP(NOW())),

-- 24. 오늘 (QA팀, 2024-03-24 일)
('user_024', '오늘', '010-1234-0024', 'B', 'Q', UNIX_TIMESTAMP('2024-03-24 11:00:00'), UNIX_TIMESTAMP('2024-03-24 17:00:00'), '회귀 테스트', '1', 'N', 'admin', UNIX_TIMESTAMP(NOW())),

-- 25. 신세계 (개발팀, 2024-03-30 토)
('user_025', '신세계', '010-1234-0025', 'A', 'D', UNIX_TIMESTAMP('2024-03-30 09:00:00'), UNIX_TIMESTAMP('2024-03-30 18:00:00'), '신규 프로젝트 셋업', '0', 'Y', 'admin', UNIX_TIMESTAMP(NOW()));