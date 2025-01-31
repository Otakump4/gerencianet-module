
# 🏦 Módulo de Integração com a API do Gerencianet

Este é um módulo desenvolvido para facilitar a integração com a API oficial do **Gerencianet**, permitindo a criação, consulta e gerenciamento de pagamentos via **Pix** de forma simples e eficiente. Ideal para bots, sistemas de e-commerce ou qualquer aplicação que utilize pagamentos instantâneos.

---

## 📋 Funcionalidades

- **Criação de pagamentos via Pix**  
- **Verificação de status de pagamentos**  
- **Gestão eficiente com logs para acompanhamento**  

---

## 🚀 Instalação

1. Clone o repositório:
```bash
git clone https://github.com/Otakump4/gerencianet-module.git
```

2. Acesse o diretório do projeto:
```bash
cd gerencianet-module
```

3. Instale as dependências necessárias:
```bash
npm install
```

---

## ⚙️ Configuração

Para utilizar o módulo, você precisa das **credenciais da API do Gerencianet**. Obtenha-as na [página de credenciais](https://dev.gerencianet.com.br/docs).

Edite o código ou passe as credenciais diretamente no construtor:

```javascript
const { GerencianetPayment } = require('./GerencianetPayment')

// Configurando a API com suas credenciais
const gerencianet = new GerencianetPayment({
  client_id: 'seu_client_id', // Substitua pelo seu client_id
  client_secret: 'seu_client_secret', // Substitua pelo seu client_secret
  sandbox: true, // 'true' para testes, 'false' para produção
})
```

---

## 📖 Exemplos de Uso

### Criar um Pagamento via Pix
```javascript
(async () => {
  const payment = await gerencianet.createPixPayment(100) // Valor em centavos (ex: 100 = R$ 1,00)
  if (payment) {
    console.log('QR Code:', payment.qr_code)
    console.log('QR Code (Base64):', payment.qr_code_base64)
    console.log('Link de Pagamento:', payment.payment_url)
  } else {
    console.log('Erro ao criar o pagamento.')
  }
})()
```

### Consultar Status de Pagamento
```javascript
(async () => {
  const status = await gerencianet.checkPayment('id_do_pagamento') // Substitua pelo ID do pagamento
  console.log('Status do pagamento:', status)
})()
```

---

## 🛠️ Tecnologias Utilizadas

- **Node.js**
- **Gerencianet API**
- **Módulos auxiliares: `gn-api-sdk-node`**

---

## 📜 Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.

---

## 📞 Suporte

Caso tenha dúvidas ou precise de ajuda, entre em contato com o desenvolvedor:  
**Email:** lucasmoddomina@gmail.com  
**GitHub:** [Otakump4](https://github.com/Otakump4)

---

## 🌟 Contribua

Contribuições são bem-vindas! Sinta-se à vontade para abrir um pull request ou reportar problemas na aba de issues.

---

Com este módulo, fica simples e eficiente integrar pagamentos via Gerencianet em suas aplicações!

# Introdução ao GerencianetPayment

O **GerencianetPayment** é um módulo desenvolvido para facilitar a integração do seu bot ou sistema com a API da **Gerencianet**, permitindo gerar pagamentos via **PIX** de forma automática.

Com este módulo, você poderá criar cobranças PIX, obter QR Codes para pagamento, verificar o status de pagamentos e muito mais. Isso é útil para bots que aceitam doações, sistemas de venda automatizados, entre outras aplicações.

---

## 1️⃣ O que é a Gerencianet?

A **Gerencianet** é uma plataforma de pagamentos brasileira que oferece soluções para cobranças via **Boleto, Cartão e PIX**.

Através da API da Gerencianet, é possível criar cobranças de maneira automática, facilitando a gestão de pagamentos e transações.

Você pode utilizar o módulo **GerencianetPayment** para integrar a API ao seu bot de forma simples e eficiente.

> 💡 **Benefícios de usar a Gerencianet:**
> ✅ Sem necessidade de intermediários, pagamentos diretos via PIX.
> ✅ Pagamentos rápidos e seguros.
> ✅ API gratuita para cobranças via PIX.

---

## 2️⃣ Criando uma Conta na Gerencianet

Para usar o **GerencianetPayment**, primeiro você precisa criar uma conta na **Gerencianet**.

### **Passo 1: Criar uma conta**
1. Acesse o site da **[Gerencianet](https://gerencianet.com.br/)**.
2. Clique em **Criar Conta**.
3. Escolha o tipo de conta (pessoal ou empresa).
4. Complete o cadastro com seus dados.
5. Confirme o e-mail e finalize o registro.

### **Passo 2: Criar uma Aplicação**
1. Após criar a conta, acesse o **Painel da Gerencianet**.
2. Vá até **Minha Conta > API**.
3. Clique em **Criar Nova Aplicação**.
4. Dê um nome para a aplicação (exemplo: `BotPagamentos`).
5. Após criar, copie os dados de **Client ID** e **Client Secret**.

🔹 **Dica**: Use a opção **modo sandbox** para testes antes de ativar pagamentos reais.

---

## 3️⃣ Configurando o GerencianetPayment

Agora que você tem uma conta, vamos configurar o módulo **GerencianetPayment** para o seu bot.

### **Passo 1: Instalar as Dependências**

Instale o SDK da Gerencianet no seu projeto:

```bash
npm install gn-api-sdk-node
```

---

### **Passo 2: Criar o Arquivo `gerencianet.js`**

Crie um arquivo chamado **`gerencianet.js`** e cole o seguinte código:

```javascript
const Gerencianet = require('gn-api-sdk-node')

const gerencianet = new Gerencianet({
client_id: 'SEU_CLIENT_ID',
client_secret: 'SEU_CLIENT_SECRET',
sandbox: true,
})
class GerencianetPayment {
async createPixPayment(value) {
const params = {
value: value,
expire_at: new Date(Date.now() + 15 * 60 * 1000).toISOString(),
}
try {
const charge = await gerencianet.createCharge({}, params)
return {
id: charge.data.id,
qr_code: charge.data.qr_code,
qr_code_base64: charge.data.qr_code_base64,
payment_url: charge.data.link,
}
} catch (error) {
return null
}
}
async checkPayment(paymentId) {
try {
const paymentStatus = await gerencianet.queryCharge({ id: paymentId })
return paymentStatus.data.status
} catch (error) {
return null
}
}
}

module.exports = { GerencianetPayment }
```

---

## 4️⃣ Como Integrar no Seu Bot?

Agora que temos o módulo pronto, podemos usá-lo no nosso bot para processar pagamentos.

### **Exemplo de Uso no Bot**
```javascript
const { GerencianetPayment } = require('./gerencianet')

case 'doar': 
let nmr = Number(q)
if (!nmr || nmr <= 0) {
return reply("Valor inválido. Insira um número maior que 0.")
}
let pagamento = new GerencianetPayment()
try {//By: 𖧄 𝐋𝐔𝐂𝐀𝐒 𝐌𝐎𝐃 𝐃𝐎𝐌𝐈𝐍𝐀 𖧄
//Canal: https://whatsapp.com/channel/0029Va6riekH5JLwLUFI7P2B
let inf = await pagamento.createPixPayment(nmr * 100)
if (!inf || !inf.qr_code_base64 || !inf.payment_url) {
throw new Error("Erro ao gerar pagamento PIX.")
}
reply("Gerando pagamento, aguarde...")
sendRouletteButton(sender, { image: Buffer.from(inf.qr_code_base64, "base64"), caption: `QR Code de pagamento acima.`, footer: NomeDoBot }, zerotwo, sender, [{type: `copy_text`, text: `CLIQUE AQUI PARA COPIAR 📑`, url: inf.payment_url}], selolucas)
let check = await pagamento.checkPayment(inf.id)
let attempts = 0
while (check === 'pending' && attempts < 20) {
await sleep(30000)
check = await pagamento.checkPayment(inf.id)
attempts++
}
if (check === "approved") {
return mention(`Obrigado pelo PIX de R$ ${(nmr).toFixed(2)} @${sender.split("@")[0]}!`)
}
reply("Pagamento expirado ou não confirmado a tempo.")
} catch (e) {
reply("Erro no sistema, tente novamente mais tarde.")
}
break
```

---

## 5️⃣ Conclusão

Agora seu bot pode gerar cobranças **PIX automáticas** utilizando a API da **Gerencianet**.

**🚀 Benefícios da Integração:**
✔️ Pagamentos rápidos e diretos via PIX.
✔️ Automação total, sem intervenção manual.
✔️ Possibilidade de monetizar seu bot.

Caso tenha dúvidas, entre no suporte da **Gerencianet** ou consulte a documentação oficial.

> **💡 DICA:** Faça testes no modo `sandbox` antes de ativar os pagamentos reais!

Agora você está pronto para integrar pagamentos PIX no seu bot! 🎉


By © 2025 @lucas_mod_domina
