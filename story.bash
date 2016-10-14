export svn_repo=$(config svn_repo)
export team=$(config team)
export user=$(config user)
export password=$(config password)

echo svn_repo       : $svn_repo
echo team           : $team
echo bitbucket user : $user

export q="'";

mkdir -p ~/bitbucket-repo/cache

svn list $svn_repo| grep '/' | perl  -n -e '

  BEGIN {
    $user = $ENV{user}; 
    $team = $ENV{team}; 
    $password = $ENV{password}; 
    $q = $ENV{q};
  }

  ($p = $_)=~s{/}[]; chomp $p;

  $i++;

  print " 

  ( \\

  if test -f ~/bitbucket-repo/cache/$p; then
    echo repo $team/$p already exists
  elif curl -u $user:$password -s -f -k https://api.bitbucket.org/2.0/repositories/$team/$p -o /dev/null; then 
    echo repo $team/$p already exists
    touch ~/bitbucket-repo/cache/$p
  else
    curl -s -k -H \"Content-Type: application/json\" \\
    -w \" ... $pack/$i %{url_effective} %{http_code} \" -d $q { \"is_private\" :  true  } $q \\
    https://api.bitbucket.org/2.0/repositories/$team/$p -u $user:$password 
  fi \\
  ) & \n "' | bash && echo bitbucket-repo-done

wait
