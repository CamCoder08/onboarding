# onBoard - 킥보드 대여 앱 (iOS)

## 소개

onBoard는 iOS 부트캠프 팀 프로젝트로 제작된 **킥보드 등록 및 대여 시뮬레이션 앱**입니다.  
실제 서비스를 구현하기보다는 iOS 개발 핵심 기술을 **직접 설계하고 적용해보는 데 목적**을 두었습니다.

- UIKit 기반 코드 UI 구성
- Naver Map SDK 연동
- UserDefaults를 활용한 데이터 저장
- Delegate 패턴, TabBar 구조, URLSession 직접 구현 등

> 본 프로젝트는 스토리보드를 사용하지 않고, **모든 화면을 코드와 SnapKit으로 구성**했습니다.

<img width="1431" alt="스크린샷 2025-05-02 11 51 05" src="https://github.com/user-attachments/assets/d2e5d4c2-03c2-4ef6-8f0b-ac84fa37eff5" />

---

## 주요 기능

### 1. 회원가입 및 로그인
- ID, 닉네임, 비밀번호 입력 및 오류, 중복 확인
- 로그인 시 `TabBarController`로 루트 전환
- 마지막 로그인 정보 자동 입력

### 2. 지도 기반 킥보드 탐색
- 기본 10개의 킥보드 마커 표시
- 주소 검색 (Geocode API) 및 현위치(하드코딩) 이동 버튼 지원
- 마커 클릭 → 대여 모달 present

### 3. 킥보드 등록 기능
- 등록모드 토글 → 중앙에 고정 핀 → 등록 모달 present
- 등록 가능한 기기 목록 (`UIPickerView`) 중 선택
- 등록 완료 시 지도에 마커 생성 + 등록 내역 저장

### 4. 킥보드 대여 및 반납
- 마커 클릭 → 대여 모달 present
- 대여하기 → UI 전환 (주행 시간/요금 하드코딩)
- 대여 중 모달 내릴 수 없게 구현
- 반납하기 → 마커 복원 + 대여 내역 저장

### 5. 마이페이지 및 내역 확인
- 등록 내역 / 대여 내역 확인 (UITableView)
- 로그아웃 → 로그인 화면으로 복귀

---

## 기술 스택 및 사용 기술

| 분야 | 내용 |
|------|------|
| UI 구성 | UIKit, SnapKit (스토리보드 미사용)                                                    |
| 지도 API | Naver Maps SDK (`NMFMapView`, `NMFMarker`)                                      |
| 주소 검색 | 네이버 Geocoding API / Reverse Geocode API (`URLSession`)                         |
| 데이터 저장 | `UserDefaults` (Codable 금지 → key 인덱싱 방식)                                    |
| 화면 구조 | MVC 패턴 준수, TabBarController, ViewController 분리                                |
| 이벤트 전달 | Delegate Pattern 사용                                                           |
| 기타 | Alert 확장, 모달 전환, 커스텀 TabBar, PickerView 활용 등                                   |
|-----------------------|-------------------------------------------------------------------------------------------------------------|

---

```
onBoard/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Extensions/
│   ├── DateFormatter.swift
│   └── UIViewController+Extensions.swift
├── HomeMap/
│   ├── HomeViewController.swift
│   ├── MapService.swift
│   ├── KickboardModel.swift
│   └── KickboardManager.swift
├── Login/
│   ├── LoginViewController.swift
│   ├── SignUpViewController.swift
│   ├── UserManager.swift
│   └── UserModel.swift
├── Modal/
│   ├── RegisterModalViewController.swift
│   ├── RentModalViewController.swift
│   ├── RegistrationManager.swift
│   ├── RegistrationModel.swift
│   ├── RentalHistoryModel.swift
│   └── HistoryDisplayManager.swift
├── MyPage/
│   ├── MyPageViewController.swift
│   ├── RegistrationViewController.swift
│   ├── HistoryViewController.swift
│   ├── RegistrationTableViewCell.swift
│   └── HistoryTableViewCell.swift
├── Network/
│   └── AddressSearchAPIManager.swift
├── TabBar/
│   └── TabBarController.swift

''
```


## 프로젝트 회고 (onBoard - 킥보드 앱)

1. 모든 화면을 코드로만 구성하면서 **UIKit과 SnapKit에 대한 이해도가 확실히 높아졌다.**
2. `UserDefaults`를 단순히 쓰는 것을 넘어, **배열/구조체를 인덱싱 방식으로 저장하는 로직**을 직접 구현했다.
3. **Naver Map SDK와 Geocoding API를 연동**하며 외부 API 활용 및 URLSession의 흐름을 익혔다.
4. 마커 터치, 등록 핀, 모달 present 등 **지도 기반 UX 흐름을 설계하고 제어하는 능력**이 향상됐다.
5. **Delegate 패턴을 활용해 모달 → 화면 간 데이터 전달 구조**를 확실히 체득했다.
6. 기능을 분리하면서 자연스럽게 **MVC 구조와 파일 책임 분리에 대한 감각**이 생겼다.
7. 팀원들과 역할을 나눠 구현하면서 협업의 흐름과 코드 통합 방식도 경험했다.
8. 마이페이지와 내역 테이블뷰 구현을 통해 **동적 데이터 UI 구성 경험**을 쌓을 수 있었다.
9. 예상 외로 사소한 버그, 마커 중복, 좌표 반영 문제 등이 많았고 **디버깅과 테스트의 중요성**을 체감했다.
10. 단순히 기능 구현을 넘어, **앱 전체의 흐름을 설계하고 구조화하는 힘이 길러진 시간**이었다.




