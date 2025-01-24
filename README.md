```
나와 딱 맞는 쉐어하우스를 찾아주는 중개 플랫폼, Roomie 🏡
35기 AND SOPT 앱잼 Roomie 프로젝트입니다.
```
![Frame 2085666010](https://github.com/user-attachments/assets/d44647e1-d667-43a7-b1df-24a2646b0a6f)
</br>

# ⚒️ iOS Developer
|김수연</br>[@mmaybei](https://github.com/mmaybei)|김승원</br>[@SeungWon1125](https://github.com/SeungWon1125)|김현수</br>[@maeng-kim](https://github.com/@maeng-kim)|
|:---:|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/b5ca043f-5470-4695-8228-b3a086250750" width ="250">|<img src = "https://github.com/user-attachments/assets/eb56a0d7-d32c-46e6-a4a6-b505ef0acabf" width ="250">|<img src = "https://github.com/user-attachments/assets/d581e539-9857-49d1-af4f-465ae707f0d0" width ="250">|
|`지도/검색/필터링`</br>`마이페이지`|`매물 상세 뷰`</br>`입주 신청 플로우`|`홈 뷰`</br>`분위기 별 리스트`</br>`찜 리스트`|

# 🏡 Screenshot
| 홈 | 지도 | 필터링 | 검색 |
|:---:|:---:|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/284a9f1a-cc6c-4b57-98db-044679db5544" width ="200">|<img src = "https://github.com/user-attachments/assets/bdd04f02-aacf-42d1-94a6-b8fe3c223bfe" width ="200">|<img src = "https://github.com/user-attachments/assets/8f1d8c91-9974-4710-9637-27f43ad7495f" width ="200">|<img src = "https://github.com/user-attachments/assets/1e98c0fa-54c8-46ae-8ac9-a62619c44174" width ="200">|
</br>

| 매물 상세 | 내부 이미지 뷰 | 방별 이미지 뷰 | 투어 신청 |
|:---:|:---:|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/e2bfcb04-b777-42c9-a16f-782286b63832" width ="200">|<img src = "https://github.com/user-attachments/assets/1d2dd0b1-24b1-46a1-8e32-29c19d901adb" width ="200">|<img src = "https://github.com/user-attachments/assets/04e90c6f-2fd7-49b0-90c1-7cd85efb302a" width ="200">|<img src = "https://github.com/user-attachments/assets/bf2bb57c-23ae-4e59-a266-9561e29492d1" width ="200">|
</br>

| 분위기별 리스트 | 찜 리스트 | 마이페이지 |
|:---:|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/003fd19e-89d0-4372-b650-7b6d38a89ad0" width ="200">|<img src = "https://github.com/user-attachments/assets/1c3a1b7e-cb18-434c-a52a-0f51ccbf2f4f" width ="200">|<img src = "https://github.com/user-attachments/assets/9ea512e8-d58a-4c47-926c-b2bb8ad105d6" width ="200">|

# ⚙️ Project Design
![프로젝트설계](https://github.com/user-attachments/assets/48d3c7c1-6334-48d3-8beb-d6c259cb231f)

# 🌀 Library
|library|description|version|
|:---:|:---:|:---:|
|**CombineCocoa**|뷰의 상태 관리를 위한 동적 프로그래밍 도입|`0.4.1`|
|**Snapkit**|UI 구현에 있어, 오토레이아웃을 보다 간편하게 사용하기 위함|`5.7.1`|
|**Then**|UI 구현에 있어, 클로저를 통해 인스턴스를 초기화하기 위함|`3.0.0`|
|**Moya**|추상화된 네트워크 레이어를 보다 간편하게 사용하기 위함|`15.0.3`|
|**Kingfisher**|이미지 캐싱 처리 및 UI 성능 개선을 위함|`8.1.3`|
|**NMapsMap**|네이버 지도 구현을 위함|`3.20.0`|
</br>

# ✳️ Coding Convention
[스타일쉐어 Swift 가이드](https://github.com/StyleShare/swift-style-guide)를 기반으로 합니다.</br>
루미 iOS 컨벤션에 따라 일부 수정되었으며, 구성원들의 의사결정에 따라 수시로 변경될 수 있습니다.</br>
자세한 내용은 [아요 루미들의 코딩 컨벤션](https://automatic-protocol-11a.notion.site/16536a29f062800e80cffc65cf303f39?pvs=4) 문서를 참고해주세요.
</br></br>

# 📂 Foldering
```
📁 Roomie
├── 📁 Application
│   ├── 📃 AppDelegate
│   └── 📃 SceneDelegate
├── 📁 Global
│   ├── 🗂️ Base
│   │   ├── 📃 BaseVie
│   │   ├── 📃 BaseViewController.swift
│   │   └── ...
│   ├── 🗂️ Components
│   ├── 📃 Config.xcconfig
│   ├── 🗂️ Enums
│   ├── 🗂️ Extensions
│   ├── 📃 Info.plist
│   ├── 🗂️ Resource
│   │   ├── 🗂️ Fonts
│   │   ├── 📃 Assets.xcassets
│   │   └── 📃 Colors.xcassets
│   └── 🗂️ Utils
├── 📁 Presentation
│   └── 🗂️ Home
│       ├── 🗂️ View
│       │   └── 📃 HomeView.swift
│       ├── 🗂️ ViewController
│       │   └── 📃 HomeViewController.swift
│       └── 🗂️ ViewModel
│           └── 📃HomeViewModel.swift
└── 📁 Network
    ├── 🗂️ Base
    ├── 🗂️ DTO
    ├── 🗂️ Service
    └── 🗂️ TargetType
```

# 📝 Tag Convention
```
[init] 가장 처음 Initial Commit에 태그 붙이기!
[feat] 새로운 기능 구현 시 사용
[fix] 버그나 오류 해결 시 사용
[hotfix] 긴급 수정 시 사용
[docs] README, 템플릿 등 프로젝트 내 문서 수정 시 사용
[setting] 프로젝트 관련 설정 변경 시 사용
[add] 사진 등 에셋이나 라이브러리 추가 시 사용
[refactor] 기존 코드를 리팩토링하거나 수정할 시 사용
[chore] 별로 중요한 수정이 아닐 시 사용
```
```
브랜치의 경우 이슈 번호를 붙여 다음과 같이 작성합니다.
setting/#1-initialSetting
feat/#14-homeUI

커밋의 경우 이슈 번호를 붙여 다음과 같이 작성합니다.
[setting/#1] 프로젝트 초기 세팅
[feat/#14] 홈 화면 UI 구현
```

# 🧤 Git Flow
```
develop 브랜치에서 이슈 번호에 맞는 feature 브랜치를 파서 작업을 진행하고, PR 또한 develop 브랜치로 날려줍니다!

PR을 작성하면 작성자 이외의 다른 팀원들이 코드 리뷰를 진행하고, 문제가 없을 경우 approve 합니다.
수정 사항이 있을 경우 반드시 수정 사항 반영을 마친 후 approve하도록 합니다. 이렇게 모든 팀원의 approve가 완료되면 PR을 머지합니다.
이때 충돌이 생긴다면 반드시 리드 및 팀원에게 노티하도록 합니다!

자신의 로컬 develop 브랜치에서 원격 develop 브랜치를 자주 pull 받음으로써 충돌 상황을 방지합니다.
이슈 및 PR은 작은 단위로, 상대방의 파일은 최대한 건드리지 않습니다.
```

# 💥 Trouble Shooting
[아요 루미들의 트러블 슈팅](https://www.notion.so/16536a29f06280ada9dcc81027a4a935?pvs=4) 
아요들아 고생했어 🫳🫳🫳
