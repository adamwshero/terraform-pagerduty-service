## pagerduty-v1.0.5 (May 27, 2022)

BUG:
* PagerDuty integration key was not found (typo)
* Removed alert grouping options for now as these were breaking depending on what PagerDuty plan you have.
* Added `endpoint_url` property to the `pagerduty_extension` resource that uses the webhook url variable in the event a webhook type other than "Slack .." is being used. When non-Slack webhooks are used, this property is required.

CHORE:
* Alert grouping options have been deprecated to a separate code block. We will re-introduce this soon with a toggle to enable or disable depending on if your PagerDuty support plan allows it.
* Improved instructions/examples/readme
* Removed default prefix for SNS topic, now is empty.

EHANCEMENT:
* Made schema webhook a variable to accommodate all webhook types (Slack V2, Generic Webhook, Generic Webhook V1, etc.)

## pagerduty-v1.0.4 (February 24, 2022)

CHORE:
* Added descriptions to outputs.
## pagerduty-v1.0.3 (February 24, 2022)

CHORE:
* Corrected typo for pd_subscription

## pagerduty-v1.0.2 (February 24, 2022)

CHORE:
* Set resource attributes to best practices

## pagerduty-v1.0.1 (February 24, 2022)

* Updated README
* Added CHANGELOG
* Cleaned up variables

## pagerduty-v1.0.0 (February 21, 2022)

INITIAL:

* Initial module creation
* Added README