#!/bin/bash

# Select the Nerd Font from https://www.nerdfonts.com/font-downloads
# and install it.

echo "[-] Download The Nerd fonts [-]"
echo "#######################"

# Check if OS is Linux or Mac
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac

## linux nerd font

function install_linux_fonts() {
    echo "Installing fonts for Linux"

    fons_list=("Agave" "AnonymousPro" "Arimo" "AurulentSansMono" "BigBlueTerminal" "BitstreamVeraSansMono" "CascadiaCode" "CodeNewRoman" "ComicShannsMono" "Cousine" "DaddyTimeMono" "DejaVuSansMono" "FantasqueSansMono" "FiraCode" "FiraMono" "Gohu" "Go-Mono" "Hack" "Hasklig" "HeavyData" "Hermit" "iA-Writer" "IBMPlexMono" "InconsolataGo" "InconsolataLGC" "Inconsolata" "IosevkaTerm" "JetBrainsMono" "Lekton" "LiberationMono" "Lilex" "Meslo" "Monofur" "Monoid" "Mononoki" "MPlus" "NerdFontsSymbolsOnly" "Noto" "OpenDyslexic" "Overpass" "ProFont" "ProggyClean" "RobotoMono" "ShareTechMono" "SourceCodePro" "SpaceMono" "Terminus" "Tinos" "UbuntuMono" "Ubuntu" "VictorMono")
    for font_name in fonts_list; do
        echo "Starting download $font_name Nerd Font"

        if [ ! -d "$HOME/.fonts/$font_name" ]; then

            if [ "$(command -v curl)" ]; then
                echo "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font_name.zip"
                curl -OL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font_name.zip"
                echo "creating fonts folder: ${HOME}/.fonts"
                mkdir -p "$HOME/.fonts"
                echo "unzip the $font_name.zip"
                unzip "$font_name.zip" -d "$HOME/.fonts/$font_name/"
                fc-cache -fv
                rm -rf "$font_name.zip"
                echo "done!"
                break

            elif [ "$(command -v wget)" ]; then
                echo "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font_name.zip"
                wget "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font_name.zip"
                echo "creating fonts folder: ${HOME}/.fonts"
                mkdir -p "$HOME/.fonts"
                echo "unzip the $font_name.zip"
                unzip "$font_name.zip" -d "$HOME/.fonts/$font_name/"
                fc-cache -fv
                rm -rf "$font_name.zip"
                echo "done!"
                break

            else

                echo "We cannot find the curl and wget command. First, install the curl and wget command, one of them."
                break

            fi

        else
            echo "$font_name exists."
            continue
        fi
    done
}

## mac nerd font
function install_mac_fonts() {
    brew tap homebrew/cask-fonts
    brew install --cask font-3270-nerd-font
    brew install --cask font-fira-mono-nerd-font
    brew install --cask font-inconsolata-go-nerd-font
    brew install --cask font-inconsolata-lgc-nerd-font
    brew install --cask font-inconsolata-nerd-font
    brew install --cask font-monofur-nerd-font
    brew install --cask font-overpass-nerd-font
    brew install --cask font-ubuntu-mono-nerd-font
    brew install --cask font-agave-nerd-font
    brew install --cask font-arimo-nerd-font
    brew install --cask font-anonymice-nerd-font
    brew install --cask font-aurulent-sans-mono-nerd-font
    brew install --cask font-bigblue-terminal-nerd-font
    brew install --cask font-bitstream-vera-sans-mono-nerd-font
    brew install --cask font-blex-mono-nerd-font
    brew install --cask font-caskaydia-cove-nerd-font
    brew install --cask font-code-new-roman-nerd-font
    brew install --cask font-cousine-nerd-font
    brew install --cask font-daddy-time-mono-nerd-font
    brew install --cask font-dejavu-sans-mono-nerd-font
    brew install --cask font-droid-sans-mono-nerd-font
    brew install --cask font-fantasque-sans-mono-nerd-font
    brew install --cask font-fira-code-nerd-font
    brew install --cask font-go-mono-nerd-font
    brew install --cask font-gohufont-nerd-font
    brew install --cask font-hack-nerd-font
    brew install --cask font-hasklug-nerd-font
    brew install --cask font-heavy-data-nerd-font
    brew install --cask font-hurmit-nerd-font
    brew install --cask font-im-writing-nerd-font
    brew install --cask font-iosevka-nerd-font
    brew install --cask font-jetbrains-mono-nerd-font
    brew install --cask font-lekton-nerd-font
    brew install --cask font-liberation-nerd-font
    brew install --cask font-meslo-lg-nerd-font
    brew install --cask font-monoid-nerd-font
    brew install --cask font-mononoki-nerd-font
    brew install --cask font-mplus-nerd-font
    brew install --cask font-noto-nerd-font
    brew install --cask font-open-dyslexic-nerd-font
    brew install --cask font-profont-nerd-font
    brew install --cask font-proggy-clean-tt-nerd-font
    brew install --cask font-roboto-mono-nerd-font
    brew install --cask font-sauce-code-pro-nerd-font
    brew install --cask font-shure-tech-mono-nerd-font
    brew install --cask font-space-mono-nerd-font
    brew install --cask font-terminess-ttf-nerd-font
    brew install --cask font-tinos-nerd-font
    brew install --cask font-ubuntu-nerd-font
    brew install --cask font-victor-mono-nerd-font

}

if [ "$machine" == "Linux" ]; then
    install_linux_fonts
    echo "Installed Fonts in Linux"
elif [ "$machine" == "Mac" ]; then
    install_mac_fonts
    echo "Installed Fonts in Mac"
fi
