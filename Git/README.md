# git

## List local branches

```bash
git branch
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
- [Octo Mate](https://chrome.google.com/webstore/detail/octo-mate/baggcehellihkglakjnmnhpnjmkbmpkf)

## Good reads

- [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)
- [Two years of squash merge](https://blog.dnsimple.com/2019/01/two-years-of-squash-merge/)