# CLONE FRAME — blueprint de construção (clean-room)

> **Abordagem:** estudamos o Odysseus só para extrair a *técnica* (algoritmos, fluxos, parâmetros).
> Reimplementamos de raiz na nossa stack. Não copiamos código → sem obrigação AGPL.
> Cada secção: **como funciona** (ideia destilada) → **como construímos** → **parâmetros-chave**.

Referências de estudo: `~/odysseus/<ficheiro>:<linha>` (só leitura, para perceber).

---

## 1. Workspace shell — painéis soltos → snap/split → tabs

**Como funciona** (estudo: `static/app.js` Modals, `static/js/modalSnap.js`, `static/js/ui.js`)
- Um *registry* de janelas com API mínima: `register / unregister / minimize / restore / toggle / close / isMinimized`.
- Cada janela é arrastável. Máquina de estados de docking por distância à borda:
  - arrastar até **≤60px** de uma borda lateral → encaixa em meio-ecrã (split) redimensionável;
  - arrastar **>80px** para dentro → desencaixa e volta a flutuar centrado.
- Durante o drag mostra-se um *hint* (faixa tracejada na borda alvo).
- Largura do dock é redimensionável (handle) e **persiste em `localStorage`** por `lado:id`; mínimo ~320px (280 mobile).
- Janela minimizada vira **chip** numa barra de dock = a nossa "tab"; restaura ao clicar/hover.

**Como construímos**
- `WindowManager` em JS puro (sem framework): cada "tabela solta" do frame regista-se. Estado por janela: `{id, x, y, w, h, dock: null|'left'|'right', minimized}`.
- Drag com `pointer events`; ao soltar, calcular distância às bordas e aplicar a regra 60/80.
- Split = CSS grid/flex de 2 colunas (dock + main); handle de resize escreve a largura em `localStorage`.
- Barra de chips para minimizadas. **Twist nativo:** guardar o layout por **wallet/agente** (não só localStorage) → o utilizador retoma o seu workspace em qualquer dispositivo.
- O agente pode abrir/arranjar painéis (ver §2, `ui_control`).

**Parâmetros-chave:** snap 60px · unsnap 80px · min dock 320/280px · persistência por `lado:id` (+ por wallet).

---

## 2. Núcleo do agente iClone

### 2a. Loop do agente (estudo: `src/agent_loop.py`)
**Como funciona** — loop multi-ronda, *dual-mode* de tools:
- Cada ronda: montar prompt → chamar modelo → extrair ações → executar → devolver resultados ao histórico → repetir.
- O parser aceita **duas formas** no mesmo fluxo: `tool_calls` nativos (modelos API) **e** blocos ```` ```bash/```python/```json ```` (modelos locais sem function-calling). Isto é o que dá portabilidade total (API + local).
- Sem timer rígido: o **modelo declara** o fim (escreve resposta final sem chamar tools), ou BLOCKED, ou continua. Mensagens de resultado são reanexadas como turnos `tool`/`assistant` (com cuidado: alguns backends rejeitam `tool_calls` em mensagens — normalizar).

**Como construímos** — função `runAgentTurn(messages, tools, model)`:
1. monta prompt (system = neural_soul + índice skills + memória relevante; ver §2c/§3);
2. chama o modelo (router §2d);
3. `resolveActions(resposta)` → normaliza nativo OU fenced para uma lista uniforme `{name, args, id}`;
4. executa cada ação (§2b), recolhe resultados;
5. reanexa ao histórico; volta a 2 até "done/blocked".
- Guardar cada execução (`agent_runs`) para auditoria e para o ACP (§5).

### 2b. Tools & MCP (estudo: `src/mcp_manager.py`, `src/tool_*`)
**Como funciona** — tools são funções com schema; MCP = servidores externos que expõem tools descobríveis; cada tool passa por *policy/security* antes de correr (allow/deny, sandbox, validação de args).
**Como construímos** — registo de tools com `{name, schema, run}`; cliente MCP para descobrir/ligar servidores OSS (a "descoberta OSS" do SKILL FRAME); **gate de segurança** obrigatório por tool (§6). Tool especial `ui_control` para o agente abrir painéis, trocar modelo/tema, abrir draft de email.

### 2c. Skills engine (estudo: `services/memory/skills.py`, `src/agent_loop.py:1204`)
**Como funciona**
- Skill = ficheiro `SKILL.md`: frontmatter (`name, description, category, tags, when_to_use, requires_toolsets, owner, version, status, confidence`) + corpo (When to Use / Procedure / Pitfalls / Verification). Contadores de uso em sidecar.
- **Divulgação progressiva:** o *índice* (nome + when_to_use) está sempre no prompt; só os **relevantes** são injetados na íntegra.
- **Seleção de relevância = Jaccard token-match** entre a última mensagem do utilizador e (name+description+when_to_use+procedure). `threshold≈0.25`, `max=3`. Gate de confiança separa rascunhos de publicados. Marca `trusted=false` → conteúdo de skill nunca injeta instruções de sistema.
**Como construímos** — `getRelevantSkills(lastUserMsg, skills)`: tokenizar, calcular Jaccard, filtrar ≥0.25, ordenar, top-3. Injetar como bloco não-confiável. **No CLONE FRAME:** conteúdo da skill em IPFS (CID); listagem/venda on-chain (1%); `equip` adiciona ao set do agente-NFT.
**Parâmetros-chave:** threshold 0.25 · max 3 · trusted=false · uso contado ao *surgir*.

### 2d. Router de modelos / privacidade (estudo: `src/endpoint_resolver.py`, `src/llm_core.py`)
**Como funciona** — camada agnóstica OpenAI-compatible; resolve endpoint por provider (Anthropic, OpenAI, Ollama, vLLM, LM Studio…); deteta capacidades.
**Como construímos** — `resolveEndpoint(agentModelPolicy)`; suportar **Venice** (`api.venice.ai/api/v1`) e **local** (Ollama/serving próprio). **Flag `privacy_mode` no NFT** → restringe a local/Venice. É a narrativa: posse on-chain + inferência privada.

---

## 3. Brains — memória & conhecimento (o pilar central)

**Como funciona** (estudo: `src/rag_manager.py`, `src/memory_vector.py`, `src/memory.py`, `src/deep_research.py`, `src/context_compactor.py`)
- **RAG:** `add_document(text, meta)` → chunk + embed + upsert no vector store (Chroma). `search(query, k=5)` → top-k por similaridade → injetar como contexto.
- **Memória semântica:** factos/preferências como entradas (`add_entry(text, source, category, owner)`); recuperação por `search(query, k=8)`. Distinta de RAG: memória = sobre o utilizador/agente; RAG = sobre documentos.
- **Deep research:** pesquisa web multi-passo → ler fontes → sintetizar relatório (`visual_report`).
- **Contexto:** quando a conversa cresce, `compactor` sumariza turnos antigos e `budget` controla tokens.
**Como construímos**
- Vector store próprio (Chroma/pgvector/Qdrant) + embeddings locais (ex.: `all-MiniLM`) para privacidade.
- Dois espaços separados: `memory` (utilizador/agente) e `rag` (documentos), cada um com `add` + `search(k)`.
- Pipeline de ingestão: documento → chunk (~500–1000 tokens, overlap) → embed → upsert com metadata (owner, source).
- No prompt: injetar top-k memória + top-k RAG relevantes + índice de skills (§2c).
- Compactação: ao exceder X tokens, sumarizar histórico antigo num bloco e preservar.
**No CLONE FRAME:** a memória é a **alma persistente do agente-NFT** — ponteiro on-chain (6551) + vetores off-chain privados. Embeddings locais = dados nunca saem da máquina.
**Parâmetros-chave:** RAG k=5 · memória k=8 · chunk c/ overlap · embeddings locais.

---

## 4. Apps como skills equipáveis

**Padrão geral:** cada "app" (email, docs, calendário, pesquisa, imagem, voz) é uma **skill equipável** que traz: (a) tools próprias, (b) credenciais do cofre do agente (§6), (c) opcionalmente um modelo privado.

**Exemplo trabalhado — Email IA** (estudo: `routes/email_routes.py:2742` `/ai-reply`, `src/task_scheduler.py` `draft_email_replies`)
- **Como funciona:** poller IMAP/SMTP; endpoint gera rascunho **no estilo do utilizador**, com cache por `message_id` e `user_hint` opcional; tarefa agendada rascunha em lote; fluxo **human-in-the-loop** (aprovar/cancelar antes de enviar).
- **Como construímos:** serviço IMAP/SMTP + `draftReply({original, hint, style})` → modelo privado → cache → fila de drafts pendentes que o utilizador aprova na UI. Estilo derivado do `neural_soul`. Nunca envia sem aprovação.
- **Outras apps seguem o mesmo molde:** Docs/editor (office/pdf + edição IA), Calendário/Tarefas (CalDAV + scheduler), Pesquisa/Compare (multi-fonte + teste lado-a-lado), Galeria/Imagem (gerador → SVG on-chain), Voz (STT/TTS).

---

## 5. Automação & jobs → ACP (Virtuals)

**Como funciona** (estudo: `src/task_scheduler.py`, `src/bg_jobs.py`, `src/agent_runs.py`, crew em `routes/assistant_routes.py`)
- Tarefas agendadas (cron) + jobs em background + "crew" (agentes/check-ins). Cada run é registado.
**Como construímos** — `scheduler` (cron) + fila de jobs + registo de runs. **Ligação CLONE FRAME:** cada job autónomo = um **ACP job na Virtuals** (o agente-NFT publica/executa/vende serviços). Webhooks para notificar estado.

---

## 6. Dados & segurança

**Como funciona** (estudo: `src/secret_storage.py`, `src/api_key_manager.py` Fernet, `src/prompt_security.py`, `src/tool_security.py`, `src/url_safety.py`)
- Segredos encriptados (Fernet) por provider/agente; chave de encriptação com permissões 0600.
- Guardas: sanitização de prompt (anti-injection), policy de tools, validação de URLs (anti-SSRF).
**Como construímos** — cofre encriptado por-agente (espelhado pelo 6551 para custódia on-chain). **Guardas obrigatórios** antes de qualquer tool/URL/conteúdo de skill (lembrar `trusted=false`). DB relacional + vector store.

---

## 7. Web3 on-chain (nativo — construir de raiz)

Não vem do Odysseus. Seams de integração com o motor:
- **Agente NFT** (ERC-721A + 2981 + 6551): o mint (iCLONE FRAME) cria a TBA que é o cofre (§6).
- **Arte SVG on-chain** determinística (a partir do gerador de imagem, §4).
- **Token Virtuals** (1B) + **ACP** (§5).
- **Registry + indexer** (PLAZA): indexa agentes/skills on-chain para o marketplace.
- **Royalty splitter** (5% iNFT / 1% skill) + **staking** (10k iCLONE para publicar).

---

## Ordem de construção

1. **Workspace shell** (§1) — JS puro, payoff visual imediato, sem backend.
2. **Núcleo do agente + Brains** (§2,§3) — o motor; tudo pendura aqui.
3. **1ª app equipável: Email IA** (§4) — prova skill + cofre + modelo privado.
4. **Automação/ACP** (§5) e **Web3** (§7) — monetização e posse.

Segurança (§6) é transversal — construída desde o primeiro commit, não no fim.
