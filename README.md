# Introduction

Simple Web Application that provides Github Issues integration to Pivotal Tracker.

It's a simple sinatra application that lets you retrieve the github issues from your organization projects in the XML format requested by Pivotal Tracker (see the [documentation](http://www.pivotaltracker.com/help/integrations?version=v3#other))

The application is intended to work with all projects a github user can access. You just provide your credentials, and the application lets you import issues from whichever repositories you want.

# Running the Application

## Download Code

Just clone the repository

```bash
    git clone https://github.com/zauberlabs/gh-pivotal-integration.git
```

## Local Deploy

You need to obtain the depencies, if you don't have *bundler*, install it

```bash
    gem install bundler
```

Get the dependencies

```bash
    bundle install
```

Set up the environment variables to use the application, you may modify your `.bashrc` or
define the variables by command line.

```bash
    export GH_USER="myuser"
    export GH_PASSWORD="mygithubpassword"
    export BASIC_USER="admin"
    export BASIC_PASSWORD="password"
```

And just run it with rack or whatever rack server you want.

```bash
    rackup config.ru
```

## Heroku Deploy

If you have a heroku account and you want to deploy the aplication there, you should follow these steps:

    heroku create --stack cedar
    heroku config:add GH_USER="myuser" GH_PASSWORD="mygithubpassword" \
                      BASIC_USER="admin" BASIC_PASSWORD="password"
    git push heroku master

Also, we recommend you add the ssl module (you don't want anyone peeking at your credentials!)

    heroku addons:add piggyback_ssl

## Configuration at Pivotal Tracker

Finally, to configure the applciation on pivotal tracker.

Supposing that:

 * the application deployed at `https://my.domain.com/gh-pivotal/`.
 * the github project lives at `https://github.com/myaccount/reponame`

Go to your pivotal tracker project and:

 1. select `Project->Configure Integrations`
 2. On `External Tool Integrations` select the option `Other`
 3. Fill the form with:
    * **Name**: Whatever you want (eg. Github Issues)
    * **Basic Auth Username**: what you configured
    * **Basic Auth Password**: what you configured
    * **Base URL**: https://github.com/
    * **Import API URL**: https://my.domain.com/gh-pivotal/issues/myaccount/reponame

And you're done. Start importing issues by selecting `More->The name you used`.

### Labels support

You can provide the `labels` parameter with a comma separated list of labels to filter the issues that have certain labels. For example:
 * **Import API URL**: https://my.domain.com/gh-pivotal/issues/myaccount/reponame?labels=critic,ui


## Contributing to github-issues-pivotal-integration

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Zauber. See LICENSE.txt for
further details.

