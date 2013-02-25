# New website for BerlinJS.org

## We're using Sass for CSS development

### Setup Sass

* `cd new-berlinjs.org`
* `gem install sass`
* `gem install listen rb-inotify` (optional but recommended)

### Make Sass compile your stylesheets

* `sass --watch stylesheets/styles.scss:_site/stylesheets/styles.css`

## Previewing and Jekyll

If you're editing only the CSS, you can open the local files under _site to preview.

If you're doing anything more involved, you'll want to run Jekyll.

### Setup Jekyll

* `cd new-berlinjs.org`
* `gem install jekyll`

### Build the site once

* `jekyll`

### Run Jekyll as a server listening to your changes

* `jekyll --server`

then browse to http://localhost:4000/
