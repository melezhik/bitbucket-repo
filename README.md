# SYNOPSIS

Asynchronously create bitbucket git repositories.


# INSTALL

    sparrow plg install bitbucket-repo


# USAGE

    sparrow plg run bitbucket-repo --param local_dir=/path/to/local/git/repositories/ \
    --param user=alexey --param password=12345 --param team=heroes
    


# Parameters

## team

This should be a bitbucket team  _representing_ a realm of your multiple repositories.

For example:

    --param team=my-cool-team

## user

This should be a bitbucket user with privileges to create a repositories inside team.

## password

This should be bitbucket user's password

## local_dir

This should be a local path to a directory containing a _local git repositories_

A layout should be:

    # local_dir:
    /home/melezhik/repos/

    # foo repository:
    /home/melezhik/repos/foo/ -- remote git url ---> $url/foo.git

    # baz repository:
    /home/melezhik/repos/baz/ -- remote git url ---> $url/baz.git


    so on ...

So the convention is that the name of directory to contain source code should _match_
_remote repository url_:

    $url/$directory-name.git

A plugin goes through the list of repositories and asynchronously creates remote git repository.
An asynchronous behavior is implemented by simple Linux background process using `&`.  

# Author

Alexey Melezhik

