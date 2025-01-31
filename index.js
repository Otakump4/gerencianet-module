const Gerencianet = require('gn-api-sdk-node')

class GerencianetPayment {
constructor() {
console.log('[INFO] Inicializando SDK da Gerencianet...')
this.gn = new Gerencianet({
client_id: 'SEU_CLIENTE_ID',
client_secret: 'SEU_CLIENTE_SECRET',
sandbox: true,// Defina como "true" para o ambiente de testes (sandbox)
})
console.log('[SUCESSO] SDK inicializado.')
}

/**
 * Método para criar um pagamento PIX
 * @param {number} value - Valor do pagamento em centavos (ex: 100 = R$ 1,00)
 * @returns {object|null} Dados do pagamento (QR Code, link) ou null em caso de erro
 */
async createPixPayment(value) {
console.log('[INFO] Iniciando criação de pagamento PIX...')
const body = {
calendario: {
expiracao: 900 // Tempo de expiração do QR Code em segundos (15 minutos)
},
valor: {
original: (value / 100).toFixed(2)
},
chave: '214d1eb8-2669-407b-872b-378fcd66a2f5',
solicitacaoPagador: 'Pagamento via PIX'
}
try {
const response = await this.gn.createCharge({}, body)
console.log('[SUCESSO] Cobrança PIX criada:', {
txid: response.txid,
status: response.status
})
console.log('[INFO] Gerando QR Code...')
const qrCodeResponse = await this.gn.generateQRCode({ locId: response.loc.id })
console.log('[SUCESSO] QR Code gerado com sucesso.')
return {
txid: response.txid,
qr_code: qrCodeResponse.qrcode,
qr_code_base64: qrCodeResponse.imagemQrcode
}
} catch (error) {
console.error('[ERRO] Falha ao criar pagamento PIX:', error.message)
console.error('[DEBUG] Detalhes do erro:', error.response ? error.response.data : error)
return null
}
}

/**
 * Método para verificar o status de um pagamento PIX
 * @param {string} txid - ID da cobrança PIX a ser verificada
 * @returns {string|null} Status do pagamento ou null em caso de erro
 */
async checkPayment(txid) {
console.log('[INFO] Verificando status do pagamento PIX para TXID:', txid)
try {
const response = await this.gn.detailCharge({ txid })
console.log('[SUCESSO] Status do pagamento:', {
txid: txid,
status: response.status
})
return response.status
} catch (error) {
console.error('[ERRO] Falha ao verificar pagamento PIX:', error.message)
console.error('[DEBUG] Detalhes do erro:', error.response ? error.response.data : error)
return null
}
}
}

module.exports = { GerencianetPayment }
