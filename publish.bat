git add *
git commit -am "Publish"
git branch -D master
git checkout -b master 
git filter-branch --subdirectory-filter _site/ -f
git push --all
git checkout source