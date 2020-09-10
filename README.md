# assay.it webhook

The action triggers quality assessment job at https://assay.it

## Usage

See [action.yml](action.yml)

Supported triggers:
* pull_request

```yaml
on: [pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: assay-it/github-actions-webhook@latest
        with:
          secret: ${{ secrets.ASSAY_SECRET_KEY }}
```
