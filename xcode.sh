## Add .gitignore
git add .gitignore  
git commit -m "Add .gitignore"

## Remove local project files
echo "Removing local project files"  
LIST=`git ls-files -i --exclude-from=.gitignore`

for i in $LIST  
do  
echo $i  
git rm -f --cached $i  
done

## Commit local removal.
git commit -m "Remove local project files from git"
