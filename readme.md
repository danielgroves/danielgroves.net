# danielgroves.net Source

This is the source for the current version of my portfolio. This automatically pushed as I commit changes to the production branch. New features, content, and design changes are developed on private branches which are automatically pushed here when they are deployed.

My site has previously been a static site with no generator behind it and [WordPress](http://wordpress.org "WordPress Publishing Platform") based.

## Usage

Setting up and using the site is pretty easy. Make sure you have Ruby installed, and the bundler gem, then install the required gems. 

```bash
gem install bundler
bundle install
```

Then run using rake : `bundle exec rake watch`

Then simply go to [localhost:4000](http://localhost:4000) in your browser.

### Rake Tasks

Other rake tasks are:
* `versions` - Jekyll version number
* `watch` - Start the Jekyll server in watch mode with future and draft posts
* `serve` - Just serve the site. Normally used when I want to do regular manual builds. 
* `build` - Do a production build
* `build_all` - Do a build with all drafts and future posts
* `deploy` - Run a production build and deploy to the remote server

The `build` and `deploy` tasks use different configurations dependant on the branch they are run on. 
* The `master` branch uses `_config.yml` as a base, and overides settings with `_config_production.yml`. 
* The `new_design` branch uses `_config.yml` as a base, and overides settings with `_config_staging.yml`.
* All other branches use `_config.yml`.

### Deployment

I use rsync for deployment from a CI server. Full details can be found in the blog post about it, but ti's worth noting how you pass deployment information into rake. For this I use environmental variables, not having these commited keeps things secure and nobody else can see users, key pairs, or deployment locations. Secondly, it stops me from accidently deplying. 

As a second safeguard, you can only deploy from certain branches:
* `master` branch can be deployed, but only to production. 
* `new_design` branch can be deployed, but only to staging. 

Each of these servers has it's own environmental variable to pass deployment data to:
* `production` uses `PROD_REMOTE`
* `staging` uses `STAGE_REMOTE`

Both of these are used in the same way and should take in the details of the remote server as if calling rsync directly, for example: `bundle exec rake deploy PROD_REMOTE='user@production.com:/path/to/live' STAGE_REMOTE='user@staging.com:/path/to/staging/'` 

The output will inform you if you're on a non-deploy branch, otherwise it will output the rsync progress. 

## Licensing

The content and design have been bundled into one license and the code has been bundled into a second. Check below for details.

## The Content and Design

The content and design are licensed under [CC BY-NC-SA 3.0](http://creativecommons.org/licenses/by-nc-sa/3.0/ "Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License"). Essentially, this allows you to share content and to adapt (or build upon) my works, but not for commercial purposes and only if you share attribution and under the same license agreement.

## Photographs

The photographs used on this site are licensed under [CC BY-NC-ND 4.0](http://creativecommons.org/licenses/by-nc-nd/4.0/ "Create Commons Attribution-NonCommercial-NoDerivatives 4.0 International License"). Essentially this means that you cannot share any of this material for commercial purposes without prior permission, but you may share for non-commercial purposes with attribution as long as it has not been modified.

## The Code

The code is licensed under [MIT](http://opensource.org/licenses/MIT "MIT License Agreement"), therefore the following applies:

Copyright (c) 2013 Daniel Groves

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
