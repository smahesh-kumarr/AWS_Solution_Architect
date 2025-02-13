import json

def lambda_handler(event, context):
    print("Received event: ", json.dumps(event))
    
    message = event['Records'][0]['Sns']['Message']
    print(f"Received message from SNS: {message}")

    return {
        'statusCode': 200,
        'body': json.dumps("Message processed successfully!")
    }
