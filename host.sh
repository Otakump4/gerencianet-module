clear
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
WHITE='\033[1;37m'

# Cabeçalho do Script
echo "${YELLOW}================================================================================"
echo "${YELLOW}               Bem-vindo ao Script de Configuração do GitHub!                   "
echo "${YELLOW}           Este script irá ajudar você a subir seu projeto para o GitHub.        "
echo "${YELLOW}          Certifique-se de ter todos os pré-requisitos listados abaixo:          "
echo "${YELLOW}================================================================================"
echo ""

echo "${CYAN}Para hospedar seu projeto no GitHub, siga as instruções abaixo passo a passo."
echo "${CYAN}Antes de começar, você deve ter as seguintes informações preparadas:"
echo ""
echo "${WHITE}1. O link do seu repositório GitHub"
echo "${WHITE}2. Seu nome de usuário no GitHub"
echo "${WHITE}3. Seu Token de acesso pessoal do GitHub (criado em https://github.com/settings/tokens)"
echo ""

echo "${CYAN}Pressione Enter para continuar após ter suas informações prontas..."
read next

# Início do processo de configuração do GitHub

# Solicitar informações do usuário
clear
echo "${CYAN}Digite seu nome de usuário do GitHub (exemplo: seuusuario):"
echo "${WHITE}"
read GITHUB_USER

echo "${CYAN}Agora, digite seu Token de acesso pessoal do GitHub."
echo "${CYAN}O Token pode ser gerado em: https://github.com/settings/tokens"
echo "${CYAN}Quando o token for gerado, cole-o aqui. Não se preocupe, ele ficará visível ao ser colado."
echo "${WHITE}"
read GITHUB_TOKEN  # Sem a opção -s para permitir que o token seja visível

echo "${CYAN}Digite o seu e-mail de cadastro no GitHub (exemplo: seuemail@dominio.com):"
echo "${WHITE}"
read GITHUB_EMAIL

# Confirmar o link do repositório
echo "${CYAN}Agora, cole o link do seu repositório GitHub."
echo "${CYAN}O link será algo como: https://github.com/seuusuario/seurepositorio.git"
echo "${WHITE}"
read NOMEGIT

# Solicitar o nome da pasta do projeto
echo "${CYAN}Digite o nome da pasta onde seu bot está localizado (exemplo: PastaDoBot)."
echo "${CYAN}Caso o nome da pasta seja com maiúsculas, digite corretamente como está."
echo "${WHITE}"
read NOMEDAPASTA

# Processo de inicialização do Git
echo "${CYAN}Iniciando o processo de configuração do repositório Git..."
echo "${CYAN}Agora vamos configurar o Git e adicionar seu repositório remoto."
echo "${CYAN}Pressione Enter para continuar."
read next

clear

# Inicializar o repositório Git
rm -rf .git
git init

# Configurar as informações de usuário
git config --global user.name "$GITHUB_USER"
git config --global user.email "$GITHUB_EMAIL"

# Definir a pasta segura
git config --global --add safe.directory "/storage/emulated/0/$NOMEDAPASTA"

# Adicionar arquivos ao repositório
git add .
git commit -m "Primeiro commit do projeto"
git branch -M main

clear

# Adicionar o repositório remoto
echo "${CYAN}Adicionando o repositório remoto GitHub..."
git remote add origin "$NOMEGIT"

echo "${CYAN}Pronto para fazer o Push para o seu repositório!"
echo "${CYAN}No próximo passo, você será solicitado a inserir seu nome de usuário e o Token como senha."

echo ""
echo "${CYAN}IMPORTANTE: Quando o Git pedir o 'Username' e o 'Password', use os seguintes:"
echo "${CYAN}1. Para o 'Username', insira o nome de usuário do GitHub que você forneceu."
echo "${CYAN}2. Para o 'Password', cole o Token de acesso que você gerou no GitHub."
echo "${WHITE}"

echo "${CYAN}Pressione Enter para continuar."
read next

# Solução de problemas com proxy (se necessário)
git config --global --unset https.proxy
git config --global --unset http.proxy

# Realizar o Push para o GitHub
echo "${CYAN}Enviando os arquivos para o seu repositório no GitHub..."
git push -u origin main

# Confirmação de sucesso
echo "${GREEN}Upload Concluído com Sucesso!"
echo "${CYAN}Seu projeto foi enviado para o GitHub com sucesso!"
echo ""
echo "${CYAN}Pressione Enter para finalizar."
read next

echo "${YELLOW}================================================================================"
echo "${YELLOW}         Agora você pode acessar seu repositório no GitHub e ver os arquivos."
echo "${YELLOW}       Caso tenha algum erro, confira as mensagens acima e siga as instruções."
echo "${YELLOW}================================================================================"