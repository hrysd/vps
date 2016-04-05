# VPS

## Requirements

- direnv

## How to

```shell
$ cp .envrc.example .envrc
$ bundle install

# apply to vagrant
$ be itamae ssh -h alpha --vagrant roles/web.rb -y node.yml
```
