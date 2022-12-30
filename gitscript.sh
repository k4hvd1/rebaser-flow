git config --global alias.pld  '![[ $(git rev-parse --abbrev-ref HEAD) == "dev" ]] && git fetch --all &&  git rebase origin/dev && git rebase origin/qa && git rebase origin/production'
git config --global alias.plq  '![[ $(git rev-parse --abbrev-ref HEAD) == "qa" ]] && git fetch --all &&  git rebase origin/qa && git rebase origin/production'
git config --global alias.plprod  '![[ $(git rev-parse --abbrev-ref HEAD) == "production" ]] && git pull'
git config --global alias.upq  '![[ $(git rev-parse --abbrev-ref HEAD) == "qa" ]] && git fetch --all && git merge origin/dev --ff-only'
git config --global alias.upprod  '![[ $(git rev-parse --abbrev-ref HEAD) == "production" ]] && git fetch --all && git merge origin/qa --ff-only'
git config --global alias.divq  '![[ $(git rev-parse --abbrev-ref HEAD) == "qa" ]] && git fetch --all &&  br="bck_qa_$(date '+%Y_%m_%d__%H_%M_%S')" && echo $br && git checkout -b $br origin/qa && git push -u origin $br && git checkout qa && git push --force-with-lease'
git config --global alias.divd  '![[ $(git rev-parse --abbrev-ref HEAD) == "dev" ]] && git fetch --all &&  br="bck_dev_$(date '+%Y_%m_%d__%H_%M_%S')" && echo $br && git checkout -b $br origin/dev && git push -u origin $br && git checkout dev && git push --force-with-lease'
