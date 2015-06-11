First we log into our GitLab server and go to

/var/opt/gitlab/git-data/repositories/<group>/<project>.git.

Then we add a mirror to our gitlab git

git remote add --mirror github git@github.com:ratalaika/KhaSpiller.git

After that we make a new directory called custom_hooks


mkdir custom_hooks

cd custom_hooks

echo "exec git push --quiet github &" >> post-receive

chmod 755 post-receive

https://help.github.com/articles/generating-ssh-keys/

./hooks/custom_hooks/post-receive

a 