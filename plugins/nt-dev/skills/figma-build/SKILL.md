---
name: figma-build
description: Build a multi-section page from Figma frames, from intake to shipped PR.
effort: high
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, Agent, AskUserQuestion
argument-hint: "[epic-issue-number]"
---

# Figma page build

Use for one epic containing several sections shipped together. Follow the repo's Figma workflow for frame-level mechanics; this skill coordinates the page.

## Resolve the spec

Before planning, collect the epic and section issues, frame node IDs at every project breakpoint, the actual breakpoint ramp, themes, launch caveats, and feature-flag pattern. Ask for missing inputs in one round.

Inspect every frame and record exact copy, typography, layout, spacing, semantic colors, assets, and breakpoint changes. Search the codebase before proposing components. Classify each element:

- **REUSE:** use unchanged
- **PROMOTE:** move an existing element to a shared layer and name what varies
- **NEW:** create a primitive or shared local component
- **NEEDS RULING:** present options, costs, and a recommendation

Batch design conflicts and reuse rulings into one request. Do not guess or leave inline color values.

## Build

Land shared dependencies before sections: theme-complete tokens, primitives with unchanged existing consumers, then assets exported from recorded node IDs in the project's format.

Build the first section serially. Build the rest in parallel only after it exposes missing shared work. Keep each worker within its section; missing tokens or primitives return to the coordinator.

Follow the repo's server/client split. Keep interactive state in small leaves. Copy frames verbatim. Flag placeholders and conflicting copy instead of inventing content.

## Verify

At every breakpoint, compare rendered values and behavior with the extracted spec. Verify probe preconditions such as image loading and animation state before trusting failures. Typecheck and lint each commit; prove checks aimed at a specific failure can fail.

Before shipping, remove scaffolding comments and consolidate only proven duplication: identical shells, repeated design values, components differing on one axis, shared patterns used by multiple surfaces, and duplicated data shapes. Re-run the same QA after refactoring.

## Ship

Commit dependencies before sections. Get explicit approval before git operations. Check whether the branch already has a PR; never force-push a shared branch.

Link the PR from each section issue and record unresolved copy, design, or asset decisions in both the PR and owning issue.
