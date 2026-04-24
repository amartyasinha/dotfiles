#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew installation failed."
  exit 1
fi

brew install autoconf bash binutils coreutils diffutils ed findutils flex gawk \
  gnu-indent gnu-sed gnu-tar gnu-which gpatch grep gzip less m4 make nano \
  screen watch wdiff wget zip

zshrc="${HOME}/.zshrc"
marker_start="# >>> GNU tools PATH (Homebrew) >>>"

if [[ ! -f "${zshrc}" ]]; then
  touch "${zshrc}"
fi

if ! grep -Fq "${marker_start}" "${zshrc}"; then
  cat >>"${zshrc}" <<'EOF'
# >>> GNU tools PATH (Homebrew) >>>
if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  # gnubin; gnuman
  for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnubin; do export PATH=$d:$PATH; done
  # I actually like that man grep gives the BSD grep man page
  #for d in ${HOMEBREW_PREFIX}/opt/*/libexec/gnuman; do export MANPATH=$d:$MANPATH; done
fi
# <<< GNU tools PATH (Homebrew) <<<
EOF
  echo "Appended GNU tools PATH snippet to ${zshrc}"
else
  echo "GNU tools PATH snippet already present in ${zshrc}"
fi

echo "Done. Run: source ${zshrc}"
