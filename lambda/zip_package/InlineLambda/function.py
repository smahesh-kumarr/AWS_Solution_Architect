import json
import logging

def handler(event, context):
    first_name = event.get('first_name', 'User')
    last_name = event.get('last_name', '')

    message = f'Hello {first_name} {last_name}!'
    
    x = {
        "Type": "Zip Inline",
        "Version": 1,
    }
    
    info_json = json.dumps(x)
    logging.info(info_json)  # Better logging

    return {
        'message': message,
        'info': x  # Optional: Return extra data
    }
