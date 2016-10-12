# SYNOPSIS

Create ( multiple ) bitbucket git repositories.

# INSTALL

    sparrow plg install bitbucket-repo


# USAGE

    sparrow plg run bitbucket-repo 
    --param team=heroes \
    --param svn_repo=http://svnrepo/repo_one/ \
    --param user=alexey \
    --param password=12345 \
    


# Parameters

## team

This should be a bitbucket team  _representing_ a realm of multiple git repositories.

For example:

    --param team=my-cool-team

## user

This should be a bitbucket user with privileges to create a repositories inside the `team`.

## password

This should be bitbucket user's password

## svn_repo

This should be a svn repo URL.

For example:

    --param svn_repo=http://svn_repositories/private

A plugin goes through the list of directories and asynchronously creates remote git repository for
every directory.

A list of directories is calculated as:

    $ svn list $svn_repo 

# Author

Alexey Melezhik

