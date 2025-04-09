#!/bin/bash

OS_NAME=$(uname -s)

if [ "$OS_NAME" = "Linux" ]; then

  sudo -v

  echo "OS Detected: Linux"

  if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
    echo "Distro: $DISTRO"
  else
    echo "Couldn't detect Linux distribution."
    exit 1
  fi

  echo "Installing: fish, git, gcc, python, micro"

  case "$DISTRO" in
    ubuntu|debian)
      sudo apt update
      sudo apt install -y fish gcc python3 micro
      ;;
    arch|manjaro)
      sudo pacman -Sy --noconfirm
      sudo pacman -Sy --noconfirm fish gcc python micro
      ;;
    fedora)
      sudo dnf update -y
      sudo dnf install -y fish gcc python3 micro
      ;;
    *)
      echo "Unsupported Linux distro: $DISTRO"
      echo "Contact me if you need help setting up manually"
      echo "soroush0003souzandeh@gmail.com"
      exit 1
      ;;
  esac

elif [ "$OS_NAME" = "Darwin" ]; then

  sudo -v

  echo "OS Detected: macOS"

  echo "Installing: fish, git, gcc, python, micro"

  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  brew update
  brew install fish git gcc python micro

else
  echo "Sorry, I couldn't detect your operating system."
  echo "Contact me if you need help setting up manually"
  echo "soroush0003souzandeh@gmail.com"
fi

FISH_PATH=$(which fish)
chsh -s $FISH_PATH
echo "Shell has been changed to fish successfully!"

mkdir -p ~/.config/micro
cat > ~/.config/micro/settings.json << EOF
{
  "colorscheme": "solarized",
  "tabstospaces": true,
  "tabsize": 2,
  "autosave": true,
  "saveundo": true,
  "scrollbar": false,
  "statusformatl": "\$(filename) \$(modified)",
  "statusformatr": "\$(line),\$(col)"
}
EOF
echo "Micro editor settings have been successfully configured!"

echo "All tasks have been successfully completed!"