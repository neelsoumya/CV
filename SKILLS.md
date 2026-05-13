---
name: academic-grant-writer
description: Transform Markdown notes (ideas, outlines, meeting notes, etc.) into a polished academic grant proposal in LaTeX with a corresponding BibTeX file.
version: 1.0
---

# Skill: Academic Grant Writing from Notes

## Purpose

Transform one or more Markdown inputs containing ideas, outlines, meeting notes, rough drafts, and reference fragments into a polished academic grant proposal written in LaTeX, with a matching BibTeX file.

## Input Format

The input directory may contain any of the following Markdown files:

- `ideas.md`
- `outline.md`
- `meeting-notes.md`
- `references.md`
- `draft.md`
- other `.md` files containing relevant project material

These files may be incomplete, repetitive, messy, or contradictory. Your job is to synthesize them into a coherent grant application.

## Output Format

Produce:

- `grant.tex` — the main LaTeX document
- `references.bib` — BibTeX entries for all cited sources

The main output should be a clean, compile-ready LaTeX manuscript.

## Core Task

Use the Markdown notes to draft a grant proposal with the following qualities:

- clear research vision
- strong motivation and significance
- feasible work plan
- well-structured methodology
- explicit expected outcomes and impact
- academically polished language
- consistent terminology throughout

## Preferred Grant Structure

Unless the user specifies otherwise, use this structure:

1. Title  
2. Abstract  
3. Background and Motivation  
4. Research Questions / Aims  
5. Methodology / Work Packages  
6. Expected Contributions / Impact  
7. Ethics and responsible research innovation (RRI) - this section will contain additional questions to collect information about specific ethical considerations relating to research involving animals, human participants and genetically modified organisms, project partners and facility access requests. 
8. Timeline  
9. Risks and Mitigation  
10. References  

If the notes suggest a different funding format, adapt accordingly.

## Writing Rules

- Preserve the user’s intent and domain-specific terminology.
- Turn fragments into full academic prose.
- Do not invent claims, results, or citations.
- Flag uncertainty where the notes are ambiguous.
- Prefer precise, formal, grant-style language.
- Remove redundancy and combine repeated ideas.
- Double-Check and verify references and ensure thay they exist
- Keep the proposal internally consistent.
- Make the narrative persuasive but not overstated.

## Citation Rules

- Any factual claim that depends on external literature should be supported by a BibTeX entry.
- If a reference is mentioned in the notes but incomplete, do one of:
  - infer the likely citation only if highly confident, or
  - mark it clearly as `TODO` in the BibTeX file.
- Never fabricate publication details.
- Ensure every in-text citation key used in `grant.tex` exists in `references.bib`.

## LaTeX Rules

- Use standard, minimal LaTeX packages unless the grant format requires otherwise.
- Keep the document compile-ready.
- Prefer semantic structure:
  - `\section{}`
  - `\subsection{}`
  - `\paragraph{}`
- Use `\cite{}` for references and `natbib` package.
- Avoid overcomplicated macros unless useful.
- If equations, tables, or figures are needed, include them only when supported by the notes.

## BibTeX Rules

- Extract all explicit references from the notes.
- Consolidate duplicate citations into one canonical entry.
- Use consistent BibTeX keys, for example:
  - `smith2022robustness`
  - `doe2021multiagent`
- If a citation is known only partially, keep the entry marked clearly for later completion.

## Workflow

1. Read all Markdown inputs.  
2. Identify:
   - project goal  
   - research problem  
   - contributions  
   - methods  
   - required references  
   - missing information  
3. Draft a concise but compelling grant narrative.  
4. Convert all bibliographic mentions into BibTeX entries.  
5. Write the final LaTeX and BibTeX outputs.  
6. Check consistency:
   - names  
   - acronyms  
   - citations  
   - section ordering  
   - terminology  
7. Ensure the output compiles cleanly.

## Style Guidance

Write in a tone that is:

- professional  
- precise  
- credible  
- concise  
- academically persuasive  

Avoid:

- hype  
- vague language  
- unsupported promises  
- repetitive phrasing  
- overlong sentences  
- endashes

## Handling Incomplete Notes

When the notes are incomplete:

- infer structure from context  
- keep placeholders for unknown details  
- make assumptions explicit only when necessary  
- prefer conservative, defensible wording over guesswork  

Examples of acceptable placeholders:

- `[FUNDING SCHEME]`  
- `[PROJECT DURATION]`  
- `[NAME OF HOST INSTITUTION]`  
- `[REFERENCE NEEDED]`  

Please note my details are:
 - name is Soumya Banerjee 
 - I am a Senior Lecturer in the Department of Computer Science at York University, UK. 
 - email is soumya.banerjee@york.ac.uk
 

## Quality Checklist

Before finishing, verify:

- the proposal has a clear argument  
- the research questions are explicit  
- the work plan is feasible  
- citations match bibliography entries  
- references are genuine and actually exist
- the LaTeX is syntactically valid  
- no unsupported claims were added  

## Output Expectations

The final deliverable should feel like a real grant draft, not a summary of notes.

I prefer the following:

- full sentences over bullet lists  
- narrative synthesis over raw extraction  
- coherent sections over fragmented notes  
- no endashes

