
![header](https://capsule-render.vercel.app/api?type=Rect&color=gradient&height=150&section=header&text=교육센터운영프로그램%20&fontSize=60)



![main](https://user-images.githubusercontent.com/95897233/153696110-ddd9124c-fdaa-45dc-bc7e-4937113c4131.JPG)

<h5>ㅤ

# 📖 content
1. <a href=#outline>프로젝트 개요</a>
2. <a href=#environment>개발환경</a> 
3. <a href=#erd>ERD</a>
4. <a href=#charge>담당 기능 구현</a>
5. <a href=#file>프로젝트 파일</a>
6. <a href=#end>프로젝트를 마치며</a> 

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


### 2.  선생님
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

#### C-03. 배점입출력
- 배점 입력

![c03_1_1](https://user-images.githubusercontent.com/95897233/153703328-8ad7b399-eb88-41d1-838f-4e9e3be376b1.JPG)
![c03_1_2](https://user-images.githubusercontent.com/95897233/153703400-142c76fb-53fd-4131-8d19-af9bc53cb735.JPG)
```
if문을 이용해 출석 배점은 20점이상, 총 배점의 합은 100이 되도록 조건을 걸었으며 
그 외의 경우는 에러 메시지를 출력합니다.
```
<h5>ㅤ

<div align="center">▫&nbsp;&nbsp;&nbsp;▫&nbsp;&nbsp;&nbsp;▫</div>  
<h5>ㅤ

- 배점 수정

![c04_1](https://user-images.githubusercontent.com/95897233/153703545-2d209c5a-3653-4eec-966b-278a411b9df8.JPG)
![c04_2](https://user-images.githubusercontent.com/95897233/153703572-2caef56e-98b5-4942-964b-12ab98acf601.JPG)
```
배점 입력과 마찬가지로 같은 조건을 걸었으며 잘못된 입력시 에러 메시지를 출력합니다.
```
[잘못입력시]
![c03_2](https://user-images.githubusercontent.com/95897233/153704042-ea043ae1-35f4-4dd0-a8d5-5a6a0cfc8341.JPG)
![c03_3](https://user-images.githubusercontent.com/95897233/153704046-ba847e69-e5e9-45ce-bd02-430f1793bafa.JPG)

<h5>ㅤ

<div align="center">▫&nbsp;&nbsp;&nbsp;▫&nbsp;&nbsp;&nbsp;▫</div>  
<h5>ㅤ

- 특정 과목을 조회 : 강의를 마친 과목

![c05](https://user-images.githubusercontent.com/95897233/153704106-25eb8e29-029f-47fb-b22a-369212609c80.JPG)
```
날짜 조건과 inner join으로 해당 데이터를 출력합니다.
```

<h5>ㅤ

<div align="center">▫&nbsp;&nbsp;&nbsp;▫&nbsp;&nbsp;&nbsp;▫</div>  
<h5>ㅤ

- 배점번호로 해당 강의 중 종료된 과목 배점 정보 출력

![c06](https://user-images.githubusercontent.com/95897233/153704236-b2d47444-42ab-447a-bbdc-4902325e0fb4.JPG)
```
inner join과 where절로 현재 날짜 기준으로 종료된 강의를 출력합니다.
```

<h5>ㅤ

<div align="center">▫&nbsp;&nbsp;&nbsp;▫&nbsp;&nbsp;&nbsp;▫</div>  
<h5>ㅤ

- 문제 추가

![c07](https://user-images.githubusercontent.com/95897233/153704535-fa23978a-cb4f-4f8d-ad3f-65ef2f0721a8.JPG)
```
insert와 if문으로 새로운 문제를 추가 할 수 있습니다. 
```
<h5>ㅤ
<h5>ㅤ



## 5. <a id="file">프로젝트 파일</a>
<div align="center"/>
<a href="https://github.com/helloppiok/EducationCenterManagement/files/8053095/default.docx"><img src="https://img.shields.io/badge/요구분석서-EB482C?style=plastic;logoColor=white" style="max-width: 100%;" height= "30"></a>  <a href="https://github.com/helloppiok/EducationCenterManagement/files/8053096/DDL.docx"><img src="https://img.shields.io/badge/테이블정의서(DDL)-F58E1C?style=plastic;logoColor=white" style="max-width: 100%;" height= "30"></a>   <a href="https://github.com/helloppiok/EducationCenterManagement/files/8053097/DML.docx"><img src="https://img.shields.io/badge/테이블정의서(DML)-22B14C?style=plastic;logoColor=white" style="max-width: 100%;" height= "30"></a>
  <a href="https://github.com/helloppiok/EducationCenterManagement/files/8053108/2.zip"><img src="https://img.shields.io/badge/전체데이터-black?style=plastic;logoColor=white" style="max-width: 100%;" height= "30"></a>  <a href="https://github.com/helloppiok/EducationCenterManagement/files/8053101/5.PPT.pptx"><img src="https://img.shields.io/badge/PPT-026DE5?style=plastic;logoColor=white" style="max-width: 100%;" height= "30"></a>   <a href=" https://github.com/helloppiok/EducationCenterManagement/files/8053102/5.docx"><img src="https://img.shields.io/badge/최종요약본-7A297B?style=plastic;logoColor=white" style="max-width: 100%;" height= "30"></a>  
		
</div>  
	
<h5>ㅤ
<h5>ㅤ



## 6. <a id="end">✨프로젝트를 마치며</a>
```
처음에 배울 때는 굉장히 쉽다고 느꼈으나 프로젝트를 하면서 생각보다 신경써야 할 것이 많다는걸 알았습니다. 
가장 시간이 많이 들었던 부분은 inner join할 테이블이 많아질수록 group by할 부분도 생기고 에러가 발생
하지는 않지만 결과값이 전혀 다르게 나오는 등 이런 부분들이 새벽작업을 하도록했습니다.
하지만 직접 데이터를 만들고 생각한 쿼리로 데이터가 나오는 부분이 시원(?)하다는 생각이 들었던 
그런 점이 저를 즐겁게했던 프로젝트였습니다.
```
