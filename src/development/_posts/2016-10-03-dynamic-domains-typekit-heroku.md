---
published: true
title: Dynamic Domains with TypeKit and Heroku Review Apps
excerpt:
date: 2016-05-12 07:00
tags: development heroku typekit
---

As part of a recent effort to improve the feedback cycle on this website I decided to move the site onto Heroku. Moving to Herku allows me to take advantage of their [Review Apps][] to automatically deploy branches to their infrastructure on temporary URLs. Doing this removes the need of technical knowledge and reduces the effort involved for friends, family and co-workers to view and feedback on new features and posts I'm working on.

This feature works well - Heroku is linked to the [GitHub repository][] for this site and automatically triggers a new deploy on a free Dyno when I submit a pull request. The status of the deployment, as well as the public link, are all shown inline for the PR, and the branch-deployment is automatically destroyed when the branch is closed.

The problem with this setup is TypeKit required domains to be whitelisted, but blocks `*.herokuapp.com` from being whitelisted. To get around this we need to dynamically add the domain when a new review app is deployed, and remove it when destroyed. This allows for applications to be reviewed in a state that is as close as possible to the live environment.

- Need the correct type for full testing
- Makes what those reviewing see closer to production

## How
- Based on environment
- Call out to Typeset API
- Use build/teardown

## Conclusion
- Possible other uses
- works well
- Site now on Heroku

[review_apps]: https://devcenter.heroku.com/articles/github-integration-review-apps
