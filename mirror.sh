#!/usr/bin/env sh
set -eu

/setup-ssh.sh

export GIT_SSH_COMMAND="ssh -v -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no -l $INPUT_SSH_USERNAME"
git config --global user.name 'seqyuan'
git config --global user.email 'ahworld07@gmail.com'
git clone https://github.com/seqyuan/sphinxbook.git
cp -r sphinxbook/docs/* ./docs/
git add -A
git commit -m "..."

git remote add mirror "$INPUT_TARGET_REPO_URL"
git push --tags --force --prune mirror "refs/remotes/origin/*:refs/heads/*"

# NOTE: Since `post` execution is not supported for local action from './' for now, we need to
# run the command by hand.
/cleanup.sh mirror
