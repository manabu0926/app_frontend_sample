## Flutterアプリ作成サンプルテンプレート

- FirebaseAuthentication
- OpenApi
- Riverpod
- 多言語対応
- DDDっぽいフォルダ構成

で構成したテンプレートです。

## 立ち上げ方法
### iphoneのシミュレーター立ち上げ方法

```
flutter pub get

open -A Simulator

flutter run
```

### openapiのデータ更新方法
```
openapi-generator generate -i openapi/openapi.yml -g openapi-yaml -o ./openapi/generated

cd openapi/generated/server ; flutter pub get ; flutter packages pub run build_runner build

```