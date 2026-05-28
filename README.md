<div align="center">
  <a href="#pt">🇧🇷 Leia em Português</a> | <a href="#en">🇺🇸 Read in English</a>
</div>

<br>

<a name="pt"></a>
# 🚀 Auto Setup: React Native & Expo (Linux Edition)

![Bash](https://img.shields.io/badge/Script-Bash-4EAA25?style=flat-square&logo=gnu-bash)
![React Native](https://img.shields.io/badge/React_Native-20232A?style=flat-square&logo=react&logoColor=61DAFB)
![Android](https://img.shields.io/badge/Android_SDK-3DDC84?style=flat-square&logo=android&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)

Um script automatizado e inteligente para configurar todo o seu ambiente de desenvolvimento mobile no Linux (Ubuntu, Mint, Debian, etc.). 

Em vez de instalar o pesado Android Studio (que consome gigabytes de disco e RAM), este script instala apenas o **Android SDK Lite (Command-line Tools)**. Além disso, ele **injeta travas globais no Gradle** para impedir que o seu computador trave por falta de Memória RAM durante a compilação.

---

## ✨ O que este script faz por você?
1. Instala **Node.js (LTS)** e dependências básicas (`curl`, `unzip`).
2. Instala o **Java (OpenJDK 17)** exigido pelo Android.
3. Baixa e configura o **Android SDK de Linha de Comando**.
4. Aceita as licenças do Google automaticamente e baixa a Plataforma 34.
5. Injeta as variáveis de ambiente (`ANDROID_HOME`) no seu `~/.bashrc`.
6. Configura o Gradle globalmente (`~/.gradle/gradle.properties`) para usar no máximo **1.5GB de RAM** e desativar paralelismo (Adeus crashes de memória!).
7. Cria um comando customizado no seu terminal chamado `create-app`.

---

## 🛠️ Como instalar

**⚠️ IMPORTANTE:** NÃO rode o script com `sudo bash script...`. Se você fizer isso, o Android SDK será instalado na pasta do Administrador (`/root`) e você não conseguirá acessá-lo. O script já pede `sudo` internamente apenas quando necessário.

No seu terminal, rode os comandos abaixo:

```bash
# 1. Dê permissão de execução ao script
chmod +x script-create-android-app-react-native.sh

# 2. Execute o script como usuário normal
./script-create-android-app-react-native.sh

# 3. Recarregue o seu terminal para ativar os novos comandos
source ~/.bashrc
```

---

## 📱 Como criar e rodar o seu Aplicativo

Graças ao atalho criado pelo script, iniciar um novo projeto agora é muito simples:

```bash
# 1. Crie o aplicativo (substitua MeuApp pelo nome desejado)
create-app MeuApp

# 2. Entre na pasta criada
cd MeuApp

# 3. Compile e rode no seu celular
npx expo run:android
```

---

## ⚙️ Configurando Dispositivos Físicos

### 🤖 Android (Via Cabo USB)
Para testar o aplicativo compilado nativamente direto no seu Android, você precisa habilitar a Depuração USB:

1. No celular, vá em **Configurações > Sobre o Telefone**.
2. Toque 7 vezes em **Número da Versão** (ou Versão da MIUI/OneUI) para virar Desenvolvedor.
3. Volte, acesse **Opções do Desenvolvedor** e ative a **Depuração USB**.
4. Conecte o celular ao PC via cabo.
5. No terminal do PC, rode o comando `adb devices`.
6. O celular vai mostrar um pop-up pedindo permissão. Marque **"Sempre permitir deste computador"** e toque em Permitir. Seu celular está pronto!

### 🍏 iOS (iPhone/iPad)
A compilação de código nativo para iOS **exige um sistema macOS** (regras da Apple). Portanto, o comando `npx expo run:ios` não funciona no Linux.
Porém, você pode testar seu app no iPhone via Wi-Fi usando o **Expo Go**:

1. Baixe o app **"Expo Go"** na App Store do seu iPhone.
2. Certifique-se de que o PC e o iPhone estão na mesma rede Wi-Fi.
3. No terminal, em vez de `run:android`, rode: `npx expo start`
4. Abra a Câmera do seu iPhone, aponte para o **QR Code** que apareceu no terminal e clique no link.

---

## 📦 Como gerar o arquivo `.apk` final

Quando o app estiver pronto para ser publicado ou enviado a amigos, use o compilador local:

1. Pare o servidor do Expo (`Ctrl + C`).
2. Entre na pasta nativa do Android:
   ```bash
   cd android
   ```
3. Rode o comando de empacotamento:
   ```bash
   ./gradlew assembleRelease
   ```
4. Aguarde o aviso de `BUILD SUCCESSFUL`.
5. O seu aplicativo final estará salvo no caminho: 
   `android/app/build/outputs/apk/release/app-release.apk`

<br>
<hr>
<br>

<a name="en"></a>
# 🚀 Auto Setup: React Native & Expo (Linux Edition)

![Bash](https://img.shields.io/badge/Script-Bash-4EAA25?style=flat-square&logo=gnu-bash)
![React Native](https://img.shields.io/badge/React_Native-20232A?style=flat-square&logo=react&logoColor=61DAFB)
![Android](https://img.shields.io/badge/Android_SDK-3DDC84?style=flat-square&logo=android&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)

An automated and smart script to set up your entire mobile development environment on Linux (Ubuntu, Mint, Debian, etc.). 

Instead of installing the heavy Android Studio (which consumes gigabytes of storage and RAM), this script installs only the **Android SDK Lite (Command-line Tools)**. Furthermore, it **injects global constraints into Gradle** to prevent your computer from freezing due to lack of RAM during compilation.

---

## ✨ What does this script do for you?
1. Installs **Node.js (LTS)** and basic dependencies (`curl`, `unzip`).
2. Installs **Java (OpenJDK 17)** required by Android.
3. Downloads and configures the **Android Command-line Tools**.
4. Automatically accepts Google licenses and downloads Platform 34.
5. Injects the required environment variables (`ANDROID_HOME`) into your `~/.bashrc`.
6. Configures Gradle globally (`~/.gradle/gradle.properties`) to use a maximum of **1.5GB of RAM** and disables parallel builds (Goodbye Out-Of-Memory crashes!).
7. Creates a handy custom CLI command called `create-app`.

---

## 🛠️ How to install

**⚠️ IMPORTANT:** DO NOT run the script with `sudo bash script...`. If you do this, the Android SDK will be installed in the Root folder (`/root`) and your standard user won't be able to access it. The script internally requests `sudo` only when strictly necessary.

In your terminal, run the following commands:

```bash
# 1. Give execution permission to the script
chmod +x script-create-android-app-react-native.sh

# 2. Run the script as a normal user
./script-create-android-app-react-native.sh

# 3. Reload your terminal to activate the new commands
source ~/.bashrc
```

---

## 📱 How to create and run your App

Thanks to the shortcut created by the script, starting a new project is now incredibly easy:

```bash
# 1. Create the application (replace MyApp with your desired name)
create-app MyApp

# 2. Enter the created folder
cd MyApp

# 3. Build and run it on your phone
npx expo run:android
```

---

## ⚙️ Configuring Physical Devices

### 🤖 Android (Via USB Cable)
To test the natively compiled application directly on your Android, you need to enable USB Debugging:

1. On your phone, go to **Settings > About Phone**.
2. Tap 7 times on **Build Number** (or MIUI/OneUI Version) to become a Developer.
3. Go back, access **Developer Options**, and enable **USB Debugging**.
4. Connect the phone to the PC via a USB cable.
5. In the PC terminal, run the command: `adb devices`.
6. The phone will show a pop-up requesting permission. Check **"Always allow from this computer"** and tap Allow. Your phone is ready!

### 🍏 iOS (iPhone/iPad)
Compiling native code for iOS **requires a macOS system** (Apple's rules). Therefore, the `npx expo run:ios` command does not work on Linux.
However, you can test your app on your iPhone over Wi-Fi using **Expo Go**:

1. Download the **"Expo Go"** app from the App Store on your iPhone.
2. Ensure the PC and the iPhone are connected to the same Wi-Fi network.
3. In the terminal, instead of `run:android`, run: `npx expo start`
4. Open your iPhone's Camera, point it at the **QR Code** displayed in the terminal, and tap the link.

---

## 📦 How to generate the final `.apk` file

When the app is ready to be published or sent to friends, use the local compiler to generate the release file:

1. Stop the Expo server (`Ctrl + C`).
2. Enter the native Android folder:
   ```bash
   cd android
   ```
3. Run the packaging command:
   ```bash
   ./gradlew assembleRelease
   ```
4. Wait for the `BUILD SUCCESSFUL` message.
5. Your final application will be saved at: 
   `android/app/build/outputs/apk/release/app-release.apk`
