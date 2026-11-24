# Símbolos de libRetroEngineJNI.so (Sonic 2, Android v3.1.5)

Extraídos con `readelf --dyn-syms -W lib/armeabi-v7a/libRetroEngineJNI.so` del `base.apk`.
El APK es `com.sega.sonic2`; el `.so` tiene SONAME `libRetroEngineJNI.so`.

## Librerías necesarias (DT_NEEDED)
libGLESv1_CM.so, libOpenSLES.so, liblog.so, libm.so, libstdc++.so, libc.so, libdl.so

## Exports JNI (prefijo com_christianwhitehead_rsdk_RetroEngine_)
Todos los que usa `source/sonic2/driver.c` existen en el `.so`:

```
addTouch            clearTouchData      createAudioBufferQueue  createDeviceTextures
removeTouch         setAPKDirectory     setSaveFileName         setScreenDimensions
setTouch            setKeyData          setGameMode             setGameLanguage
setVersionNumber    setOnlineCapabilities  startup              shutdown
processMainLoop     startAudioBufferQueue  stopAudioBufferQueue bindJavaENV
bindJavaObject2JNI  getGlobalVariable   setGlobalVariable       setGameDeviceType
setBitDepth         receive2PVSMatchCode   receive2PVSData
```

## Imports no JNI (76 en total)
Todos están resueltos en `source/dynlib.c` (comprobado nombre por nombre).
Destacan: GLES1 (glTexImage2D, glDrawElements, glLightfv, glGenFramebuffersOES, ...),
OpenSL ES (slCreateEngine, SL_IID_*), pthread_create y la libc estándar.

## Datos
- `assets/Data.rsdk.xmf` empieza con la cabecera `RSDKvB`. Se pasa tal cual a `setAPKDirectory`
  (el motor lo registra como contenedor RSDK), no hace falta renombrarlo.
- `assets/api_key.txt` y `assets/xplode/` no son necesarios para el port.

## Pendiente de verificar
- Índices de `setKeyData` y mapeo de botones: se heredaron del port de Sonic 1. Revisar el
  bytecode de `Sonic2Activity.onKeyDown` antes de dar el port por bueno.
- Idioma por defecto (0 = inglés) y `setGameMode(5)`.
