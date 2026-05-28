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

# Identifica qual terminal o usuário usa (bash ou zsh)
SHELL_RC="$HOME/.bashrc"
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_RC="$HOME/.zshrc"
fi

# 1. Atualizar sistema e instalar dependências básicas
echo -e "${YELLOW}[1/6] Verificando pacotes básicos (curl/unzip/wget)...${NC}"
if ! command -v curl &> /dev/null || ! command -v unzip &> /dev/null || ! command -v wget &> /dev/null; then
    sudo apt update -y
    sudo apt install -y curl unzip wget
else
    echo "Pacotes básicos já instalados!"
fi

# 2. Instalar Node.js (Versão LTS 20) e npm
echo -e "${YELLOW}[2/6] Verificando Node.js e npm...${NC}"
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
else
    echo "Node.js já instalado! Versão: $(node -v)"
fi

# 3. Instalar Java (OpenJDK 17)
echo -e "${YELLOW}[3/6] Verificando Java (OpenJDK 17)...${NC}"
if ! command -v java &> /dev/null; then
    sudo apt install -y openjdk-17-jdk
else
    echo "Java já instalado!"
fi

# 4. Baixar e configurar Android SDK Lite
echo -e "${YELLOW}[4/6] Configurando Android SDK Lite...${NC}"
ANDROID_HOME="$HOME/Android"
CMD_LINE_TOOLS="$ANDROID_HOME/cmdline-tools/latest"

mkdir -p "$ANDROID_HOME/cmdline-tools"

if [ ! -d "$CMD_LINE_TOOLS" ]; then
    cd "$ANDROID_HOME/cmdline-tools"
    wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip
    unzip cmdline-tools.zip
    mv cmdline-tools latest
    rm cmdline-tools.zip
else
    echo "Android SDK Lite já configurado!"
fi

# Exportar variáveis temporariamente para o passo 5 funcionar
export ANDROID_HOME="$HOME/Android"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"

# 5. Aceitar licenças e baixar SDKs do Android
echo -e "${YELLOW}[5/6] Aceitando licenças e instalando SDKs essenciais...${NC}"
yes | sdkmanager --licenses > /dev/null 2>&1
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" > /dev/null 2>&1

# 6. Criar o comando GLOBAL 'create-app' e configurar Ambiente
echo -e "${YELLOW}[6/6] Criando comando global e configurando ambiente...${NC}"

# Cria o executável 'create-app' na pasta de binários do sistema (/usr/local/bin)
sudo tee /usr/local/bin/create-app > /dev/null << 'EOF'
#!/bin/bash
if [ -z "$1" ]; then
    echo -e "\033[1;33m⚠️  Erro: Você precisa informar o nome do aplicativo.\033[0m"
    echo -e "Exemplo: \033[0;32mcreate-app MeuApp\033[0m"
    exit 1
fi
npx create-expo-app "$1"
echo -e "\n\033[0;32m✅ Projeto $1 criado com sucesso!\033[0m"
echo -e "Para testar no Android, digite:"
echo -e "\033[0;34mcd $1 && npx expo run:android\033[0m\n"
EOF

# Dá permissão para qualquer usuário executar o comando
sudo chmod +x /usr/local/bin/create-app

# Adiciona as variáveis do Android ao perfil do terminal APENAS se não existirem
if ! grep -q "ANDROID_HOME" "$SHELL_RC"; then
echo '
# --- AMBIENTE REACT NATIVE / EXPO ---
export ANDROID_HOME=$HOME/Android
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools' >> "$SHELL_RC"
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
echo -e "O comando ${GREEN}create-app${NC} foi instalado globalmente no seu Linux!"
echo -e "Você já pode usá-lo imediatamente digitando:"
echo -e "${YELLOW}create-app NomeDoSeuApp${NC}"
echo -e "${BLUE}==================================================${NC}"
echo -e "Nota: Se for a primeira vez instalando, reinicie seu terminal"
echo -e "para que o Android SDK seja reconhecido ao rodar os apps."
echo -e "${BLUE}==================================================${NC}"
