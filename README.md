# Brouwerij Wessie website

Jekyll source for https://brouwerijwessie.github.io/.

## Branches and deployment

- `master` contains the editable source, dependency manifests, and workflows.
- `gh-pages` contains the generated website. GitHub Pages publishes its root.
- Use `master` as the default branch so dependency scanning reads the source.
- Pull requests build and audit the site. A push to `master` publishes it.
- To republish manually, run `bash bin/deploy` (requires GitHub CLI login).

The workflow builds in a separate job with read-only repository access. Only the
publishing job can write the generated branch. It does not force-push or delete
the source checkout. Obsolete upstream Docker publishing workflows were removed.

## Local development

Use Ruby 3.4 (the CI patch version is recorded in `.ruby-version`) and ImageMagick.

```sh
bundle install
bundle exec jekyll serve
```

Open http://127.0.0.1:4000/. If that port is busy, add `--port 4001`.
To build the production website:

```sh
JEKYLL_ENV=production bash bin/cibuild
```

The optional Dockerfile uses the same Ruby series:

```sh
docker build -t wessie-site .
docker run --rm -p 4000:4000 wessie-site
```

## Dependency maintenance

`Gemfile.lock` is committed for reproducible builds on macOS and Linux. To update
Ruby dependencies deliberately, run `bundle update`, review the lockfile, and
build the site. The weekly Dependabot configuration targets `master` for Ruby
dependencies and GitHub Actions. Security updates should also be enabled in the
repository settings.

```sh
bundle exec bundler-audit check --update
```

The workflow runs this audit before publishing. Browser libraries are declared
in `_config.yml`; update their Subresource Integrity hashes together with their
versions. Bootstrap 4 and MDB remain coupled to the existing theme; their next
major upgrade requires a coordinated theme migration.

The unused upstream Medium feed, diagram, Twitter, JavaScript minification, and
container publishing integrations were removed. Responsive image generation is
preserved.
