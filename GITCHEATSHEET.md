Git Cheatsheet
==============

Clone a repository
```
git clone https://github.com/user/repository
```

Clone repository after ssh access setup
```
git clone git@github.com:user/repository.git
```

Check git status
```
git status
```

Check branch status
```
git branch -va
```

Add files to be updated
```
git add filename
```

Automatically add any modified files
```
git add -u
```

Commit changes to the repository:
```
git commit -m "Added 3 level paths and added a test. Fixed -d flag."
```

Push changes to git server
```
git push
```

Reload file from git, undoing all changes.
```
git checkout -- filename
```

Create new branch and start working on it
```
git checkout -b newbranch
```
Change to branch.
```
git checkout branch
```
Workflow. Create a new branch, rename it, then check it in.
Create a new branch. Rename it. Add modified files. Commit changes. Push changes.
```
git checkout -b newbranch
git branch -m renamedbranch
git add -u
git commit -m "commit message"
git push --set-upstream origin renamedbranch
```
Pull remote changes in a forked repository.
```
git pull upstream master
```
Merge branch back into master
```
git checkout master
git merge branch
git push
```