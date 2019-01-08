Git Cheatsheet
==============
### Cloning
Clone a repository
```
git clone https://github.com/user/repository
```
Clone repository after ssh access has been setup
```
git clone git@github.com:user/repository.git
```
### Status
Check git status
```
git status
```
Check branch status
```
git branch -va
```
### Pushing Changes
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
git commit -m "Commit message"
```

Push changes to git server
```
git push
```

Reload file from git, undoing all changes.
```
git checkout -- filename
```
### Branches
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
Create branch, push to branch
```
git checkout -b branch
git push --set-upstream origin branch
```
### Public Key
Setting up git public key - saves setting username and password every commit.
```
ssh-keygen -t rsa -b 4096 -C "username@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```
Paste this into git settings on github.com
```
cat ~/.ssh/id_rsa.pub 
```
Test if key works
```
ssh -T git@github.com
```
### Stashing 
Stashing modified files for later
'''
git stash save "Meaningful message"
'''
List stashed files. At this point that "Meaningful message" becomes important.
```
git stash list
```
Unstash changed files
```
git stash apply / pop
```
Get rid of stashed files
```
git stash clear
```
