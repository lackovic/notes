# git

Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- Generated with [DocToc](https://github.com/thlorenz/doctoc) -->

- [List local branches](#list-local-branches)
- [Get the current branch name](#get-the-current-branch-name)
- [Delete local branch](#delete-local-branch)
- [Delete the last local commit](#delete-the-last-local-commit)
- [Undo the last local commit](#undo-the-last-local-commit)
- [Powershell branch pruning](#powershell-branch-pruning)
- [Revert a PR merge to master](#revert-a-pr-merge-to-master)
- [Revert / undo / delete a pushed tag](#revert--undo--delete-a-pushed-tag)
- [Useful aliases](#useful-aliases)
- [Resources](#resources)
- [Tools](#tools)
- [Good reads](#good-reads)
- [GitHub](#github)
  - [Navigate to the first commit in a GitHub repository](#navigate-to-the-first-commit-in-a-github-repository)
  - [Tools](#tools-1)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## List local branches

```bash
git branch
```

## Get the current branch name

```bash
git rev-parse --abbrev-ref HEAD
```

## Delete local branch

```bash
git branch -d NameOfTheBranch
```


## Delete the last local commit

```bash
git reset --hard HEAD~1
```

## Undo the last local commit

```bash
git reset HEAD~1
```

## Powershell branch pruning

Removes all your local branches whose remote has been already merged:

```ps
$remote=git branch -r; git branch --merged | %{$_.Trim()} | ?{-not ($remote -like '*' + $_) } | %{git branch -D "$_"}
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
    
## Useful aliases

Add the following lines under `[alias]` in your `\.gitconfig` file:

```
  delete-last-commit = reset --hard HEAD~1
  undo-last-commit = git reset HEAD~1
  list-local-branches = branch
  delete-local-branch = branch -d

  log-pretty = log --oneline --graph --decorate
  stage-all-and-commit = add . && git commit -m
  new-branch = checkout master && git pull && checkout -b
  go-to-master = checkout master && git pull
```

git supports autocompletion with TAB so there is no need for abbreviations.

I mostly use the first 4, for the others VsCode is more convenient.

## Resources

- [git-tips](https://github.com/git-tips/tips)

## Tools

- [git for Windows](https://chocolatey.org/packages/git)
- [TortoiseGit](https://chocolatey.org/packages/TortoiseGit)

## Good reads

- [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)
- [Two years of squash merge](https://blog.dnsimple.com/2019/01/two-years-of-squash-merge/)

## GitHub

### Navigate to the first commit in a GitHub repository

1. take a note of the number of commits in the repository (say N)
1. calculate X = N-36
1. go to the list of commits
1. click on the "Older" button at the bottom of the page
1. replace +Y suffix in the URL with +X

### Tools

- [Octo Mate](https://chrome.google.com/webstore/detail/octo-mate/baggcehellihkglakjnmnhpnjmkbmpkf)