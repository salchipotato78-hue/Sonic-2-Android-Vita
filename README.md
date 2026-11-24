# Sonic 2 (Android 2013) – PS Vita port

Port del APK oficial de Sonic the Hedgehog 2 (Android, `com.sega.sonic2`, v3.1.5) a PS Vita
mediante un loader de `.so` (basado en [solobop / soloader-boilerplate](https://github.com/v-atamanenko/soloader-boilerplate)).
El `.so` original y los datos del juego **no** se incluyen en este repositorio.

## Qué necesitas

- Tu propia copia legal del APK de Sonic 2 (Android).
- Un PS Vita con homebrew (taiHEN, VitaShell) y `kubridge.skprx` instalado.
- VitaSDK-softfp para compilar (o el workflow de GitHub Actions).
- El repositorio clonado **con submódulos** (`--recurse-submodules`): `lib/vitagl`,
  `lib/so_util` y `lib/falso_jni` no van incluidos en un zip de descarga.

## Archivos del juego (no se suben al repo)

1. Abre el APK con un explorador ZIP y extrae `lib/armeabi-v7a/libRetroEngineJNI.so`.
2. Copia `assets/Data.rsdk.xmf` del APK tal cual (no lo renombres).
3. En el Vita, coloca ambos archivos en `ux0:data/s2/`.


## Submódulos (solución al error "Cannot find source file lib/falso_jni/FalsoJNI.c")

Si CI falla porque faltan `lib/falso_jni`, `lib/so_util` o `lib/vitagl`, el repo no tiene los
submódulos registrados. Un zip o una copia de archivos no los incluye. Para arreglarlo, desde la
raíz del repo:

```sh
./scripts/setup-submodules.sh
git add .gitmodules lib
git commit -m "Register vendored submodules"
git push
```

Luego comprueba con `git submodule status`: deben aparecer cuatro líneas con un hash.

## Compilar

```sh
git clone --recurse-submodules <url-de-este-repo>
cd sonic2-vita
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

El VPK queda en `build/`. Título: "Sonic 2", ID `SNIC00002`.

## Estado

- [x] Nombres de exportaciones JNI verificados contra el `.so` de Sonic 2 (ver `docs/SYMBOLS.md`).
- [x] Los 76 imports no JNI del `.so` están resueltos en `source/dynlib.c`.
- [ ] Compilar con VitaSDK-softfp (no compilado todavía).
- [ ] Probar arranque, gráficos (vitaGL), audio y controles en hardware.
- [ ] Verificar el mapeo de botones contra `Sonic2Activity` (se heredó del port de Sonic 1).
- [ ] Revisar el idioma y la pantalla de inicio.

## Créditos

- Loader: solobop / soloader-boilerplate y so_util, de Volodymyr Atamanenko, basado en el trabajo de TheFloW.
- FalsoJNI y vitaGL, de Rinnegatamante y colaboradores.
- Sonic the Hedgehog 2 © SEGA. Este proyecto no está afiliado a SEGA.

## Licencia

Ver `LICENSE` (heredada del template). El código de este port no incluye assets de SEGA.
