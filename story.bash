export user=$(config user)
export password=$(config password)

export svn_repo=$(config svn_repo)

export team=$(config team)
export project=$(config project)

export repo=$(config repo)
export postfix=$(config postfix)
export chunk=$(config chunk)
export sleep=$(config sleep)

echo svn_repo       : $svn_repo
echo bitbucket user : $user
echo team           : $team
echo project        : $project
echo repo           : $repo
echo postfix        : $postfix
echo chunk          : $chunk
echo 'sleep'        : $sleep

export q="'";

mkdir -p ~/bitbucket-repo/cache
rm -rf  ~/bitbucket-repo/lock
mkdir -p ~/bitbucket-repo/lock

svn list $svn_repo| grep '/' | perl  -n -e '

  BEGIN {
    $lid = 1;
    $user = $ENV{user}; 
    $repo = $ENV{repo}; 
    $project = $ENV{project}; 
    $team = $ENV{team}; 
    $password = $ENV{password}; 
    $postfix = $ENV{postfix}; 
    $chunk = $ENV{chunk}; 
    $sleep = $ENV{sleep}; 
    $q = $ENV{q};
  }

  ($r = $_)=~s{/}[]; chomp $r;

  if ($repo){
    next unless $repo eq $r;
  }

  $i++;

  if (($i%$chunk) == 0){
    $lid++;
    print "touch ~/bitbucket-repo/lock/lock.$lid\n";
  }

  print " 

  if test -f ~/bitbucket-repo/cache/$r$postfix; then
    echo repo $team/$r$postfix already exists
  elif curl -u $user:$password -s -f -k https://api.bitbucket.org/2.0/repositories/$team/$r$postfix -o /dev/null; then 
    echo repo $team/$r$postfix already exists
    touch ~/bitbucket-repo/cache/$r$postfix
  else
    sleep $sleep && ( flock ~/bitbucket-repo/lock/lock.$lid \\
    curl -s -k -H \"Content-Type: application/json\" \\
    -w \" |lock id: $lid| |nn: $i| %{url_effective} %{http_code} \" -d $q { \"is_private\" :  true , \"project\" : { \"key\" : \"$project\" }  } $q \\
    https://api.bitbucket.org/2.0/repositories/$team/$r$postfix -u $user:$password &&  echo ) &
  fi
  \n "' | bash && echo bitbucket-repo-done

wait
