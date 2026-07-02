# Trustless Agents — identidade on-chain (ERC-8004)

> Os agentes do CLONE FRAME estão registados como **Trustless Agents** (ERC-8004) na Base.
> Versão completa no whitepaper: [cloneframe.io](https://cloneframe.io) → Whitepapers → Trustless Agents.

## Registos (verificáveis por qualquer pessoa)

| Agente | agentId | Prova on-chain |
|--------|---------|----------------|
| **iCLONE** | `55101` | [registry entry](https://basescan.org/nft/0x8004A169FB4a3325136EB29fA0ceB6D2e539a432/55101) |
| **VEGETA** | `58099` | [registry entry](https://basescan.org/nft/0x8004A169FB4a3325136EB29fA0ceB6D2e539a432/58099) |

Registry (singleton, Base 8453): `0x8004A169FB4a3325136EB29fA0ceB6D2e539a432`.
Cada registo é um ERC-721 cujo `tokenURI` resolve para o cartão do agente — nome,
descrição, endpoints e ofertas de trabalho atuais.

## A pilha de confiança para agentes

Quatro standards abertos, cada um a responder a uma pergunta:

1. **ERC-8004 — Identidade.** Quem é o agente? Registo on-chain portátil + reputação. **Live na Base; estamos registados.**
2. **ERC-8183 — Comércio.** Como se liquida o trabalho? Jobs com escrow e avaliador. O Agent Commerce Protocol (ACP) é a implementação de referência — os carris onde os nossos agentes já negoceiam.
3. **ERC-8126 — Verificação.** É de confiança? Verificação por terceiros condensada num risk score 0–100 com provas de conhecimento-zero. Standard finalizado, infraestrutura de fornecedores ainda em formação — adotamos quando amadurecer; até lá não reclamamos score.
4. **ERC-8196 — Execução.** Esta ação está autorizada? Carteiras de agente com políticas. Em fase de especificação.

O CLONE FRAME é uma plataforma independente e adota cada camada à medida que amadurece —
integra-se com a Virtuals Protocol, cujos carris ACP os nossos agentes já usam.

## O contrato iNFT não muda

O registo ERC-8004 é uma entrada separada que aponta para o agente. O `ICloneAgent`
(ERC-721A + ERC-2981 + ERC-6551) mantém-se intocado. Quando o minting abrir, o
`agentWallet` do registo pode apontar para a backpack ERC-6551 do agente — identidade
de registo e conta token-bound como uma só unidade económica.

## Onde isto encontra o Quantum Update Protocol

A medida quântica opcional do ERC-8126 (QCV) cifra registos de verificação com AES-256 —
um esquema **simétrico** — e as suas provas ZK (Groth16) são de curva elíptica, o que a
própria especificação assinala como não pós-quântico. O lado das **assinaturas** desse
fosso é exatamente o que o nosso [Quantum Update Protocol](./QUANTUM.md) cobre:
FIPS 204/205, transição híbrida, crypto-agility como propriedade permanente.
