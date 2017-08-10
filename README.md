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

Image with golang installed:

```yaml
image_resource:
  type: docker-image
  source:
    repository: starkandwayne/concourse-go:1.8
```

Image with Java/Maven installed:

```yaml
image_resource:
  type: docker-image
  source:
    repository: starkandwayne/concourse-java:8
```
