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
frames/                         pasta isolada — só os frames (rascunhos de UI .widget)
  LANDING.widget                página de apresentação do projeto
  PLAZA FRAME.widget            marketplace
  SKILL FRAME.widget            skills
  iCLONE FRAME/                 criar agente com NFT integrado
    iCLONE FRAME.widget
    iNFT Configuration/         (dentro do iCLONE FRAME)
      BACKGROUND.widget         construtor de iNFT (Background/Image/ID/Skill/iNFT)
      SILUETAS.widget
mockups/                        mockups HTML da plataforma
```

## NFT do agente (arquitetura)

- O NFT **é** o agente, a chave e o cofre: `ERC-721A` + `ERC-2981` (royalties) + `ERC-6551` (token-bound account com a wallet do agente). Base (8453).
- **Token do agente:** lançado **nativamente na Virtuals** (supply 1B, regras da Virtuals).
- Arte 100% on-chain (SVG determinístico). Rarity tiers: `rare` · `superrare` · `iclone`.

## Receita (como a CLONE FRAME ganha)

- **iNFT:** 5% perpétuo sobre todas as vendas (on-chain).
- **Skills:** 1% na 1ª venda.
- **Ferramentas:** grátis.

## Economia do projeto (alocação de receita, on-chain)

De **toda a receita** que a CLONE FRAME ganha, **30%** compõe três reservas on-chain — o restante financia o desenvolvimento. Economia segura por desenho, auditável e reportada periodicamente.

- **10% → BTC:** compra + reserva em staking (fundo de garantia do token e do projeto).
- **10% → VIRTUALS:** reserva em staking (liquidez e tesouraria).
- **10% → iCLONE:** buyback & burn (queima).

## Token utility (iCLONE)

- Staking de **10k iCLONE** (lock 6 meses, cooldown 1 mês) para publicar coleções.
- Coleções prontas vendidas pela plataforma dispensam staking.

---

Construído sobre a Virtuals Protocol. Self-hosted.
