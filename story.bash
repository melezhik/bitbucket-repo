export user=$(config user)
export password=$(config password)

export svn_repo=$(config svn_repo)

export team=$(config team)
export project=$(config project)

export repo=$(config repo)
export postfix=$(config postfix)

echo svn_repo       : $svn_repo
echo bitbucket user : $user
echo team           : $team
echo project        : $project
echo repo           : $repo
echo postfix        : $postfix

export q="'";

mkdir -p ~/bitbucket-repo/cache

svn list $svn_repo| grep '/' | perl  -n -e '

  BEGIN {
    $user = $ENV{user}; 
    $repo = $ENV{repo}; 
    $project = $ENV{project}; 
    $team = $ENV{team}; 
    $password = $ENV{password}; 
    $postfix = $ENV{postfix}; 
    $q = $ENV{q};
  }

  ($r = $_)=~s{/}[]; chomp $r;

  if ($repo){
    next unless $repo eq $r;
  }

  $i++;

  print " 

  ( \\

  if test -f ~/bitbucket-repo/cache/$r$postfix; then
    echo repo $team/$r$postfix already exists
  elif curl -u $user:$password -s -f -k https://api.bitbucket.org/2.0/repositories/$team/$r$postfix -o /dev/null; then 
    echo repo $team/$r$postfix already exists
    touch ~/bitbucket-repo/cache/$r$postfix
  else
    curl -s -k -H \"Content-Type: application/json\" \\
    -w \" ... $pack/$i %{url_effective} %{http_code} \" -d $q { \"is_private\" :  true , \"project\" : { \"key\" : \"$project\" }  } $q \\
    https://api.bitbucket.org/2.0/repositories/$team/$r$postfix -u $user:$password 
  fi \\
  ) & \n "' | bash && echo bitbucket-repo-done

wait
