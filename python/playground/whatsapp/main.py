from twilio.rest import Client
import sys

account_sid = '[ACCOUNT-SID]'
auth_token = '[AUTH_TOKEN]'

client = Client(account_sid, auth_token)

text = ''
recipient = 'whatsapp:[mobileNumber]'

if len(sys.argv) > 1:
    text = sys.argv[1]

if len(sys.argv) > 2:
    recipient = 'whatsapp:' + str(sys.argv[2])

message = client.messages.create(
    from_='whatsapp:[sandboxTwilioNr]',
    body=text,
    to=recipient
)

print("Id:" + message.sid)
print("Text:" + text)
