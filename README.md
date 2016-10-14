# SYNOPSIS

Create ( multiple ) bitbucket git repositories.

# Description

Plugin goes through the list of directories and asynchronously creates remote git repository for every one. 

# INSTALL

    sparrow plg install bitbucket-repo


# USAGE

    sparrow plg run bitbucket-repo 
    --param team=heroes \
    --param svn_repo=http://svn_repository/goods \
    --param user=alexey \
    --param password=12345 \
    

# Parameters

## team

This should be a bitbucket team  _representing_ a realm for git repositories.

For example:

    --param team=my-cool-team

## user

This should be a bitbucket user with privileges to create a repositories inside the `team`.

## password

This should be bitbucket user's password

## svn_repo

This should be a svn repo URL.

For example:

    --param svn_repo=http://svn_repository/goods

Plugin goes through the list of directories and asynchronously creates remote git repository for every one. 

A list of directories is fetched by `svn list` command:

    $ svn list $svn_repo 

## async_req 

Sets a number of asynchronous requests made to bitbucket API. Default value is 5. This is optional parameter.

You may increase `async_req` but be warned that bitbucket API has restriction on number of
simultaneous requests to it's resorce. If you see a lot of 429 errors ( Too May Requests )
at console tou have to decrease  `async_req` to proper value.

## sleep

Wait a `sleep` seconds before making request to bitbucket API. This parameter on conjunction with 
`async_req` should be adjusted in case of 429 errors ( Too May Requests ) returning from bitbucket API.

Default value is `3` seconds. Optional. 

# Author

Alexey Melezhik

