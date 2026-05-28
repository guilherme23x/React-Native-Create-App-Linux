#!/bin/bash

# Cores para o terminal
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sem Cor

echo -e "${BLUE}==================================================${NC}"
echo -e "${GREEN}   INSTALADOR AUTOMÁTICO - REACT NATIVE / EXPO   ${NC}"
echo -e "${BLUE}==================================================${NC}"
echo ""

# 1. Atualizar sistema e instalar dependências básicas
echo -e "${YELLOW}[1/6] Atualizando pacotes e instalando curl/unzip...${NC}"
sudo apt update -y
sudo apt install -y curl unzip wget

# 2. Instalar Node.js (Versão LTS 20) e npm
echo -e "${YELLOW}[2/6] Instalando Node.js e npm...${NC}"
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# 3. Instalar Java (OpenJDK 17)
echo -e "${YELLOW}[3/6] Instalando Java (OpenJDK 17)...${NC}"
sudo apt install -y openjdk-17-jdk

# 4. Baixar e configurar Android SDK Lite (Command-line Tools)
echo -e "${YELLOW}[4/6] Configurando Android SDK Lite...${NC}"
ANDROID_HOME="$HOME/Android"
CMD_LINE_TOOLS="$ANDROID_HOME/cmdline-tools/latest"

mkdir -p "$ANDROID_HOME/cmdline-tools"
cd "$ANDROID_HOME"

if [ ! -d "$CMD_LINE_TOOLS" ]; then
    wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip
    unzip cmdline-tools.zip
    mv cmdline-tools latest
    mv latest cmdline-tools/
    rm cmdline-tools.zip
fi

# 5. Exportar variáveis para este script e instalar ferramentas do Android
export ANDROID_HOME="$HOME/Android"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"

echo -e "${YELLOW}[5/6] Aceitando licenças e instalando Android 34...${NC}"
yes | sdkmanager --licenses > /dev/null 2>&1
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" > /dev/null 2>&1

# 6. Configurar o Linux e evitar erros de falta de Memória RAM (Gradle Global)
echo -e "${YELLOW}[6/6] Configurando perfil do Linux e Prevenção de RAM...${NC}"

# Adiciona ao .bashrc apenas se não existir
if ! grep -q "ANDROID_HOME" ~/.bashrc; then
echo '
# --- AMBIENTE REACT NATIVE / EXPO ---
export ANDROID_HOME=$HOME/Android
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Atalho para criar apps facilmente
function create-app() {
    npx create-expo-app "$1"
    echo -e "\nProjeto $1 criado! Para rodar digite:"
    echo -e "cd $1 && npx expo run:android\n"
}' >> ~/.bashrc
fi

# Cria as configurações do Gradle globalmente para evitar crash de RAM
mkdir -p "$HOME/.gradle"
cat <<EOF > "$HOME/.gradle/gradle.properties"
org.gradle.jvmargs=-Xmx1536M -XX:MaxMetaspaceSize=512m
org.gradle.parallel=false
org.gradle.daemon=false
org.gradle.workers.max=1
EOF

echo ""
echo -e "${GREEN}✅ INSTALAÇÃO CONCLUÍDA COM SUCESSO! ✅${NC}"
echo -e "${BLUE}==================================================${NC}"
echo -e "Por favor, reinicie o seu terminal ou rode o comando:"
echo -e "${YELLOW}source ~/.bashrc${NC}"
echo ""
echo -e "Como criar um aplicativo a partir de agora?"
echo -e "Basta digitar: ${GREEN}create-app NomeDoSeuApp${NC}"
echo -e "Depois, entre na pasta e rode: ${GREEN}npx expo run:android${NC}"
echo -e "${BLUE}==================================================${NC}"
