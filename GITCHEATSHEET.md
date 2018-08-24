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
