# Odysseus → CLONE FRAME — guia de adaptação

> O Odysseus (AGPL, clonado em `~/odysseus`) é só **referência de código**. Nada dele é embebido.
> Reconstruímos 4 capacidades nativamente no CLONE FRAME, adaptadas à stack do projeto
> (frames HTML/JS · agente = NFT na Base · neural_soul · Virtuals · privacidade).

Referências apontam para `~/odysseus/<ficheiro>:<linha>`.

---

## 1. Skills dentro da plataforma → **SKILL FRAME**

**Como o Odysseus faz**
- Formato `SKILL.md`: frontmatter YAML (`name, description, category, tags, when_to_use, requires_toolsets, owner, version, status`) + corpo estruturado (When to Use / Procedure / Pitfalls / Verification). — `services/memory/skills.py`, `services/memory/skill_format.py`
- Contadores de uso em sidecar `_usage.json` (não suja o SKILL.md).
- **Injeção no prompt** (divulgação progressiva): o *índice* de skills (nome + when_to_use) está sempre no prompt; os **3 mais relevantes** à última mensagem são injetados na íntegra, com `trusted=False` para bloquear prompt-injection. — `src/agent_loop.py:1204` (e `:417` para a tool).
- Tool `manage_skills` (`list|view|search|add|edit|publish|delete`) — o agente consulta skills ANTES de fazer trabalho de domínio.

**Adaptação CLONE FRAME**
- Manter o formato `SKILL.md` **tal e qual** (portável e legível por humanos e agentes).
- Tornar a skill um **artefacto possuível**: conteúdo `SKILL.md` → IPFS/Arweave (CID); a *listagem/venda* é on-chain. Royalty de **1% na 1ª venda** via o splitter (ver arquitetura).
- Portar o motor de parsing + injeção (índice + top-3 semântico + `trusted=False`) para o runtime do agente iCLONE: prompt = `neural_soul.md` + índice de skills + top-3.
- Estender a tool para o marketplace: `manage_skills` + `buy` / `equip` (on-chain).
- **Reutilização direta:** lógica Python do `SkillsManager` (parse, índice, injeção). **Novo:** camada de listagem/venda Web3.

---

## 2. Email + resposta por IA (o "agradável")

**Como o Odysseus faz**
- Poller IMAP/SMTP + triage/tags/resumos. — `src/email_pollers.py`, `routes/email_routes.py`
- `POST /ai-reply` gera rascunho **no estilo de escrita do utilizador**, com cache por `message_id` (tabela `email_ai_replies`), `user_hint` para orientar, e "style mechanics". — `routes/email_routes.py:2742`
- Tarefa agendada `draft_email_replies` (cron) + fluxo **human-in-the-loop**: agente rascunha → utilizador aprova/cancela. — `src/task_scheduler.py:241`, `routes/email_routes.py:2169` (pending drafts / approve / cancel)

**Adaptação CLONE FRAME**
- Tornar isto uma **skill equipável** ("Email agent") que um agente-NFT adquire no SKILL FRAME.
- Credenciais IMAP/SMTP vêm do **cofre por-agente** (ERC-6551 + secret store Fernet), não de config global.
- "Estilo do utilizador" → derivado do `neural_soul.md` do agente.
- **Privacidade:** o modelo que redige corre **local ou Venice** (ver §4) — o conteúdo do email nunca toca cloud centralizada.
- **Reutilização direta:** draft + cache + style-mechanics + fluxo aprovar/cancelar. **Trocar:** fonte de credenciais (→ cofre do agente) e endpoint do modelo (→ privado).

---

## 3. Painéis soltos → arrastar para o lado → split-screen com tabs

**Como o Odysseus faz** (frontend puro, sem framework — portável tal e qual)
- `Modals` (registry de janelas): `register / unregister / minimize / restore / toggle / close / isRegistered / isMinimized / injectMinimizeButton`. — `static/app.js`
- Snap-dock à borda: arrastar até ≤60px da borda (`SNAP_PX=60`) → encaixa em meio-ecrã redimensionável; arrastar 80px para fora (`UNSNAP_PX=80`) → volta a flutuar centrado. Largura do dock persiste em `localStorage` (`odysseus-edge-dock-width:<lado>:<id>`). Hint visual (zona tracejada) durante o drag. Modo "email+doc split". — `static/js/modalSnap.js`
- Janelas minimizadas viram **chips no dock = tabs**; restauram ao clicar/hover. Focus-trap (Tab). — `static/js/ui.js`, CSS em `static/style.css`

**Adaptação CLONE FRAME**
- Portar os 3 ficheiros (`app.js` Modals, `modalSnap.js`, `ui.js`) + CSS relevante — é vanilla JS, encaixa direto nos `.widget`/HTML dos frames.
- Cada "tabela solta" = um Modal (`Modals.register`). Arrastar para a borda → split redimensionável; minimizar → chip/tab.
- **Twist nativo:** persistir o layout das janelas **por wallet/agente** (cada utilizador retoma o seu workspace). O "ecrã principal dividido em tabs" = painéis encaixados + barra de chips.
- **Menor esforço, maior impacto visual** — já é framework-free.

---

## 4. Correr localmente / privacidade → alinhado com Venice + blockchain

**Como o Odysseus faz**
- Camada de modelos **agnóstica, OpenAI-compatible**: LM Studio, llama.cpp, vLLM, Ollama, qualquer base custom. — `src/endpoint_resolver.py:216`, `src/llm_core.py`
- `ModelEndpoint` em DB: base_url + chave + modelos. Serving local via Cookbook (GPU da própria máquina).

**Adaptação CLONE FRAME**
- Adicionar **Venice** como endpoint (`https://api.venice.ai/api/v1`, OpenAI-compatible, no-logging) e/ou **local** (Ollama/Cookbook) — os dados ficam na máquina do utilizador.
- **Política de modelo por agente** guardada com o NFT: flag `privacy_mode` que restringe inferência a *local/Venice only*.
- Narrativa de produto: agente (NFT) + inferência privada (Venice/local) + posse on-chain = soberania ponta-a-ponta — exatamente o que o CLONE FRAME propõe.
- **Reutilização direta:** routing OpenAI-compatible do `endpoint_resolver`. **Novo:** flag de privacidade ligada ao agente.

---

## Ordem de implementação sugerida

1. **Windowing** (§3) — frontend puro, payoff visual imediato, sem backend.
2. **Skills runtime** (§1) — parsing + injeção (motor do agente). Venda on-chain depois.
3. **Privacidade/modelos** (§4) — endpoint Venice + local + flag por agente.
4. **Email skill** (§2) — junta cofre + skill + modelo privado (integra §1, §4).
