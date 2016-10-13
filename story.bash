export svn_repo=$(config svn_repo)
export team=$(config team)
export user=$(config user)
export password=$(config password)
clear_cache=$(config clear_cache)

echo svn_repo       : $svn_repo
echo team           : $team
echo bitbucket user : $user

export q="'";

rm -rf ~/bitbucket-repo/flock

mkdir -p ~/tmp/bitbucket-repo/flock


if test -z $clear_cache; then
  echo cache at: ~/tmp/bitbucket-repo/cache
  mkdir -p ~/tmp/bitbucket-repo/cache
else
  echo clear cache at: ~/tmp/bitbucket-repo/cache
  rm -rf ~/tmp/bitbucket-repo/cache
  mkdir -p ~/tmp/bitbucket-repo/cache
fi


svn list $svn_repo| grep '/' | perl  -n -e '

  BEGIN {
    $user = $ENV{user}; 
    $team = $ENV{team}; 
    $password = $ENV{password}; 
    $q = $ENV{q};
    $pack = 1; $i = 0;
  }

  ($p = $_)=~s{/}[]; chomp $p;

  $i++;

  $pack++ if $i%10 == 0;

  print "( flock ~/tmp/bitbucket-repo/flock/lock.$pack \\
  curl -s -k -H \"Content-Type: application/json\" \\
  -w \" ... $pack/$i %{url_effective} %{http_code} \" -d $q { \"is_private\" :  true  } $q \\
  https://api.bitbucket.org/2.0/repositories/$team/$p -u $user:$password ; echo; echo  ) &  \n\n";    


' | bash && echo bitbucket-repo-done
wait
