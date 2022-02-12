
![header](https://capsule-render.vercel.app/api?type=Rect&color=gradient&height=150&section=header&text=교육센터운영프로그램%20&fontSize=60)



![main](https://user-images.githubusercontent.com/95897233/153696110-ddd9124c-fdaa-45dc-bc7e-4937113c4131.JPG)

<h5>ㅤ

# 📖 content
1. <a href=#outline>프로젝트 개요</a>
2. <a href=#environment>개발환경</a> 
3. <a href=#erd>ERD</a>
4. <a href=#charge>담당 기능 구현</a>
5.  프로젝트 파일
6. 프로젝트를 마치며 

---
<h5>ㅤ
<h5>ㅤ

## <a id="outline">프로젝트 개요</a>   
```
교육센터 이용자인 관리자, 선생님, 학생들의 데이터베이스를 효율적으로 관리하고 인사 관리 전반을 하나의 플랫폼을 하나로 관리하고 교육생의 교육환경을 개선하는 방향입니다.
``` 
<h5>ㅤ

## <a id="environment">개발환경</a>
- 프로젝트 인원 : 6인
- 개발 플랫폼 &nbsp;&nbsp;&nbsp;&nbsp;: Windows 10
- 개발 툴 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: SQL Developer, eXERD
- 사용 언어 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: Oracle SQL

<h5>ㅤ

## <a id="erd">ERD</a>

![erd](https://user-images.githubusercontent.com/95897233/153698192-5b88b34f-feb8-4995-b819-ff26d95ae5a4.png)


<h5>ㅤ

## <a id="charge">담당 기능 구현</a>

```
1. 관리자
▪ B-13. 희망 취업처 및 연봉 조회 : 관리자의 학생들의 희망 취업처 및 희망 연봉 조회
	- 희망 취업처와 연봉 조회
	- 학생(상담내용 + 희망 취업처 + 희망 연봉) 조회
▪ B-14. 교육생 팀 편성 조회
	- 팀 조회
	- 특정 강의의 특정 팀 조회
▪ B-15. 교육생 상담조회
* 전체 예외 처리 		
```

```
2. 선생님
▪ C-01. 계정관리
▪ C-02. 강의 스케줄 조회 
	- 교사별 강의 과정 스케줄 조회
	- 지정 강의의 과목 스케줄
	- 전체 조회 : 교사명, 과정명, 과정기간, 과목번호, 과목명, 과목기간, 교재명, 강의실, 인원, 강의진행상태
	- 과목번호로 특정과목 조회
▪ C-03. 배점입출력
* 전체 예외 처리 
```  


### 1.  관리자
#### B-13.  희망 취업처 및 연봉 조회 
- 학생들의 희망 취업처 및 희망 연봉 조회

![b13_1](https://user-images.githubusercontent.com/95897233/153698986-d3bf02d5-899d-4808-bc4f-ac00f308e9a6.JPG)

```
tblwishjob, tblStudent의 inner join으로 학생들의 희망 취업처 및 희망 연봉을 조회합니다.
%'||pstudent||'%'으로 학생이름으로 검색할 수 있으며 이름의 일부만 입력해도 관련 데이터가 출력됩니다.
```
<h5>ㅤ

<div align="center">▫&nbsp;&nbsp;&nbsp;▫&nbsp;&nbsp;&nbsp;▫</div>  
<h5>ㅤ

- 학생(상담내용 + 희망 취업처 + 희망 연봉) 조회 

![b13_2](https://user-images.githubusercontent.com/95897233/153699077-b8d8fd41-05e6-4d4d-bf22-e552e499c411.JPG)

```
tblStudent, tblwishjob, tblsugang, tblcounsel의 inner join과 '%'||pstudent||'%'으로 
학생관련 데이터를 출력합니다.
```

<h5>ㅤ


#### B-14. 교육생 팀 편성 조회
- 전체 수강생 팀 조회

![b14_1](https://user-images.githubusercontent.com/95897233/153701576-d0efa38c-df98-4dc3-bf44-f83e01a429f9.JPG)
```
tblStudent, tblsugang, tblTeam, tbllclass의 inner join과 '%'||pteam||'%'으로 
수강생의 팀 데이터를 출력합니다.
```
<h5>ㅤ
<div align="center">▫&nbsp;&nbsp;&nbsp;▫&nbsp;&nbsp;&nbsp;▫</div>  
<h5>ㅤ

- 특정 강의의 특정 팀 조회

![b14_2](https://user-images.githubusercontent.com/95897233/153701778-9284e34c-30fb-4049-beca-eec9b24975d4.JPG)

```
tblStudent, tblsugang, tblTeam, tbllclass, tblclass inner join과 
'%'||pteam||'%', %'||plecture||'%' 으로 출력합니다.
```
 
 <h5>ㅤ

#### B-15. 교육생 상담조회

![b15](https://user-images.githubusercontent.com/95897233/153701925-b399ec97-d8fe-4416-925f-ed76f0835427.JPG)

```
tblStudent, tblsugang, tblcounsel, tblmanager의 inner join과 
'%'||pname||'%', '%'||ppurpose||'%'으로 학생이름과 목적으로 검색내용을 출력합니다. 
```

<h5>ㅤ


#### C-01. 계정관리
![c01](https://user-images.githubusercontent.com/95897233/153702055-652b9be9-db97-4f82-ad0e-baf5165b4654.JPG)
```
프로시저에 ProTAccountSearch('아이디',비밀번호)를 입력해서 해당 데이터를 출력합니다. 
```

<h5>ㅤ


#### C-02. 강의 스케줄 조회 
- 교사별 강의 과정 스케줄 조회

![c02_1](https://user-images.githubusercontent.com/95897233/153702181-bd940693-b744-4ec4-bc59-6b9e363100d5.JPG)
```
distinct, count, subquery, case~end와 tblteacher, tbllsubject, tbllclass, tblsugang, 
tblclassroom의 inner join으로 출력합니다.
```

<h5>ㅤ

<div align="center">▫&nbsp;&nbsp;&nbsp;▫&nbsp;&nbsp;&nbsp;▫</div>  
<h5>ㅤ

- 지정 강의의 과목 스케줄 : 강의명 중복 미허용

![c02_2](https://user-images.githubusercontent.com/95897233/153702393-b352cb8b-d8e2-46b0-ac4b-7bdea0b36464.JPG)
```
case~end, tbllsubject, tbllclass, tblsubject, tblclass, tblbookname, tblclassroom의 
inner join으로 데이터를 출력합니다. 현재 출력 날짜에 따라 강의 진행중 상태가 다르게 나타나도록 
기간을 설정하였습니다.
```
<h5>ㅤ

<div align="center">▫&nbsp;&nbsp;&nbsp;▫&nbsp;&nbsp;&nbsp;▫</div>  
<h5>ㅤ

- 전체 조회 :  교사명, 과정명, 과정기간, 과목번호, 과목명, 과목기간, 교재명, 강의실, 인원, 강의진행상태

![c02_3](https://user-images.githubusercontent.com/95897233/153702635-cdc02433-9f7c-475e-ae14-ae6f830044d1.JPG)

```
distinct, case~end, tblsugang, tblstudent, tbllclass, tblclass, tblsugangstate, 
tbllsubject, tblteacher의 inner join으로 데이터를 출력합니다.
```
<h5>ㅤ

<div align="center">▫&nbsp;&nbsp;&nbsp;▫&nbsp;&nbsp;&nbsp;▫</div>  
<h5>ㅤ


- 과목번호로 특정과목 조회

![c02_4](https://user-images.githubusercontent.com/95897233/153702801-b13b8f3e-4e43-4f61-8aa5-1c1d6454fd63.JPG)
```
distinct, tbllsubject, tbllclass, tblsugang, tblstudent, tblclass, tbllsubject, 
tblteacher의 inner join으로 데이터를 출력합니다.
```
