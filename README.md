# AI Skills Vault

This folder is the vault of all the skills I use across my AI coding agents.

The goal is to keep the same shared skill set available no matter which agent I am using, so this repo acts as the central place to store, organize, and sync them.

## Source of Truth

`.agents/skills` is the canonical source for the shared skill library in this repo.

That source is synced into:

- `.codex/skills`
- `.opencode/skills`
- `.pi/skills`

## Syncing Skills

For future updates, just run:

```bash
./scripts/sync-agent-skills.sh
```

Or preview changes first:

```bash
./scripts/sync-agent-skills.sh --dry-run
```
