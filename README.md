# Identidad Digital

#### Ultima versión cargada: 1.0.15+44

## Getting started

### Install Flutter

Follow the instructions [here.](https://flutter.dev/docs/get-started/install)

### Download

Clone or download this repository.

```bash
$ git clone https://github.com/fabirt/identidad-digital.git
```

### Set up

Install the dependencies specified in the `pubspec.yaml` file.

```bash
$ fvm flutter pub get
```

### Launch the app

Launch the app in debug mode using a simulator or a connected device.

#### Para desarrollo (dev):

```bash
$ fvm flutter run --flavor dev -t lib/main_dev.dart
```

#### Para producción (prod):

```bash
$ fvm flutter run --flavor prod -t lib/main_prod.dart
```

#### Para QA:

```bash
$ fvm flutter run --flavor qa -t lib/main_qa.dart
```

### Build Commands

#### Generar APK para Android:

```bash
# Debug APK
$ fvm flutter build apk --flavor dev -t lib/main_dev.dart

# Release APK
$ fvm flutter build apk --flavor prod -t lib/main_prod.dart --release
```

#### Generar AAB para Android (Recomendado para Play Store):

```bash
# Debug AAB
$ fvm flutter build appbundle --flavor dev -t lib/main_dev.dart

# Release AAB
$ fvm flutter build appbundle --flavor prod -t lib/main_prod.dart --release
```

#### Generar IPA para iOS:

```bash
# Debug IPA
$ fvm flutter build ios --flavor dev -t lib/main_dev.dart

# Release IPA
$ fvm flutter build ios --flavor prod -t lib/main_prod.dart --release
```

### Ejecución Inalámbrica

#### En navegador web:

```bash
$ fvm flutter run -d chrome --flavor prod -t lib/main_prod.dart
```

#### En dispositivo Android inalámbrico:

1. Habilitar depuración inalámbrica en el dispositivo
2. Conectar por USB primero, luego desconectar
3. Ejecutar:

```bash
$ fvm flutter run --flavor prod -t lib/main_prod.dart
```

#### En dispositivo iOS inalámbrico:

```bash
$ fvm flutter run --flavor prod -t lib/main_prod.dart -d ios
```

### Comandos Útiles

#### Verificar dispositivos conectados:

```bash
$ fvm flutter devices
```

#### Verificar estado de Flutter:

```bash
$ fvm flutter doctor
```

#### Limpiar build:

```bash
$ fvm flutter clean
$ fvm flutter pub get
```
