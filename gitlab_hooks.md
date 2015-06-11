git remote add --mirror github https://github.com/ratalaika/KhaSpiller.git
/var/opt/gitlab/git-data/repositories/<group>/<project>.git.
mkdir custom_hooks
cd custom_hooks
echo "exec git push --quiet github &" >> post-receive
chmod 755 post-receive
