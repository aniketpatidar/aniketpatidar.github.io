---
layout: post
title: "Understanding Tokenization in LLMs"
date: 2026-09-04 13:30:00 +0530
categories: ai machine-learning
---

Tokenization is the process of breaking down text into smaller units called tokens so a computer can process it more easily. In natural language processing, tokens are usually words, subwords, or even characters, depending on the tokenizer rules.

For example, the sentence "I love coding!" might be broken down into tokens like: `["I", "love", "coding", "!"]`. More advanced tokenizers, such as those used in GPT models, split words into smaller parts to manage rare or unknown words. For instance, "unbelievable" could be tokenized as `["un", "believ", "able"]`.

Under the hood, tokenization is essentially a process that converts raw text into numeric IDs that the model can understand. For modern LLMs, this is usually done in four main steps:

1. **Preprocessing the raw text**
   Convert the text into a normalized form (such as lowercase in some cases, normalize unicode, remove extra spaces, etc.) Some models keep casing and punctuation because they are important for meaning.

2. **Splitting into candidate tokens**
   Traditional tokenizers split by whitespace or punctuation. Modern ones (like GPT) use a Byte Pair Encoding (BPE) or similar algorithm, which starts by treating text as individual characters (or even bytes), then merges the most frequent pairs into larger chunks. This creates a set of subwords that balance vocabulary size and the ability to handle rare words.
   Example with BPE: "lower" → `["l", "o", "w", "er"]` → `["low", "er"]` → eventually becomes a known token.

3. **Lookup in the vocabulary**
   Each token (subword, punctuation, space, etc.) has an integer ID in the model’s vocabulary. The tokenizer replaces each token with its ID: `["I", "love", "coding", "!"]` → `[42, 315, 9801, 0]`.

4. **Feeding IDs to the model**
   The model doesn’t see words—it only sees these integer IDs. The IDs are turned into embeddings (vectors of numbers) before being fed into the neural network.

In short: Text → Preprocess → Split into tokens → Map to IDs → Model input. The reverse process (IDs → tokens → text) is called detokenization.
