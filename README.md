# Local Git Helper Plugin

A Local Claude Code plugin that keeps reviews and commit prep entirely on your machine. It inspects git state, produces severity-ranked findings, and helps you ship clean commits without leaking code or adding dependencies.

## Problem statement

Developers often want a quick, high-signal review and a clean commit message without spinning up external services. This plugin automates that flow locally: it scopes staged vs unstaged diffs, highlights risks, and drafts conventional commit titles so you can commit confidently before pushing reducing bugs and faults in MRs.

## Architecture

-   Commands: `/review-changes` generates a scoped review using the `code-review` skill; `/suggest-commit-message` crafts a conventional commit title/body from local diffs.
-   Skill: `code-review` enforces repo checks, scope sizing, severity labels, and test guidance.
-   Hook: `afterWrite` (`hooks/after-write.sh`) runs after write/edit tool use, printing stats and warings as a prompt to review.
-   Local-first: all logic runs via git/CLI on your machine; no MCP servers or network calls.

## Installation & usage

Prereqs: Bash, git, and Claude Code with plugin loading enabled.

1. Clone this repo `https://github.com/mrjackcharles/Git-Helper-Claude-Plugin.git`

2. Create a local claude-plugin-marketplace with it's own marketplace.json that would look similar to this:

```
{
    "name": "local-dev-marketplace",
    "id": "local-dev-marketplace",
    "description": "Local marketplace for developing and testing plugins",
    "owner": {
        "name": "Local Developer",
        "id": "local-dev"
    },
    "plugins": [
        {
            "name": "git-helper-plugin",
            "version": "1.0.0",
            "description": "Local Code Review + Commit Helper for fast, guarded workflows",
            "author": {
                "name": "Local Developer",
                "id": "local-dev"
            },
            "source": "./git-helper-plugin"
        }
    ]
}
```

3. Create a symbolic link to the cloned repo from the marketplace folder e.g. `ln -s <target> <link_name>` (This is so that the plugin appears in you local marketplace and you can add the plugin)
4. Change any local paths
5. In Claude Code run `/Plugin` to add firstly the marketplace and then secondly the plugin itself.

---

6. Run the slash commands in Claude code:
    - `/review-changes` to get a severity-ranked summary of staged then unstaged diffs; it stops if no changes exist. (Can use code-review skill here as well)
    - `/suggest-commit-message` to generate a conventional commit title (and optional body/tests) from staged changes; (If only unstaged work exists it notes that)
7. Let the `afterWrite` hook run automatically after claude file writes/edits to show `git status` and custom warnings

## Demo

---

Suggested Commit Message:
![diagram](./demo-images/suggested-commit-message.png)

---

Code Reviewer Prompt:
![diagram](./demo-images/code-reviewer-prompt.png)

---

Code Review Report:
![diagram](./demo-images/code-review-report.png)

---

Warning AfterWrite Hook:
![diagram](./demo-images/after-write-hook.png)

---

Example Directory Used:
![diagram](./demo-images/example-directory.png)

---

Example File Used:
![diagram](./demo-images/example-file.png)

## Reflection and future improvements

-   Add an MCP server for ticket context (e.g. Jira) to increase detail and accuracy of commit messages.
-   Offer configurable severity policies.
-   Add more checks to the Warning Hook.
