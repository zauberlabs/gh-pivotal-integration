# Introduction

gh-pivotal-integration integrates GitHub Issues with your Pivotal Tracker backlog.

It's a simple Sinatra application that

* retrieves GitHub Issues from your project and formats them for Pivotal Tracker's import panel (see [xml format](http://www.pivotaltracker.com/help/integrations?version=v3#other)), and

* automatically marks GitHub Issues as closed when you accept your Piovotal Tracker story.

# Installing gh-pivotal-integration

Pick a username, `BASIC_USER`, and password, `BASIC_PASSWORD`, to secure your instance of gh-pivotal-integration. Choose wisely. You need these for installing gh-pivotal-integration and configuring the Pivotal Tracker integration.

## Deploy Option #1: Local

Install dependencies:

```bash
    git clone https://github.com/ThreadSuite/gh-pivotal-integration.git
    cd gh-pivotal-integration
    gem install bundler  # if not already installed
    bundle install
```

Set these environment variables in your shell or `.bashrc`:

```bash
    export GH_USER="myuser"
    export GH_PASSWORD="mygithubpassword"
    export BASIC_USER="admin"
    export BASIC_PASSWORD="password"
```

Run gh-pivotal-integration using rack (or your favorite server):

```bash
    rackup config.ru
```

## Deploy Option #2: Heroku

To deploy gh-pivotal-integration on a free Heroku account, simply follow these steps:

```bash
    git clone https://github.com/ThreadSuite/gh-pivotal-integration.git
    cd gh-pivotal-integration
    heroku create --stack cedar
    heroku config:add GH_USER="myuser" GH_PASSWORD="mygithubpassword" \
                      BASIC_USER="admin" BASIC_PASSWORD="password"
    git push heroku master
```

Your credentials are protected since [Heroku's Piggyback SSL is now a platform feature](https://devcenter.heroku.com/changelog-items/10).

## Pivotal Tracker Integration

Assume:

* Your gh-pivotal-integration instance is deployed at `https://my.domain.com/` (e.g., https://random-name-1234.herokuapp.com)

* Your GitHub project lives at `https://github.com/USER/REPO` (e.g., https://github.com/me/awesomeproject)

### Configure gh-pivotal-integration as an External Tool

To create Stories in Pivotal Tracker from GitHub Issues using the `Other->GitHub Issues` menu item, you need to create an External Tool Integration.

In your Pivotal Tracker project:

1. Select the `Project->Configure Integrations` menu item
2. Select `Other` from `Create New Integration` dropdown menu
3. Complete the form:
  * **Name**: GitHub Issues (or whatever you want)
  * **Basic Auth Username**: `BASIC_USER` from above
  * **Basic Auth Password**: `BASIC_PASSWORD` from above
  * **Base URL**: https://github.com/
  * **Import API URL**: https://my.domain.com/issues/USER/REPO (e.g., https://random-name-1234.herokuapp.com/issues/me/awesomeproject)
4. Cick 'Save'

#### Label filtering support

You can provide a `labels` parameter with a comma separated list of labels to filter the issues. For example:
 * **Import API URL**: https://my.domain.com/gh-pivotal/issues/myaccount/reponame?labels=critic,ui

### Configure the Activity Web Hook

To allow GitHub to close an Issue automatically when the corresponding Pivotal Tracker Story is 'accepted', you need to tell Pivotal Tracker where to send details about the Story's activity.

In your Pivotal Tracker project:

1. Enter the **Web Hook URL**: https://my.domain.com/issues (e.g., https://random-name-1234.herokuapp.com/issues)
2. Click 'Save Web Hook Settings'


# Contributing to github-issues-pivotal-integration

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# Copyright

Copyright (c) 2012 Zauber. See LICENSE.txt for further details.
