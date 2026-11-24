#!/usr/bin/env bash
# Registra los submódulos de vitaGL, so_util, FalsoJNI y FalsoNDK en el repo.
# Ejecutar UNA VEZ desde la raíz del repo, con el repo ya inicializado con git.
# Después: git add .gitmodules lib && git commit -m "Add submodules" && git push
set -euo pipefail

if [ ! -d .git ]; then
  echo "Error: ejecuta este script desde la raíz de un repo git." >&2
  exit 1
fi

add_sub() {
  local url="$1" path="$2"
  if git config -f .gitmodules --get "submodule.${path}.path" >/dev/null 2>&1 \
     && git ls-files --stage -- "$path" | grep -q '^160000'; then
    echo "ya registrado: $path"
    return
  fi
  # Si la carpeta existe con archivos sueltos, hay que quitarla antes.
  if [ -d "$path" ] && [ -n "$(ls -A "$path" 2>/dev/null)" ]; then
    echo "Error: $path no está vacía. Muévela o bórrala y vuelve a ejecutar." >&2
    exit 1
  fi
  git submodule add --force "$url" "$path"
}

add_sub https://github.com/Rinnegatamante/vitaGL       lib/vitagl
add_sub https://github.com/Rinnegatamante/so_util      lib/so_util
add_sub https://github.com/v-atamanenko/FalsoJNI       lib/falso_jni
add_sub https://github.com/elliencode/FalsoNDK         lib/falso_ndk

echo "Listo. Revisa con: git submodule status"
