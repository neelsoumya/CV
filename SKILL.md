---
name: faculty-application-writer
description: >
  Use this skill whenever the user wants to write responses to selection criteria or a cover letter for a faculty position (lecturer, senior lecturer, associate professor, assistant professor, research fellow, or similar academic roles). Trigger when the user provides a job description, role title, or selection criteria and wants tailored application text. Also trigger when the user says things like "write my cover letter", "respond to these criteria", "help me apply for this job", "draft my application", or pastes a job ad. This skill uses the candidate's CV and prior response snippets (provided in context) to produce concise, evidence-based answers in the correct academic register — never generic filler.
---

# Faculty Application Writer

A skill for producing concise, evidence-based responses to selection criteria and cover letters for academic faculty positions, using the candidate's CV and prior writing samples as source material.

---

## Inputs Required

Before writing anything, confirm you have:

1. **The job description / role title** — the position being applied for.
2. **The selection criteria** — either embedded in the JD or listed separately.
3. **The candidate's CV** — already present in conversation context (Soumya Banerjee's CV is provided).
4. **Tone preference** (optional) — "formal UK academic", "conversational", etc. Default: formal UK academic.
5. **Length preference** (optional) — "short bullets", "one paragraph per criterion", "half-page cover letter". Default: one concise paragraph per criterion (~80–120 words).

If the job description or criteria are missing, ask for them before proceeding.

---

## Core Principles

### 1. Evidence-first, no filler
Every response must cite a **specific output**: a named paper, a named course, a named grant, a named institution. Never write "I have extensive experience in X" without immediately naming the evidence.

**Bad:** "I have strong programming skills."  
**Good:** "I have strong Python and R programming skills, developed across 10+ years of research; open-source packages (dsSurvival, dsSynthetic) and ranked Top 250 on MATLAB Central evidence this."

### 2. Match the criterion's verb
- "Demonstrate experience in X" → open with a past-tense action: "I have developed / published / taught / led..."
- "Ability to X" → show the ability via a completed example: "As demonstrated by..."
- "Evidence of X" → name the artefact directly: "My paper in Nature Partner Journal Schizophrenia provides direct evidence of..."

### 3. One claim, one proof, one sentence of impact
Structure each criterion response as:
> [Claim] + [Named evidence] + [So what / impact]

Keep to ~80–120 words per criterion unless instructed otherwise.

### 4. UK academic register
- Use British English spelling (behaviour, modelling, recognise).
- Avoid Americanisms (e.g. "program" → "programme" for non-software contexts).
- Avoid hype words: "passionate", "cutting-edge", "world-class", "robust".
- Prefer: "I have developed", "I have contributed to", "my work has been published in".

### 5. Cover letter structure (when requested)
Follow this structure for a one-page cover letter:
1. **Opening (2 sentences):** Role name + why this institution/group specifically.
2. **Research fit (1 short paragraph):** Core research identity, 2–3 named outputs.
3. **Teaching fit (1 short paragraph):** Named courses developed or taught, student outcomes if available.
4. **Grant/leadership fit (1–2 sentences):** Named grants or leadership roles.
5. **Closing (1 sentence):** Availability, enthusiasm, call to action.

---

## Workflow

### Step 1 — Parse the criteria
List each criterion from the job description. Label them:
- **Essential (E)** or **Desirable (D)** if specified.
- Flag any where the candidate's profile is weak — note this briefly rather than bluffing.

### Step 2 — Map CV evidence to each criterion
Use the candidate's CV (in context) to identify the strongest 1–2 pieces of evidence per criterion. Draw from:
- Named publications (journal, year, impact factor if notable)
- Named courses / teaching materials (with URLs if available)
- Named grants (funder, amount, role)
- Named institutions / collaborators
- Named software / tools / packages

### Step 3 — Draft responses
Write one paragraph per criterion using the structure: **Claim → Evidence → Impact**.

### Step 4 — Draft cover letter (if requested)
Follow the cover letter structure above. Pull named evidence from Step 2. Keep to ~400–500 words.

### Step 5 — Offer to iterate
After delivering the draft, offer:
- "Would you like any responses shortened, expanded, or reframed?"
- "Shall I adjust the tone for [institution type]?"

---

## Candidate Profile Summary (Soumya Banerjee)

*Pre-loaded evidence bank — use this to avoid re-reading the full CV every time.*

| Domain | Key Evidence |
|--------|-------------|
| **Explainable AI / ML** | Class-contrastive ML for mortality prediction (*NPJ Schizophrenia*, 2021); complex explanations for AI (*Life*, 2024); ARC neural networks (*Scientific Reports*, 2024) |
| **Federated / privacy-preserving data** | dsSurvival, dsSynthetic, ShinyDataSHIELD packages; papers in *Bioinformatics Advances* (2025), *BMC Research Notes* (2022–23), *IJE* (2022) |
| **Healthcare AI / clinical data** | Mortality prediction in severe mental illness; COVID-19 mental health impact (*J Psychiatric Research*, 2020); patient & public involvement framework (*Patterns*, 2022) |
| **Computational biology** | IBD monocyte paper (*Gut*, 2020); West Nile virus (*J Royal Soc Interface*, 2016–18); microbiome metabolomics (*Nature Communications*, 2019) |
| **Teaching** | Teaches ML, data science, reproducibility at Cambridge; Fellow of Higher Education Academy; Cambridge-Africa Programme (2020); unsupervised ML course (cambiotraining.github.io) |
| **Grants** | OpenAI Researcher Access ($3k, 2024); AI@CAM Co-I (£150k, 2024); MRC New Investigator (under review) |
| **Supervision** | 14 MPhil students, 2 summer interns, 1 co-supervised PhD |
| **Responsible AI / Ethics** | AI Safety Policy Fellowship (Cambridge AI Safety Hub, 2023); patient involvement papers; Data Science Africa workshops (2025) |
| **Industry experience** | Senior Software Engineer at Cognizant (Fortune 500 financial clients, 2004–2007); C/C++, Sybase, production systems |
| **Programming** | Python, R, MATLAB (Top 250 worldwide MATLAB Central), shell, C/C++, Perl, Haskell |

---

## Quality Checks Before Delivering

- [ ] Every response names at least one specific paper, course, grant, or tool.
- [ ] No response uses "passionate", "cutting-edge", "robust", or "extensive experience" without immediate named evidence.
- [ ] British English throughout.
- [ ] Each response is within the requested length (default 80–120 words).
- [ ] Cover letter (if written) fits on one page (~400–500 words).
- [ ] Weak criteria are flagged honestly rather than bluffed.

---

## Example Output Format

**Criterion:** *Experience in developing and delivering taught courses in AI or data science.*

> I have designed and delivered multiple courses in machine learning and data science at the University of Cambridge, including an unsupervised ML course (cambiotraining.github.io/ml-unsupervised/) and reproducible research in R (publicly available on GitHub). I hold a Fellowship of the Higher Education Academy. My teaching spans undergraduate, postgraduate and international audiences, including the Cambridge-Africa Programme (2020) and the Oxford Complex Networks Summer School (2017). Student-facing materials are openly available and have been adopted by colleagues beyond Cambridge.

---

*When in doubt, go shorter and more specific rather than longer and general.*
