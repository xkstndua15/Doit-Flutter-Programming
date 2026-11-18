# Doit-Flutter-Programming

《Do it! 플러터 앱 프로그래밍》을 따라 만들며 정리한 예제 모음입니다. 챕터별로 폴더가 하나씩 있습니다.

| 폴더 | 내용 |
| :--- | :--- |
| `first_flutter_app` | 프로젝트 생성과 첫 화면 |
| `widget_example` | 주요 위젯 배치 |
| `material_flutter_app` / `cupertino_main` | Material · Cupertino 스타일 |
| `listview_example` / `tabbar_example` / `subpage_example` | 목록과 화면 이동 |
| `animation_example` | 애니메이션과 슬리버 |
| `internal_example` / `fileio_example` / `sql_example` | 내부 저장소 · 파일 입출력 · SQLite |
| `http_example` / `image_download` / `image_font_add_app` | 네트워크 · 이미지 · 폰트 |
| `firebase_example` | Firebase 연동 |
| `native_example` | 플랫폼 채널 |
| `todo_list` | 할 일 앱 (목록 → 하위 상세 3단계) |
| `intro_example` | 인트로 화면 |

## 실행
```bash
cd todo_list
flutter pub get
flutter run
```

각 폴더는 독립된 Flutter 프로젝트입니다. Firebase 예제는 별도 `google-services.json` 설정이 필요합니다.
