# GitHub User Search Web Application

Demonstrates how to use the [`graphql-client`](http://github.com/github/graphql-client) gem to build a simple user search and repository listing web view against the [GitHub GraphQL API](https://developer.github.com/v4/guides/intro-to-graphql/). I'd like to mention that this is my first project of this kind. I have never used/learned RubyOnRails before. Neither have I heard of GraphQL. So it is a first.

## Running locally

First, you'll need a [GitHub API access token](https://help.github.com/articles/creating-an-access-token-for-command-line-use) to make GraphQL API requests. This should be set as a `GITHUB_ACCESS_TOKEN` environment variable as configured in [config/secrets.yml](https://github.com/github/github-graphql-rails-example/blob/master/config/secrets.yml).
You'll need to modify in [app/controllers/repositories_controller.rb] the global variable and assign a string for the name that you want to search for. 
``` sh
$ bundle install
$ GITHUB_ACCESS_TOKEN=ABCD1234 rails server
```

**On  FIREFOX Browser This App DOESN'T WORK ON CHROME**:

visit [http://localhost:3000/](http://localhost:3000/).

## Running on Cloud AWS

visit http://qemotiontest-env.qi2dybs4xt.eu-west-3.elasticbeanstalk.com/

# Qemotion Internship's Mini-project
**Mission:**

- Search a Github User: **Done** *(list view of results is not available, only the first user from the search)*

- Show the list of all Repositories that the User contributes to:  **Done**

- Show the coding language used in ever Repository: **Done**

- Deploy project on AWS: **Done**, visit http://qemotiontest-env.qi2dybs4xt.eu-west-3.elasticbeanstalk.com/

  **in total : 4 out of 7 features demanded**

 **Time spent:** 4 Days at least, almost 30h of coding and documentations reading. (*99.99%  of my time spent on Ruby, bundle and gems version problems and debugging*) 

**To conclude:** In very short time I managed to develop this project, and experiment with RubyOnRails and other WebDev utilities . 

