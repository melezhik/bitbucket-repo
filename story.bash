export local_dir=$(config local_dir)
export team=$(config team)
export user=$(config user)
export password=$(config password)
export http_debug=$(config http_debug)

echo team: $team
echo bitbucket user: $user
echo local_dir: $local_dir

export q="'";

#if test $http_debug; then
#export curl_opts="-D -"
#else
export curl_opts=""
#fi

find $local_dir -maxdepth 1 -mindepth 1 -type d -execdir perl -MFile::Basename \
-e 'my $p = basename(@ARGV[0]); my $user = $ENV{user}; my $password = $ENV{password}; 
my $q = $ENV{q};
print "let \"i++\"; ( echo -n \$i. \" \"; curl -s -k -H \"Content-Type: application/json\" -w \" %{url_effective} %{http_code} \" -d $q { \"is_private\" :  true  } $q",
" https://api.bitbucket.org/2.0/repositories/$ENV{team}/$p -u $user:$password; echo )    \n"' {}  \; \
| bash && echo bitbucket-repo-done
