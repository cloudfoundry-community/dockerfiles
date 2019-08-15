Docker Files
============

This repository houses our Docker image definitions.

Common base image:

```yaml
image_resource:
  type: docker-image
  source:
    repository: starkandwayne/concourse
```

Image with Go installed:

```yaml
image_resource:
  type: docker-image
  source:
    repository: starkandwayne/concourse-go:1.12
```

Image with Java/Maven installed:

```yaml
image_resource:
  type: docker-image
  source:
    repository: starkandwayne/concourse-java:11
```

Image with Ruby installed:

```yaml
image_resource:
  type: docker-image
  source:
    repository: starkandwayne/concourse-ruby:2.6
```

Image with Node installed:

```yaml
image_resource:
  type: docker-image
  source:
    repository: starkandwayne/concourse-nodejs:10
```
