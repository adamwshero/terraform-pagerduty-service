{
    "app_id": "${app_id}",
    "authed_user": {
      "id": "${authed_user}"
    },
    "bot_user_id": "${bot_user_id}",
    "enterprise": "null",
    "incoming_webhook": {
      "channel": "${slack_channel}",
      "channel_id": "${slack_channel_id}",
      "configuration_url": "${configuration_url}",
      "endpoint_url": "${endpoint_url}"
    },
    "restrict": "any",
    "is_enterprise_install": "false",
    "notify_types": {
      "resolve": "${notify_resolve}",
      "trigger": "${notify_trigger}",
      "escalate": "${notify_escalate}",
      "acknowledge": "${notify_acknowledge}",
      "assignments": "${notify_assignments}",
      "annotate": "${notify_annotate}"
    },
    "ok": true,
    "referer": "${referer}",
    "scope": "app_mentions:read,channels:join,channels:manage,channels:read,chat:write,chat:write.public,commands,groups:read,groups:write,im:read,im:write,incoming-webhook,pins:write,team:read,users:read,workflow.steps:execute",
    "team": {
      "id": "${slack_team_id}",
      "name": "${slack_team_name}"
    },
    "token_type": "bot",
    "urgency": {
      "high": "${high_urgency}",
      "low": "${low_urgency}"
    }
  }