--B13C3_view.sql


-- 최하단에 view 모아놓음


--==============================================================================
--[B-13 : 희망 취업처 및 연봉 조회] 

--1.희망취업처 + 희망 연봉 조회
create or replace view vwWish
as
select 
    s.name as "교육생명",
    w.city as "희망 지역",
    w.basicpay as "희망 연봉"
from tblwishjob w
    inner join tblStudent s
        on w.student_seq = s.student_seq
            inner join tblmanager m
                on m.manager_seq = s.manager_seq
       where m.manager_seq = ( select m.manager_seq from tblmanager m where m.id = 'ssangyong1' and m.password = 1024982);
       
       
--2. 상담 + 희망 취업처 및 연봉 자료 조회       
create or replace view vwWishandCounsel
as
select
    s.name as "교육생명",
    c.purpose "상담목적",
    c.target "상담사",
    c.counsel_date "신청날짜",
    w.city as "취업희망지역",
    w.basicpay "희망연봉"
    
from tblStudent s
    inner join tblwishjob w
        on s.student_seq = w.student_seq
            inner join tblsugang s
                on s.student_seq = s.sugang_seq
                    inner join tblcounsel c
                        on s.sugang_seq = c.sugang_seq
                            inner join tblmanager m
                                on m.manager_seq = c.manager_seq
        where m.manager_seq = ( select m.manager_seq from tblmanager m where m.id = 'ssangyong1' and m.password = 1024982)
                            order by "신청날짜" desc;
                            

--==============================================================================
--[B-14 : 교육생 팀 편성 조회]

-- 1. 전체 조회
create or replace view vwTeamAll
as
select
    lc.class_seq as "과정번호",
    team || '조' as "팀",
    name as "교육생명"
from tblStudent st
    inner join tblsugang sg
        on sg.student_seq = st.student_seq
            inner join tblTeam t
                on t.sugang_seq = sg.sugang_seq
                    inner join tbllclass lc
                        on lc.lclass_seq = sg.lclass_seq
                            inner join tblmanager m
                                on m.manager_seq = st.manager_seq
                   where m.manager_seq = (select m.manager_seq from tblManager m where m.id = 'ssangyong1' and m.password = 1024982)  -- 특정 매니저에게 권한 
                    order by lc.class_seq, "교육생명";

-- 2. 특정 강의에서 특정 팀 조회
create or replace view vwspecificTeam
as
select
    lc.class_seq as "과정번호",
    team || '조' as "팀",
    name as "교육생명"
from tblStudent st
    inner join tblsugang sg
        on sg.student_seq = st.student_seq
            inner join tblTeam t
                on t.sugang_seq = sg.sugang_seq
                    inner join tbllclass lc
                        on lc.lclass_seq = sg.lclass_seq
                            inner join tblmanager m
                                on m.manager_seq = st.manager_seq
        where lc.class_seq = 101 and t.team = 1 and  m.manager_seq = (select m.manager_seq from tblManager m where m.id = 'ssangyong1' and m.password = 1024982)-- 특정 강의 + 특정 팀 조회(선택) + 권한
                    order by lc.class_seq, "교육생명";

--==============================================================================
--[B-15 : 교육생 상담 조회]

-- 1. 모든 교육생의 전체 상담 조회
create or replace view vwCounselAll
as
select
    st.name as "교육생명",
    c.purpose "상담목적",
    c.target "상담사",
    c.counsel_date "신청날짜"
from tblStudent st
        inner join tblsugang s
             on s.student_seq = s.sugang_seq
                  inner join tblcounsel c
                       on s.sugang_seq = c.sugang_seq
                            inner join tblmanager m
                                on m.manager_seq = st.manager_seq
       where m.manager_seq = (select m.manager_seq from tblmanager m where m.id = 'ssangyong1' and m.password = 1024982)
                           order by "신청날짜" desc;
         select * from tblcounsel;
         
         
         
-- 2. 지정 교육생의 전체 상담 조회
create or replace view vwCounselEach
as
select
    st.name as "교육생명",
    c.purpose as "상담목적",
    c.target as "상담사",
    c.counsel_date as "신청날짜"
from tblStudent st
        inner join tblsugang sg
             on st.student_seq = sg.sugang_seq
                  inner join tblcounsel c
                       on sg.sugang_seq = c.sugang_seq
                            inner join tblmanager m
                                on m.manager_seq = st.manager_seq
        where st.name = '이정현' and m.manager_seq = (select m.manager_seq from tblmanager m where m.id = 'ssangyong1' and m.password = 1024982) -- 특정 매니저에게 권한 
                         order by "신청날짜" desc;

--==============================================================================
--[C-01 : 계정관리]

--                                생략

--==============================================================================
-- [C-02 : 강의 스케줄 조회]       
 
 
 
--[강의 스케줄 확인]-------------------------------------------------------------
 
 -- 1. 지정 교수의 강의과정 스케줄 조회 (교수 : 강의 = 1 : N)
 create or replace view vwEachTeacherLclass
 as
 select 
    distinct t.name as "교사명", --
    c.name as "과정명", --
    lc.startclassdate as "개강", --
    lc.finishclassdate as "종강", --
    cr.name "강의실",
 (select 
    count(distinct(student_seq)) 
from tblteacher t inner join tbllsubject ls on t.teacher_seq = ls.teacher_seq
                  inner join tbllclass lc on lc.lclass_seq = ls.lclass_seq
                  inner join tblsugang su on su.lclass_seq = lc.lclass_seq
    where t.teacher_seq =11) as "등록인원수",
    case
        when lc.startclassdate <= sysdate and lc.finishclassdate >= sysdate then '진행중'
        when lc.startclassdate > sysdate then '예정'
        when lc.startclassdate < sysdate then '종료'
    end as "강의진행상태"
from tblclass c
    inner join tbllclass lc
        on c.class_seq = lc.class_seq
            inner join tbllsubject ls
                on ls.lclass_seq = lc.class_seq
                    inner join tblteacher t
                        on t.teacher_seq = ls.teacher_seq
                            inner join tblclassroom cr
                                on cr.classroom_seq = lc.classroom_seq                                    
                 where ls.teacher_seq = 11
                    order by "개강" asc;
                    
                    
-- 2. 지정 강의(=과정)의 과목 스케줄
create or replace view vwEachLclassSubjectSchedule
as
select 
    c.name as "과정명", --
    sb.name as "과목명", --
    sb.subject_seq as "과목번호", --
    ls.start_date as "과목시작날짜",--
    ls.end_date as "과목종료날짜",--
    b.name as "교재명", --
    cr.name "강의실",
    case
        when ls.start_date <= sysdate and ls.end_date >= sysdate then '진행중'
        when ls.start_date > sysdate then '예정'
        when ls.start_date < sysdate then '종료'
    end as "강의진행상태"
    
from tbllsubject ls
    inner join tbllclass lc
        on lc.lclass_seq = ls.lclass_seq
            inner join tblsubject sb
                on sb.subject_seq = ls.subject_seq
                    inner join tblclass c
                        on c.class_seq = lc.class_seq
                            inner join tblbookname b
                                on b.bookname_seq = ls.bookname_seq
                                    inner join tblclassroom cr
                                        on cr.classroom_seq = lc.classroom_seq
                                            inner join tblteacher t
                                                on t.teacher_seq = ls.teacher_seq
                      where t.teacher_seq = (select t.teacher_seq from tblteacher  t where t.id = 'tpdls1990' and t.jumin = 1234927)
                                            order by ls.start_date asc;
    
    
-- 3. 강의 세부정보 전체 출력
create or replace view vwAllLclassInfo
as
select 
    distinct t.name as "교사명", --
    c.name as "과정명", --
    lc.startclassdate as "개강", --
    lc.finishclassdate as "종강", --
    sb.subject_seq as "과목번호", --
    sb.name as "과목명", --
    ls.start_date as "과목시작날짜",--
    ls.end_date as "과목종료날짜",--
    b.name as "교재명", --
    cr.name "강의실",
    (select 
    count(distinct(student_seq)) 
from tblteacher t inner join tbllsubject ls on t.teacher_seq = ls.teacher_seq
                  inner join tbllclass lc on lc.lclass_seq = ls.lclass_seq
                  inner join tblsugang su on su.lclass_seq = lc.lclass_seq
    where t.teacher_seq =11) as "등록인원수",

    case
        when ls.start_date <= sysdate and ls.end_date >= sysdate then '진행중'
        when ls.start_date > sysdate then '예정'
        when ls.start_date < sysdate then '종료'
    end as "강의진행상태"
    
from tblteacher t
    inner join tbllsubject ls
        on t.teacher_seq = ls.teacher_seq
            inner join tbllclass lc
                on lc.lclass_seq = ls.lclass_seq
                    inner join tblclass c
                        on c.class_seq = lc.class_seq
                            inner join tblbookname b
                                on b.bookname_seq = ls.bookname_seq
                                    inner join tblsubject sb
                                        on ls.subject_seq = sb.subject_seq
                                            inner join tblclassroom cr
                                                on cr.classroom_seq = lc.classroom_seq                                                   
                                                    inner join tblsugang sg
                                                        on sg.lclass_seq = lc.lclass_seq
                                    
                                                             where ls.teacher_seq = 11;
    
    
    
--------------------------------------------------------------------------------
--[교육생 정보 확인]

-- 1. 교육생 전체 출력 (중도탈락 여부 무시)
create or replace view vwAllStuednt
as
select
    distinct
    c.class_seq as "과정번호",
    st.name as "교육생명",
    st.tel as "전화번호",
    st.attenddate as "수강등록일",
    case
        when lc.startclassdate <= sysdate and lc.finishclassdate >= sysdate and sgs.whether = 'N' then '진행중'
        when sgs.whether = 'Y' then '중도탈락'
        when lc.finishclassdate < sysdate and sgs.whether = 'N' then '수료'
        when lc.startclassdate > sysdate then '진행예정' 
    end as "강의진행상태"
from tblsugang sg
    inner join tblstudent st
        on st.student_seq = sg.student_seq
            inner join tbllclass lc
                on lc.lclass_seq = sg.lclass_seq
                    inner join tblclass c
                        on c.class_seq = lc.class_seq
                            inner join tblsugangstate sgs
                                on sgs.sugang_seq = sg.sugang_seq   
                                    inner join tbllsubject ls
                                        on ls.lclass_seq = lc.lclass_seq
                                            inner join tblteacher t
                                                 on t.teacher_seq = ls.teacher_seq
                            where t.id = 'tpdls1990' and t.jumin = 1234927
                                    order by attenddate asc;
                                    
                                    
-- 2. 교육생 정보 = 과정번호 + 강의 진행중 + 지정 교사
create or replace view vwStudentStudying
as
select
    distinct
    c.class_seq as "과정번호",
    st.name as "교육생명",
    st.tel as "전화번호",
    st.attenddate as "등록일",
    case
        when lc.startclassdate <= sysdate and lc.finishclassdate >= sysdate and sgs.whether = 'N' then '진행중'
        when sgs.whether = 'Y' then '중도탈락'
        when lc.finishclassdate < sysdate and sgs.whether = 'N' then '수료'
        when lc.startclassdate > sysdate then '진행예정'
    end as "진행상태"
from tblsugang sg
    inner join tblstudent st
        on st.student_seq = sg.student_seq
            inner join tbllclass lc
                on lc.lclass_seq = sg.lclass_seq
                    inner join tblclass c
                        on c.class_seq = lc.class_seq
                            inner join tblsugangstate sgs
                                on sgs.sugang_seq = sg.sugang_seq
                                    inner join tbllsubject ls
                                        on ls.lclass_seq = lc.lclass_seq
                                            inner join tblteacher t
                                                on t.teacher_seq = ls.teacher_seq
            
        where c.class_seq = '101' -- 과정번호 
            and lc.startclassdate <= sysdate 
            and lc.finishclassdate >= sysdate
            and ls.teacher_seq = (select teacher_seq from tblteacher where id = 'tpdls1990' and jumin = '1234927') -- 선생님 
              order by attenddate asc;
              
              
              
              
-- 3. 과목번호로 등록된 교육생 정보를 조회
create or replace view vwStudentEachSubjectSeq
as
select
    distinct st.name as "교육생명",
    st.id as "아이디",
    st.ssn as "주민번호",
    st.tel as "전화번호",
    st.attenddate as "등록일",
    st.manager_seq "매니저번호"
from tbllsubject ls
    inner join tbllclass lc
        on lc.lclass_seq = ls.lclass_seq
            inner join tblsugang sg
                on sg.lclass_seq = lc.lclass_seq
                    inner join tblstudent st
                        on st.student_seq = sg.student_seq
                            inner join tblclass c
                                on c.class_seq = lc.class_seq
                                    inner join tbllsubject ls
                                        on ls.lclass_seq = lc.lclass_seq
                                            inner join tblteacher t
                                                on t.teacher_seq = ls.teacher_seq                                
        where ls.subject_seq = 1 -- 과목번호 (선택)
            and ls.teacher_seq = (select teacher_seq from tblteacher where id = 'tpdls1990' and jumin = '1234927') -- 선생님 
                                    order by "교육생명";
              
              
     
--==============================================================================
-- [C-03 : 배점 입출력] 

-- [배점 처리]
-- 1. 배점 수정(생략)
-- 2. 배점 입력(생략)
-- 3. 지정 교사의 강의중 종료 과목의 배점 입출력을 조회
create or replace view vwFinishSubjectPoints
as
select 
    sb.subject_seq as "과목번호",
    sb.name as "과목명",
    ls.start_date as "과목시작",
    ls.end_date as "과목종료",
    c.name as "과정명",
    lc.startclassdate as "개강",
    lc.finishclassdate as "종강",
    b.name as "교재명",
    cr.classroom_seq as "강의실",
    p.written as "필기배점",
    p.practical as "실기배점",
    p.pattendance as "출결배점"
     
from tblsubject sb
    inner join tbllsubject ls
        on ls.subject_seq = sb.subject_seq
            inner join tbllclass lc
                on lc.lclass_seq = ls.lclass_seq
                    inner join tblteacher t
                        on t.teacher_seq = ls.teacher_seq
                            inner join tblclass c
                                on c.class_seq = lc.class_seq
                                    inner join tblclassroom cr
                                        on cr.classroom_seq = lc.classroom_seq
                                            inner join tblbookname b
                                                on b.bookname_seq = ls.bookname_seq
                                                    inner join tblpoints p
                                                        on p.subject_seq = sb.subject_seq
    where  ls.end_date < sysdate and t.id = 'tpdls1990' and t.jumin = 1234927;
       
       
-- 4. 배점번호로 해당 강의중 종료한 과목 배점 정보 출력
create or replace view vwNowSubjectSeq
as
select
    p.points_seq as "배점번호",
    lc.lclass_seq as "강의번호",
    sb.name as "과목명",
    p.written as "필기배점",
    p.practical as "실기배점",
    p.pattendance as "출결배점"
     
from tblsubject sb
    inner join tbllsubject ls
        on ls.subject_seq = sb.subject_seq
            inner join tbllclass lc
                on lc.lclass_seq = ls.lclass_seq
                    inner join tblteacher t
                        on t.teacher_seq = ls.teacher_seq
                            inner join tblpoints p
                                on p.subject_seq = sb.subject_seq
    where ls.end_date < sysdate 
        and t.id = 'tpdls1990' 
        and t.jumin = 1234927 
        and p.points_seq = 100;
       
-- [시험정보]--------------------------------------------------------------------

-- 1. 테스트 문제 추가(생략)
       
--==============================================================================







--------------------------------------------------------------------------------       
--------------------------------------------------------------------------------       
--------------------------------------------------------------------------------       
--[SELECT VIEW]-----------------------------------------------------------------      

select * from vwWish;                       -- 교육생 희망취업처 + 희망 연봉 조회
select * from vwWishandCounsel;             -- 교육생 상담 + 희망 취업처 및 연봉 자료 조회
select * from vwTeamAll;                    -- 교육생 팀 전체 조회
select * from vwspecificTeam;               -- 특정강의와 특정팀 구성원 조회
select * from vwCounselAll;                 -- 모든 교육생의 전체 상담 조회
select * from vwCounselEach;                -- 지정 교육생의 전체 상담 조회
select * from vwEachTeacherLclass;          -- vwEachTeacherLclass
select * from vwEachLclassSubjectSchedule;  -- 지정 강의(=과정)의 과목 스케줄
select * from vwAllLclassInfo;              -- 강의 세부정보 전체 출력
select * from vwAllStuednt;                 -- 교육생 전체 출력 (중도탈락 여부 무시)
select * from vwStudentStudying;            -- 교육생 정보 = 과정번호 + 강의 진행중 + 지정 교사
select * from vwStudentEachSubjectSeq;      -- 과목번호로 등록된 교육생 정보를 조회
select * from vwFinishSubjectPoints;        -- 지정 교사의 강의중 종료 과목의 배점 입출력을 조회
select * from vwNowSubjectSeq;              -- 배점번호로 해당 강의중 종료한 과목 배점 정보 출력
--------------------------------------------------------------------------------       
--------------------------------------------------------------------------------       
--------------------------------------------------------------------------------       
--------------------------------------------------------------------------------       

