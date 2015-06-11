First we log into our GitLab server and go to
<pre lang="bash">
/var/opt/gitlab/git-data/repositories/<group>/<project>.git.
</pre>

Then we add a mirror to our gitlab git
<pre lang="bash">
git remote add --mirror github git@github.com:ratalaika/KhaSpiller.git
</pre>

After that we make a backup of the post-recive hook
<pre lang="bash">
mv post-revice post-recive.back
</pre>

Now we create our file using this
<pre lang="bash">
echo "exec git push --quiet github &" >> post-receive
</pre>

And grant him permisions
<pre lang="bash">
chmod 755 post-receive
</pre>

Now we log with the git user and create ssh keys (more info [here](https://help.github.com/articles/generating-ssh-keys/))

After that we set this file in .ssh/
<pre lang="bash">
nano config
</pre>

<pre lang="bash">
Host github.com
  User git
  ConnectTimeout 15
  ServerAliveInterval 45
  ForwardAgent yes
  IdentityFile ~/.ssh/github_rsa
</pre>

For end we make a small comit on the client a execute the post-recive by hand to verify that the access are right
<pre lang="bash">
./hooks/post-receive
</pre>