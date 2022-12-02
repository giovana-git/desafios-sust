import boto3

client_sns = boto3.client('sns')

def publish_message():
    response = client_sns.publish(
        TopicArn='arn:aws:sns:us-east-2:005826485020:email-lambda', 
        Message='Algum de seus Security Groups está aberto para o mundo! Verifique a sua conta imediatamente.', 
        Subject='Alerta - Security Groups',)
            

open_rules = '0.0.0.0/0'

region = 'us-east-2'

exFromPort = 'FromPort'
exToPort = 'ToPort'
region = 'us-east-2'

client = boto3.client('ec2')

def lambda_handler(event, context):
    response = client.describe_security_groups(
        GroupIds=[
            'sg-0e9b3b61c21b19490',
            'sg-054d9ba5c26d32da2'
            
        ],

    )

    groupId = ['sg-0e9b3b61c21b19490', 'sg-054d9ba5c26d32da2']
    groupName = ['sgterraform-vpc-cluster', 'sgterraform-vpc-1']
    CidrIp = ''
    
    for sg in response["SecurityGroups"]:
        groupId = sg['GroupId']
        groupName = sg['GroupName']
        
        for ip in sg['IpPermissions']:
            if exFromPort in ip:
                fromPort = ip['FromPort']
                ipProtocol = ip['IpProtocol']
                toPort = ip['ToPort']
                        
                for cidr in ip['IpRanges']:
                    if cidr['CidrIp'] == open_rules:
                        print(ip)
                        print(sg)
                        publish_message()