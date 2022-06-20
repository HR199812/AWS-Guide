## A text file containing AWS steps and procedures for everyone who wants to learn AWS or may be keep community updated with specific services and how to set them up for your need

Anyone who wants to share there knowledge are free to contribute.

## Let's get Started

### Setting up AWS server on an EC2 machine:-

- #!/bin/bash
- Yum update -y
- Yum install httpd -y
- Systemctl start httpd
- Systemctl enable httpd
- Cd /var/www/html
- Echo “<h1>Hi Testing machine working or not.</h1>” index.html

To Allow incoming traffic from HTTP configure inbound rules inside Security Groups for the machine and add HTTP on port 80.
To ping the machine use ICMP-IPV4 inside inbound rule creation.

### To get intance metadata inside machine:-

Connect to instance using terminal
Use:- curl http://169.254.169.254/latest/metadata/NAMEOFTHEMETADATA

Note:- While creating an EC2 machine remember to create a new key pair in case you don't have old ones and keep them safe as they will be used to connect to the machine.

### Creating Custom AMI/Image:-
- Right Click on the EC2 machine you've and select "Image and Templates" inside which select create an Image.
- Give your image and description.

### Create a docker in AWS(in this case it is MongoDb/Neo4J GraphDatabase):-

![image](https://user-images.githubusercontent.com/39455725/170764781-4984691d-cc16-4d18-b913-2bb1bdf0689e.png)
What is docker? Docker is a containerisation service on which we can host our apps instead of creating seperate servers. On AWS it is done using ECS(Elastic Containers Service) where a cluster can contain multiple services which are basically tasks that we create, in Leyman terms Cluster consists of a task which contains a container(docker container) that will host the application.

### Create a task under task configuration where create a mongoldb container.

- To create a container we need an image which can be found at hub.docker.com=>Search (Image name)=> copy image name from “docker pull image”
- Add port number of the respective database, In case of MongoDb use 27017, in case of Neo4J use 7474.
- Read the document that whether we need any environment variable to be set up or not.
- Create the container and Create the task.

### Create a Cognito Pool:-

### Create SQS Service and Connect with NodeJs:-

- Go to SQS Dashboard and create a standard SQS service.
- Use URL from the dashboard:
- https://sqs.us-east-1.amazonaws.com/359836473094/CoreEngine-SQS-POC
- Here after .com/ is user id and /CoreEngine-SQS-POC is our SQS service name.
- Install AWS CLI in the system and install AWS-SDK in nodes project.
- Navigate to AWS user credentials page and get user ACCESS_KEY_ID, SECRET_ACCESS_KEY
- Add both of these in .env file, after this go to terminal(cmd in windows) and type $ aws configure
- AWS Access Key ID [None]: XXXXXXXXXXXXXXXXXX
- AWS Secret Access Key [None]: XXXXXXXXXXXXXXXXXX
- Default region name [None]: us-east-1
- Default output format [None]: json

### Create Lambda function and trigger it using AWS SQS:-

![image](https://user-images.githubusercontent.com/39455725/170765002-455b99b5-ac39-42d7-8c6d-d8e84818c35a.png)

- Create a role in IAM with access to Lambda and select permissions mentioned above.
- Create a basic SQS queue.
- Create a lambda function selecting nodes as runtime and select user roles where select the newly created role and create the function.
- Inside function triggers select SQS where you can use the SQS Queue you created in the previous step from the lookup and create trigger.

### Setup AWS-SDK CLI in system:-

Curl/install aws-sdk latest version mentioned on the website:-

- After install type:- “AWS Configure”
- Download ACCESS_KEY_ID & SECRET_KEY from your was IAM dashboard.
- Use them when asked in configuration setup.
- Add region of which you’re a user, in case of admin use any region
- In the last question type JSON.

### Setup AWS-Amplify in the system:-

- [ Remember to already have nodes installed in your device ]
- npm install -g @aws-amplify/cli
- Amplify configure
- Select region
- Create a user with permission of amplify-admin or add policy of admplify-admin to an existing user.
- Provide ACCESS_KEY_ID & SECRET_KEY for the same user.
- Add profile name or select default

### AWS-Location services inside amplify app

- use the following link to get along with the steps and procedures.
  https://github.com/HR199812/amplify-maps
