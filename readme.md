# danielgroves.net Source

This is the source for the current version of my portfolio. This automatically pushed as I commit changes to the production branch. New features, content, and design changes are developed on private branches which are automatically pushed here when they are deployed.

My site has previously been a static site with no generator behind it and [WordPress](http://wordpress.org "WordPress Publishing Platform") based.

## Usage

Setting up and using the site is pretty easy. Make sure you have Ruby install, install the Jekyll gem and then run the server. Once you have Ruby installed:

```bash
gem install bundler
bundle install
```

If you're going to use the Instagram support, specify the settings as environmental variables (`INST_CLIENT_ID="" INST_CLIENT_SECRET="" INST_USER_ID=""`) or append tot he configuration file:

```yaml
instagram:
    client_id: ""
    client_secret: ""
    user_id:
    min_timestamp: 2014-01-01T00:00:00+00:00
    max_timestamp: 2014-12-31T11:59:59+00:00
```

Timestamps should comply with the ISO8601 standard. The user id should be your user's instagram id, mine is a 10-digit integer. 

Then run using rake : `bundle exec rake watch`

Other rake tasks are:
* `versions` - Jekyll version number
* `watch` - Start the Jekyll server in watch mode with future and draft posts
* `build` - Do a production build
* `build_all` - Do a build with all drafts and future posts
* `deploy` - Run a production build and deploy to the remote server

To use the rake deploy task the `REMOTE` environmental variable should be set. This is the remote passed to `rsync`, and should take the following format: `REMOTE='user@example.com:/path/to/www/'`

Then simply go to [localhost:4000](http://localhost:4000) in your browser.

## Licensing

The content and design have been bundled into one license and the code has been bundled into a second. Check below for details.

### The Content and Design

The content and design are licensed under [CC BY-NC-SA 3.0](http://creativecommons.org/licenses/by-nc-sa/3.0/ "Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License"). Essentially, this allows you to share content and to adapt (or build upon) my works, but not for commercial purposes and only if you share attribution and under the same license agreement.

### Photographs

The photographs used on this site are licensed under [CC BY-NC-ND 4.0](http://creativecommons.org/licenses/by-nc-nd/4.0/ "Create Commons Attribution-NonCommercial-NoDerivatives 4.0 International License"). Essentially this means that you cannot share any of this material for commercial purposes without prior permission, but you may share for non-commercial purposes with attribution as long as it has not been modified.

### The Code

The code is licensed under [MIT](http://opensource.org/licenses/MIT "MIT License Agreement"), therefore the following applies:

Copyright (c) 2013 Daniel Groves

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
