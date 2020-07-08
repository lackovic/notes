# git

Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- Generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [Branch operations](#branch-operations)
- [Commits operations](#commits-operations)
- [Stash operations](#stash-operations)
- [Remove/delete local untracked files](#removedelete-local-untracked-files)
- [Revert a PR merge and delete its commits from master history](#revert-a-pr-merge-and-delete-its-commits-from-master-history)
- [Revert a PR merge to master](#revert-a-pr-merge-to-master)
- [Revert / undo / delete a pushed tag](#revert--undo--delete-a-pushed-tag)
- [Find the most contributing developers in a repository](#find-the-most-contributing-developers-in-a-repository)
- [Persist the passphrase through restarts](#persist-the-passphrase-through-restarts)
  - [On *nix systems](#on-nix-systems)
  - [On Windows](#on-windows)
- [Resources](#resources)
- [Tools](#tools)
- [GitHub](#github)
  - [Find the most active forks of a repository](#find-the-most-active-forks-of-a-repository)
  - [Merging an upstream repository into your fork](#merging-an-upstream-repository-into-your-fork)
  - [Navigate to the first commit in a GitHub repository](#navigate-to-the-first-commit-in-a-github-repository)
  - [Change base branch](#change-base-branch)
  - [Resurrect a PR displaying unknown repository after the fork was deleted](#resurrect-a-pr-displaying-unknown-repository-after-the-fork-was-deleted)
  - [Tools](#tools-1)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Branch operations

```sh
# List local branches
git branch

# Get the current branch name
git rev-parse --abbrev-ref HEAD

# Delete local branch
git branch -d local-branch-name

# Reset your local branch
git fetch origin && git reset --hard && git clean -f -d

# Clone remote branch locally
   # with modern Git (>= 1.6.6)
   git fetch && git checkout remote-branch-name
   
   # with old Git (< 1.6.6)
   git fetch && git checkout -b remote-branch-name HEAD

# Merge master into the current branch
git pull origin master
```

## Commits operations

```sh
# Undo the last local (not pushed) commit, keeping the changes
git reset HEAD~1

# Delete the last local (not pushed) commit and all uncommited changes
git reset --hard HEAD~1

# Undo an old commit, keeping all commits that came after that one
git revert <COMMIT_SHA>

# Restore your project to an old commit, undoing/deleting all the commits that came afterwards
git reset --hard <COMMIT_SHA>

# Commit all changes
git commit -a
```

## Stash operations

```sh
# Stash your changes and untracked files
git stash -u

# View a summary of your last stash
git stash show

# Pass the -p option (or --patch) to view the full diff
git stash show -p

# View your untracked files in your last stash
git show stash^3

# Copy your last stash to a file
git stash show -p > modifiedfile
git show stash^3 > untrackedfile

# Put a patch file to the stash
git apply modifiedfile
git apply untrackedfile
```

## Remove/delete local untracked files

```bash
# Run this command first to check which files will be removed:
git clean -n

# When you are sure you want to remove then run:
git clean -f -d
```

## Revert a PR merge and delete its commits from master history

Warning! This operation is potentially harmful, it will delete also all the merges of other PRs done in between:

```shell
git reset --hard <COMMIT_SHA>
git status
git push -f origin master
```

## Revert a PR merge to master

After reverting a PR on master (i.e., it was mistakenly merged the first time), to produce a clean history for the second attempt at a PR:

1. Temporarily move master (so that subsequent rebase commits are not dropped by Git)
    
    ```bash
    git checkout master
    git revert --mainline 1 <PR_SHA>
    ```

1. Rebase to reattach old commits to latest master

    ```bash
    git checkout <BRANCH>
    git rebase --onto master <FIRST_COMMIT_SHA>~
    git checkout -b <NEW_BRANCH> # This will require you to create a new PR.  You should no longer use <BRANCH> but instead use <NEW_BRANCH> going forward.
    ```
  
1. Restore master (as it was temporarily move to help with rebase)

    ```bash
    git checkout master
    git reset --hard origin/master
    ```

## Revert / undo / delete a pushed tag

```bash
# delete local tag '1.2.3'
git tag -d 1.2.3
# delete remote tag '1.2.3'
git push origin :refs/tags/1.2.3
```

## Find the most contributing developers in a repository

With [git-guilt](https://bitbucket.org/tpettersen/git-guilt/src/master/) you can display the people who added and subtracted the most lines in a repository (e.g. over the last 3 years):

```
git-guilt `git log --until="3 years ago" --format="%H" -n 1` HEAD 
``` 

## Persist the passphrase through restarts

### On *nix systems

```sh
# Append to ~/.bashrc
eval `ssh-agent -s`

# Run
source ~/.bashrc

# Store the passphrase in your keychain with the `-K` option (`-k` for Ubuntu):
ssh-add -K ~/.ssh/id_rsa
```

### On Windows

```sh
# 1. Install OpenSSH Client:
Get-WindowsCapability -Online | Where-Object { $_.Name -like "OpenSSH.Client*" } | Add-WindowsCapability -Online | Out-Null

# 2. Set the service "OpenSSH Authentication Agent" to start automatically:
Get-Service ssh-agent | Set-Service -StartupType Automatic -PassThru | Start-Service

# 3. Add the private key
ssh-add C:\Users\YourUsername\.ssh\id_rsa
```

## Resources

- [git-tips](https://github.com/git-tips/tips)
- [Githug](https://github.com/Gazler/githug)
- [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)
- [Semantic Commit Messages](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716)

## Tools

- [git for Windows](https://chocolatey.org/packages/git)
- [TortoiseGit](https://chocolatey.org/packages/TortoiseGit)

## GitHub

### Find the most active forks of a repository

- [active-forks](https://techgaun.github.io/active-forks/index.html)

### Merging an upstream repository into your fork

```powershell
git pull https://github.com/ORIGINAL_OWNER/ORIGINAL_REPOSITORY.git BRANCH_NAME
```

- [Source](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/merging-an-upstream-repository-into-your-fork)

### Navigate to the first commit in a GitHub repository

1. take a note of the number of commits in the repository (say N)
1. calculate X = N-36
1. go to the list of commits
1. click on the "Older" button at the bottom of the page
1. replace +Y suffix in the URL with +X

### Change base branch

- [Changing the base branch of a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/changing-the-base-branch-of-a-pull-request)

### Resurrect a PR displaying unknown repository after the fork was deleted

```sh
git fetch origin refs/pull/123/head:foo
``` 

Substitute (if necessary) `origin` for the remote pointing at the target repo, `123` for the PR number, and `foo` for the name of the local branch you want created to point to the head of the PR.

Then you can simply `git checkout foo`, close the stale PR, and resubmit a new one which supersedes it.

Sources: [this](https://github.com/isaacs/github/issues/168#issuecomment-374201226) and [this](https://gist.github.com/piscisaureus/3342247).

### Tools

- [Octo Mate](https://chrome.google.com/webstore/detail/octo-mate/baggcehellihkglakjnmnhpnjmkbmpkf)
