# SYNOPSIS

Asynchronously create bitbucket git repositories.


# INSTALL

    sparrow plg install bitbucket-repo


# USAGE

    sparrow plg run bitbucket-repo --param url=https://github.com/melezhik \
    --param local_dir=/path/to/local/git/repositories/


# Parameters

## url

This should be a remote git repository URL _representing_ a realm of your multiple repositories.

For example, if you use BitBucket, this could be a `team` container:

    --param url=https://bitbucket.org/my-cool-team

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

