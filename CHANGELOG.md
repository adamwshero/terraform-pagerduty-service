## 2.0.1 (November 7, 2023)

BUG:
* Allow DataDog Integration To Be Optional

## 2.0.0 (November 7, 2023)

BREAKING CHANGE:
* Pinned pagerduty provider to 3.1.1

FEATURE:
* Added support for intelligent grouping (dynamic block)
* Added support for DataDog integration

CHORE:
* Improved examples

## 2.0.0 (October 14, 2022)

FEATURE:
* Supports Slack Connections (teams or services)

CHORE:
* Added outputs for Slack Connections
* Added outputs for Maintenance Windows
* Improved examples

## 1.1.0 (September 27, 2022)

CHORE:
* Updated pinned "PagerDuty/pagerduty" provider to 2.6.2
* Added outputs for Slack Extension
* Added outputs for Service Integration
* Updated all examples
* Added examples for many scenarios
* Expanded README

ENHANCEMENT: (BREAKING CHANGES!)
* Simplified incident_urgency and scheduled actions map variables
* Removed Extension configuration from module and into input block (templatefile) for more control.
* Added option to disable/enable Slack extension
* Added option to disable/enable Service integration
* Added option to disable/enable SNS Topic
* Removed hard-coded "CloudWatch" vendor integration. Allowed to be dynamic input now.
* Renamed `shema_webhook` variable to `schema_name`

FEATURE:
* Support for one or many maintenance windows.

## 1.0.10 (June 6, 2022)

ENHANCEMENT:
* Added support for optional `incident_urgency_rule`, `support_hours`, & `scheduled_actions`.

CHORE:
* Added outputs for PagerDuty URL, Id, and SNS Topic ARN.

## 1.0.9 (June 3, 2022)

CHORE:
* Updated PagerDuty Service provider to v2.5.0

## 1.0.8 (May 27, 2022)

CHORE:
* Added description property to the PagerDuty service.

## 1.0.7 (May 27, 2022)

CHORE:
* Added required field values in readme.

## 1.0.6 (May 27, 2022)

CHORE:
* Added default values back to readme.

## 1.0.5 (May 27, 2022)

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

## 1.0.4 (February 24, 2022)

CHORE:
* Added descriptions to outputs.
## 1.0.3 (February 24, 2022)

CHORE:
* Corrected typo for pd_subscription

## 1.0.2 (February 24, 2022)

CHORE:
* Set resource attributes to best practices

## 1.0.1 (February 24, 2022)

* Updated README
* Added CHANGELOG
* Cleaned up variables

## 1.0.0 (February 21, 2022)

INITIAL:

* Initial module creation
* Added README