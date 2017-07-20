set configuration=%1

IF "%configuration%"== "HA_Live" (
git checkout -b develop
git add -u
git status
git commit "-m" "Build Agent - update Android version number."
git remote -v
git push -u origin --all
)