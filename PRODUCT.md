# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Primary: recruiters, hiring managers, and engineering leads who land on the site while evaluating Aniket Patidar for a software engineering role or engagement (backend; Ruby on Rails specialization). They arrive from a resume, a LinkedIn profile, a GitHub repo, or a search result; they already have a professional context and are not being educated about Rails.

Secondary: developers who read the blog for Ruby/Rails tutorials and dev-life content, and follow via RSS, X (Twitter), or LinkedIn. The site also serves as the author's own learning journal.

## Product Purpose

The site is a digital garden and professional portfolio. It exists to present verifiable proof of Aniket Patidar's work — real contributions, real recommendations, real projects, and a clear resume — so that a professional can quickly assess him and reach out. Success is measured by a visitor leaving confident about who he is and what he does, and by the blog continuing to motivate and document the author's practice.

## Positioning

The site's claim is grounded in verifiable substance rather than marketing: a shipped open-source contribution to a known Rails tool (Moneygun notifications), six real senior-engineer LinkedIn recommendations, working public projects, and an honest resume. The differentiator a neighboring personal site could not truthfully copy is this evidence layer, not a particular look.

## Operating Context

Builders and the author publish through a static Jekyll site (remote `minima` theme, light "Paper Ledger" skin) plus hand-authored layouts, includes, and CSS, deployed to GitHub Pages at aniketpatidar.com via CNAME. A weekly GitHub Action (`update-readmes.yml`) fetches project READMEs into `_projects/`. Analytics are minimal (aggregate traffic trends only, per the privacy page). The site ships an AI-discoverability layer: `llms.txt`, `sitemap.xml`, and `robots.txt`.

## Capabilities and Constraints

- Pages: `/` (home), `/about/`, `/posts/`, `/projects/`, `/projects/:name/` (collection), `/contributions/`, `/recommendations/`, `/resume`, `/contact/`, `/privacy/`, `/friends/`.
- Static Jekyll + GitHub Pages: no backend, no client-side application framework; content is Markdown plus Liquid templates, with some page-level inline CSS and scripts.
- The minima remote theme provides the base look; custom assets (`assets/css/custom.css`, `projects.css`, `readme.css`), layouts, and includes layer on top.
- The site is a personal one-person project; the author maintains it as a hobby plus career asset.
- Product facts must not be invented: professional claims, experience, credentials, testimonials, or metrics are only as real as the evidence in the repo records.
- Contact channels are email (`aniketpatidar01@gmail.com`), X (`@aniketpatidar01`), LinkedIn, and GitHub.

## Brand Commitments

The name is "Aniket Patidar", the domain is aniketpatidar.com, and the persona is a software engineer based in India, specialized in Ruby on Rails. No appearance or voice constraint was made binding during init. An incumbent voice is present in existing copy (warm, personal, "chai-fueled", opinionated-but-friendly) and is recorded as evidence, not as a lock.

## Evidence on Hand

- `_data/recommendations.json` — six real LinkedIn recommendations (Yaroslav Shmarov, Monika Kshatriya, Bhavesh Kshatriya, Jalaj Gupta, Dhyanendra Singh, Rahul Wath), served on `/recommendations/`.
- `contributions.markdown` — documented open-source contribution to Moneygun (Noticed notifications, PR #286), the Solid Cable debugging story, and a linked Rails issue thread and blog post.
- `_projects/` — collection with `ai-thumbnail-generator` (Next.js/TypeScript/Google Nano Banana), `codekata` (Rails/Hotwire/PostgreSQL), `interview-bot-fastapi` (Python/FastAPI/OpenAI), and `contributions`; `update-readmes.yml` keeps READMEs current.
- `resume.markdown` and `resume.txt` — current resume with education, experience, and contact.
- `about.markdown`, `index.markdown`, `posts.markdown`, `contact.markdown`, `privacy.markdown`, `friends.markdown`, `404.html`, `llms.txt`, `robots.txt`, `sitemap.xml` (generated).
- README.md links preview screenshots of the main pages.
- Absences to respect: no testimonials beyond the six above, no quantified outcomes or benchmarks, no fabricated credentials.

## Product Principles

1. **Evidence over claims.** Show real contributions, recommendations, projects, and a real resume. Never fabricate or inflate proof.
2. **Fast to assess.** A professional visitor should establish who, where, what stack, and what proof exists within seconds, then reach outreach.
3. **Stable foundations.** URLs, sitemap, robots, and `llms.txt` are assets for search and AI discoverability; preserve them.
4. **Substance over decoration.** Visual elements serve the professional story and the reading experience; nothing ornamental for its own sake.
5. **The garden never stops.** The blog should keep motivating new writing and meaningful contributions, feeding the evidence layer over time.