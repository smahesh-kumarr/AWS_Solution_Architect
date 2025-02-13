aws sns publish --topic-arn <SNS_TOPIC_ARN> \
  --message '{"first_name": "John", "second_name": "Doe"}' \
  --message-structure json