# CLONE FRAME

> A plataforma onde criamos e desenvolvemos **dentro** da sociedade de agentes de IA da **Virtuals Protocol** (Base) — não a reinventamos, construímos sobre ela.

CLONE FRAME é o produto de interface da iCLONE: uma experiência simples e técnica para usar, cunhar, vender e operar **agentes de IA como NFTs** e as suas **skills**, governada pelo agente **iCLONE**.

## Frames

- **PLAZA FRAME** — marketplace: agentes (NFT) + skills.
- **iCLONE FRAME** — mint studio do agente (imagem + neural_soul.md + contrato).
- **SKILL FRAME** — ambiente de automação de skills + descoberta de ferramentas OSS.
- **Landing** — apresentação (a fazer).

Base partilhada em todos: menu retrátil, Wallet (Login/Online/Sign out), Settings.

## Estrutura

```
frames/                         widgets .widget dos frames (rascunhos de UI)
  PLAZA FRAME.widget
  SKILL FRAME.widget
  iCLONE FRAME.widget
  gerador de banco de nft imagem/
    BACKGROUND.widget           construtor de NFT (Background/Accessories/ID/Skill/iNFT)
    SILUETAS.widget
mockups/                        mockups HTML da plataforma
```

## NFT do agente (arquitetura)

- O NFT **é** o agente, a chave e o cofre: `ERC-721A` + `ERC-2981` (royalties) + `ERC-6551` (token-bound account com a wallet do agente). Base (8453).
- **Token do agente:** lançado **nativamente na Virtuals** (supply 1B, regras da Virtuals).
- Arte 100% on-chain (SVG determinístico). Rarity tiers: `rare` · `superrare` · `iclone`.

## Receita

- **iNFT:** 5% perpétuo sobre todas as vendas (on-chain).
- **Skills:** 1% na 1ª venda.
- **Ferramentas:** grátis.

## Token utility (iCLONE)

- Staking de **100k iCLONE** (lock 6 meses, cooldown 1 mês) para publicar coleções.
- Coleções prontas vendidas pela plataforma dispensam staking.

---

Construído sobre a Virtuals Protocol. Self-hosted.
