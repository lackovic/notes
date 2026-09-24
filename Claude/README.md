# Introduction to Claude

Claude is Anthropic's AI model. You'll run into it in two shapes: Claude Chat, a browser-based conversation tool, and Claude Code, a command-line tool that works directly in your terminal and your repo.

Claude Code counts as what's sometimes called a harness: the layer that wraps a model, decides how it reads your repo, and manages how it calls tools. The model matters, but the harness shapes how well that model performs on real work.

Two harnesses running the identical model can differ wildly on pass rate, cost, and speed. [FrontierHarness](https://frontierharness.org/) benchmarks this directly. It runs nine harnesses (Codex, Claude Code, DSH Creator, Pi, and others) on the same model, same tasks, same fresh checkpoint, and measures pass rate, cost per task, and median runtime.

<!-- Generated with [DocToc](https://github.com/thlorenz/doctoc) -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Choosing the right model](#choosing-the-right-model)
- [Claude Chat](#claude-chat)
- [Claude Code](#claude-code)
  - [Naming and color-coding sessions](#naming-and-color-coding-sessions)
  - [Make Claude sound more human](#make-claude-sound-more-human)
  - [Context7](#context7)
  - [Herdr](#herdr)
  - [Hunk](#hunk)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Choosing the right model

This is about which model runs (Haiku, Sonnet, Opus), not which tool runs it. A strong harness running Sonnet can beat a weak one running Opus, so don't assume the biggest model wins by default.

- **Haiku** is fastest and cheapest, good for small mechanical work like renames, syntax questions, formatting fixes, log parsing, quick lookups, and short summaries. It's not built for multi-file agentic tasks.

- **Sonnet** is the default model. It handles day-to-day development, including features, bug fixes, multi-file refactoring, test writing, code review, and getting up to speed on unfamiliar code. If you're not sure which model to pick, pick Sonnet.

- **Opus** is for problems that need deeper reasoning: architectural decisions, cross-system debugging, novel algorithms, and concurrency or performance issues without an obvious answer.

## Claude Chat

Claude Chat runs at claude.ai. Use it for brainstorming, writing documentation, or talking through a problem before you touch any code.

## Claude Code

Claude Code lives in your terminal and handles multi-step work: refactoring, debugging, feature implementation, anything that needs several passes through a codebase rather than a single answer.

Install it by following the official guide at https://code.claude.com/docs/en/overview.

Once it's installed, you can extend what it can see and do, for example you can connect it to GitHub so it can read and modify repos. Install the GitHub CLI (https://cli.github.com/) and run `gh auth login`.

### Naming and color-coding sessions

By default, a Claude Code session gets an auto-generated name (or none) and no color. That's fine with one session open. It stops being fine once you've got five terminal tabs running Claude Code and every `/resume` list looks like a wall of timestamps.

A small shell function fixes this. It lives in [`./.bashrc_personal`](./.bashrc_personal). Source it from your shell profile:

```bash
# in ~/.bashrc or ~/.zshrc
source /path/to/.bashrc_personal
```

Reload your shell with `source ~/.bashrc`. Every new session then gets a name like `repo-sep26-1349` plus a random prompt-bar color. Manually named sessions (`claude -n pippo`) still work as before. After you have given enough context to Claude, just type `/rename` and hit Enter and Claude will rename the session to something more meaningful.

The name makes sessions identifiable in `/resume`, in cross-session messaging (`/list-agents`), and in tools like Herdr's sidebar. The color gives you a peripheral cue across tabs, so you notice before you paste a command into the wrong session.

### Make Claude sound more human

Claude's default writing style has tells: it reaches for the same handful of words and sentence patterns often enough that people notice. You can override this with custom instructions, either in your project's `CLAUDE.md` or under Instructions for Claude in your claude.ai settings.

The details, banned words, banned phrases, and the voice and structure rules to follow, live in [`./CLAUDE.md`](./CLAUDE.md) rather than here, since you'll want to extend the list with whatever words Claude reaches for that you personally wouldn't use.

Source: https://willfrancis.com/how-to-stop-claude-writing-like-an-ai/

### Context7

Context7 is an MCP server that pulls current, version-specific documentation straight into Claude Code's context. Without it, Claude falls back on whatever it learned during training, which goes stale and occasionally invents APIs that don't exist. Point Context7 at a library and it fetches the real docs on demand instead, which cuts down on hallucinated method names when you're working against a framework that's moved past the model's training cutoff.

Install instructions: https://context7.com/install.
    
### Herdr

Herdr keeps your agent's terminal sessions alive on a machine, so the work survives closing your laptop, losing network, or a restart. It doesn't wrap Claude Code, it just owns the terminal so you can detach and reattach from anywhere. 

For more information on Herdr, visit: https://herdr.dev.

After installing Herdr, hook it up to Claude Code with:

```bash
herdr integration install claude
npx skills add herdrdev/herdr --skill herdr -g
```

By default, Herdr's sidebar labels each agent pane with its working directory. That's fine with one or two panes, but once you've got five or ten running across different workspaces, every entry looks the same and you have to switch into each pane just to remember what it's doing. Showing the session name instead fixes that: you can tell one agent from another at a glance, without opening either pane. 

Set it up by adding the following to your `~/.config/herdr/config.toml`:

```toml
[ui.sidebar.agents]
row_gap = 1
rows = [
  ["state_icon", { token = "terminal_title_stripped", bold = true }],
]
```

Apply it without restarting with `herdr server reload-config`.

### Hunk

Hunk is a terminal diff viewer built for reviewing agent-authored changesets: one continuous stream across every changed file, the agent's own reasoning rendered next to the hunk it explains, and a watch mode that updates as the agent keeps working. It drops in as a pager or difftool for Git, Jujutsu, and Sapling.

For installation and usage instructions, visit: https://hunk.dev.
