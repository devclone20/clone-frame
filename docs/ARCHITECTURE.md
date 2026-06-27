# Arquitetura — CLONE FRAME

Dois níveis: **Frames** (produtos) e, dentro do CLONE FRAME, **superfícies** (Plaza Place + HUB).

## 1. Camadas — hospedado vs aberto

```mermaid
flowchart TB
  subgraph CF["CLONE FRAME — plataforma hospedada (Hostinger)"]
    direction LR
    PP["Plaza Place<br/>marketplace · iNFT collections + skills"]:::hosted
    HUB["HUB<br/>workstation · train + deploy + own"]:::hosted
  end
  LF["LAYER FRAME<br/>image-layer builder · open (GitHub + Venice)"]:::open
  IF["iIrys FRAME<br/>soul + art → Irys · open (GitHub + Venice)"]:::open
  INFRA["Shared infrastructure<br/>Base 8453 · Irys · Virtuals · Supabase"]:::ext
  CF --> INFRA
  LF --> INFRA
  IF --> INFRA
  classDef hosted fill:#0e3b2e,stroke:#34d399,color:#d1fae5;
  classDef open fill:#2b2660,stroke:#8b7fe8,color:#e0dcff;
  classDef ext fill:#262626,stroke:#888888,color:#dddddd;
```

- **Hosted (Hostinger):** Plaza Place + HUB. BYOK.
- **Open (GitHub + Venice):** LAYER FRAME + iIrys FRAME — open-source, grátis.

## 2. Fluxo ponta-a-ponta — criar → selar → cunhar → publicar

```mermaid
flowchart TB
  U["User · wallet<br/>SIWE / Privy"]:::neutral
  LF["LAYER FRAME<br/>split · traits · ZIP"]:::open
  IF["iIrys FRAME<br/>Engine · soul · meta"]:::open
  IRYS["Irys L1 datachain<br/>permanent · tokenURI"]:::ext
  PP["Plaza Place<br/>list + mint"]:::hosted
  HUB["HUB<br/>train · deploy · own"]:::hosted
  BASE["Base 8453 · ICloneAgent<br/>approve + mint on-chain"]:::chain
  INFT["iNFT<br/>NFT + AI agent · self-custody"]:::chain
  CF["CLONE FRAME<br/>Plaza marketplace"]:::hosted
  OS["OpenSea<br/>external market"]:::ext
  U --> LF
  U --> IF
  LF --> IF
  IF -->|seal| IRYS
  IRYS -->|tokenURI| PP
  PP --> HUB
  PP -->|mint| BASE
  BASE --> INFT
  INFT -->|publish| CF
  INFT -->|publish| OS
  classDef hosted fill:#0e3b2e,stroke:#34d399,color:#d1fae5;
  classDef open fill:#2b2660,stroke:#8b7fe8,color:#e0dcff;
  classDef chain fill:#3a2218,stroke:#e08a5a,color:#fde4d3;
  classDef ext fill:#262626,stroke:#888888,color:#dddddd;
  classDef neutral fill:#1a1a1a,stroke:#aaaaaa,color:#eeeeee;
```

**Legenda:** Hosted (verde) · Open tools (roxo) · On-chain (coral) · Data · external (cinza).

## 3. Plaza Place (detalhe)

O marketplace tem duas secções:

- **iNFT collections** — agentes (iNFT) listados para compra / mint. Rarity tiers: `rare` · `superrare` · `iclone`.
- **Skills** — só se vendem **skills** aqui. Fluxo: compras a skill → fazes **deploy** dela ao teu agente iNFT (no HUB).

## 4. iNFT — contrato

- **iNFT = agente de IA + NFT integrado.** Self-custody: fica na carteira do utilizador.
- **ICloneAgent** (Base 8453): `ERC-721A` + `ERC-2981` (royalty 5%) + `ERC-6551` (token-bound account).
- `tokenURI` → Irys (arte + metadata permanentes; a alma `neural_soul.md` é injetada em `metadata.ai_soul`).
- **Mint:** o comprador/dev **aprova + cunha on-chain** com o contrato. Depois **publica** no Plaza (CLONE FRAME) e na OpenSea.

## 5. Infraestrutura

| Camada | Papel |
|--------|-------|
| **Base (8453)** | Chain dos iNFT — mint, royalties (ERC-2981), token-bound accounts (ERC-6551). |
| **Irys** | Datachain permanente — arte, metadata e `tokenURI`. |
| **Virtuals Protocol** | Ecossistema de agentes (ACP); construímos **dentro** dele. |
| **Supabase** | Dados de aplicação (ex.: drops gated). |
