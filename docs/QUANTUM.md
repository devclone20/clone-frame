# Quantum Computer Update Protocol

> Manter os iNFTs seguros contra computadores quânticos — completando a migração
> pós-quântica **antes** de a janela de risco abrir, não depois.
> Versão completa no whitepaper: [cloneframe.io](https://cloneframe.io) → Whitepapers → Quantum Update Protocol.

## O problema, com honestidade

As blockchains de hoje assinam com criptografia de curva elíptica (ECDSA em secp256k1).
Um computador quântico suficientemente grande, a correr o algoritmo de Shor, poderia um dia
derivar uma chave privada a partir de uma chave pública exposta. **Essa máquina ainda não
existe** — os melhores sistemas de 2026 estão longe da escala necessária — mas a postura
honesta é preparar cedo: migrações levam anos, e dados assinados hoje podem ser
*colhidos agora para serem quebrados depois* (harvest now, decrypt later).

## Porquê 2029

Tratamos **2029 como prazo de prontidão, não como data de apocalipse.** Os roadmaps de
hardware (IBM, Quantinuum) apontam marcos de tolerância a falhas para 2029–2030, e a
investigação de 2025–2026 tem reduzido repetidamente o número de qubits necessários para
um ataque criptográfico. Nada disto significa que as blockchains quebram em 2029 — significa
que um projecto prudente deve estar **totalmente migrado antes** desse horizonte, em linha
com as orientações do NIST e da indústria.

## A base que adoptamos

Standards NIST finalizados em 2024. Para assinaturas — a parte que importa à posse de NFTs —
o standard primário é **ML-DSA (FIPS 204)**, com **SLH-DSA (FIPS 205)** como backup
conservador baseado em hash. Adoptamos standards; não inventamos criptografia própria.

## Como implementamos — quatro movimentos, application-first

1. **Crypto-agility por design** — posse e acções do agente passam por autenticação de
   smart-account (account abstraction), para que o esquema de assinatura seja actualizável
   como módulo — sem migração de tokens.
2. **Assinaturas híbridas** — ECDSA + ML-DSA em conjunto durante a transição: a segurança
   mantém-se enquanto uma das pernas se mantiver. A perna clássica cai quando houver
   confiança pós-quântica estabelecida.
3. **Rotação de chaves por hash-commit** — publicar hoje um compromisso (hash) da futura
   chave pós-quântica de cada owner; revelar e activar mais tarde. Guardians de social
   recovery rodáveis para chaves PQC sem mudar o endereço.
4. **Integridade já segura** — arte e alma seladas na Irys são endereçadas por hash; funções
   de hash não são quebradas pelo algoritmo de Shor — a camada de metadata não precisa de
   migração.

## O que controlamos, o que herdamos

A **camada de aplicação** (como um agente se autentica, como uma chave roda, como a posse
se prova) é nossa — e será quantum-ready. A **camada de protocolo** (assinaturas de consenso
de Ethereum/Base) não é nossa; aí seguimos o roadmap pós-quântico da Ethereum Foundation e
adoptamos as suas actualizações. O Quantum Update Protocol é o compromisso de fechar a nossa
metade desse fosso primeiro, e de manter a crypto-agility como propriedade permanente de
cada iNFT.
