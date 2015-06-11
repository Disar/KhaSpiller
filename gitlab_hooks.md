First we add a mirror to our gitlab git

git remote add --mirror github git@github.com:ratalaika/KhaSpiller.git

/var/opt/gitlab/git-data/repositories/<group>/<project>.git.
mkdir custom_hooks
cd custom_hooks
echo "exec git push --quiet github &" >> post-receive
chmod 755 post-receive
https://help.github.com/articles/generating-ssh-keys/
./hooks/custom_hooks/post-receive