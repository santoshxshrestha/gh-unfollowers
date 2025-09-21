# gh-unfollowers

A simple Nushell script to check which GitHub users you follow **unfollowed you **.

## Why this exists

> Did you ever feel betrayed when someone unfollowed you while you were still following them? This script tells you exactly who did!

At first, I used to follow people back when they followed me. After some time, I realized some users were unfollowing me, and it became tedious to manually check who wasn’t following back.

This script automates that process and gives you the links to users who don’t follow you back.

## Features

- Checks the followers of a given GitHub username.
- Returns the list of users you follow who aren’t following you back.
- Supports optional GitHub Personal Access Token (PAT) for higher API limits.

## Usage

run it now

```nu
curl -fsSL https://raw.githubusercontent.com/santoshxshrestha/gh-unfollowers/main/gh-unfollowers.nu | nu

```

or save it and run it later

```nu
curl -fsSL -o gh-unfollowers.nu https://raw.githubusercontent.com/santoshxshrestha/gh-unfollowers/main/gh-unfollowers.nu
nu gh-unfollowers.nu
```
