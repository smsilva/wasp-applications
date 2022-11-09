### Note, defaults of the chart changed
Now, the chart has two jobs configured and integration filters turned on by default:
- `default` scrapes all targets having `prometheus.io/scrape: true`. By default, `integrations_filter.enabled=true`, unless changed, only targets selected by the integration filters will be scraped.
- `newrelic` scrapes all targets having `newrelic.io/scrape: true`. This is useful to extend the `default` job allowlisting by adding the required annotation on each extra service.

### 🚀 Enhancements
- `integration filters` option, is now supported and enabled by default.