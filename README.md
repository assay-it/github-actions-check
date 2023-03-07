# assay-it check action

This actions runs [assay-it](https://assay.it) to test cloud apps in production, confirm quality & eliminate risk.

## Usage

At its simplest, just add `assay-it/github-actions-check` as a step in your existing workflow. A minimal workflow might look like this:

```yaml
on: ["push", "pull_request"]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: assay-it/github-actions-check@latest
        with:
          system-under-test: "http://example.com"
```

See https://assay-it, it depicts a more advanced example that runs deployment, pull request checks, etc.