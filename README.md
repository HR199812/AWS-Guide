## A text file containing AWS steps and procedures for everyone who wants to learn AWS or may be keep community updated with specific services and how to set them up for your need.

Mail me on: hritwik72@gmail.com if you want edit access.

Anyone who wants to share there knowledge are free to contribute.

## Let's get Started

### Setting up AWS server on an EC2 machine:-

```
#!/bin/bash

yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
cd /var/www/html
echo “<h1>Hi Testing machine working or not.</h1>” > index.html
```

To Allow incoming traffic from HTTP configure inbound rules inside Security Groups for the machine and add HTTP on port 80.
To ping the machine use ICMP-IPV4 inside inbound rule creation.

### To get intance metadata inside machine:-

Connect to instance using terminal
Use:- curl http://169.254.169.254/latest/metadata/NAMEOFTHEMETADATA

Note:- While creating an EC2 machine remember to create a new key pair in case you don't have old ones and keep them safe as they will be used to connect to the machine.

### Creating Custom AMI(Amzaon Machine Image)/Image:-

- Right Click on the EC2 machine you've and select "Image and Templates" inside which select create an Image.
- Give your image and description.

### What is an Elastic-IP?

Whenever you create a machine it has a public IP address which will change in case of machine stop and start. To keep it same always we use an Elastic IP with a little upper-hand cost ans this IP that don't change in such scenarios. This IP is reserved for you until you release it, afteer which you no longer will have the same IP but will get a new Elastic IP.
For More:- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html

### Placement Groups:-

Three Types of PG are there:-

- Cluster: All the instances are present in one Region, one AZ in same server rack(this gives you an upper hand to ask amazon to configure your rack according to your needs. Note: Only for this type of PG).
- Partition: All the instances are present in one Region, in muliple AZ in different server rack, may se some of them are in same rack and some in different racks.
- Spread: All the instances are present in one Region are spread accross different racks in different AZ.

### AWS S3:-

**To Create a bucket**:-

- Go to S3 dashboard and click on create new bucket.
- ACL enabling let's you edit access rules of S3 bucket through UI of ACL list permissions. If you've not enabled ACL then in that case you're the owner of the bucket and have to manage access thru S3 policies.
- Content level policies can be given thru permissions of each bucket object.
- Give name to your bucket and enable ACL's in case you want to connect to S3 using NodeJs and Lambda.
- To host a static website using S3 enable static website hosting, also enable access rules of CRUD operations of your build/html page.
- Using route 53 we can associate the html page ARN with our domain to access the webpage using the Domain which will redirect the routes internally and open the webpage.
- To connect to S3 using NodeJs install AWS-SDK into you NodeJs Project and use the following code to push files to S3.
- To generate logs of what is happening in the bucket create another bucket and in the current bucket add enable accessing server logs.
- To generate notifications create event notifications for the bucket inside the properties. 

### S3 Bucket Types:-
1. Amazon S3 Standard (S3 Standard)
2. Amazon S3 Intelligent-Tiering (S3 Intelligent-Tiering)
3. Amazon S3 Standard-Infrequent Access (S3 Standard-IA)
4. Amazon S3 One Zone-Infrequent Access (S3 One Zone-IA)
5. Amazon S3 Glacier Instant Retrieval
6. Amazon S3 Glacier Deep Archive
7. S3 on Outposts
For more info:- https://aws.amazon.com/s3/storage-classes/


**Code for S3 access using JS code**:-
```
const fs = require("fs");
const AWS = require("aws-sdk");
const s3 = new AWS.S3();

// const upload = async () => {
//   const params = {
//     ACL: "public-read",
//     Body: "hello world",
//     ContentType: "text/html",
//     Bucket: "test-bucket-for-demo",
//     Key: "file-from-lambda.txt",
//   };
// }

//   In Case if we have a file the
const fileName = "test.js";
const upload = async () => {
  const params = {
    ACL: "public-read",
    Body: await fs.readFileSync(`./${fileName}`),
    ContentType: "text/html",
    Bucket: "test-bucket-for-demo",
    Key: fileName,
  };

  return await new Promise((resolve, reject) => {
    s3.putObject(params, (err, results) => {
      if (err) reject(err);
      else resolve(results);
    });
  });
};

const main = async (event) => {
  console.log("Event:", event);
  return upload();
};
exports.handler = main;
```

### VPC(Virtual Private Cloud):-

A VPC is used to group your resources in an isolated section, where your resources can be from different AZ's in same region. To work with VPC's in different regions read:- https://docs.aws.amazon.com/devicefarm/latest/developerguide/amazon-vpc-cross-region.html.

### Route Table:-

A route tabe is a rule book which governs what all IP's are meant to go out and come inside the network by maintaining Inbound and Outbound rules.
**Blackhole:- When a route in Route Table is not pointing to any resource then it becomes a blackhole route.**

### Load Balancers:-

Load Balancers are used to distribute data amongst difference machines when the load is more than exepected load. The load amongst machines is distributed in so called "Target Groups".
**Target Groups:** Collections of EC2 machines grouped together to distribute the load amongst machines.

Two types of TG's:-

- **Application Load Balancers**:- This type of load balancer works on http/https/ssh protocol. It is used to distribute traffic of the application among different machines(EC2 machines) and uses a "Round Robin Alogrithm" for load distribution in the background. Machines can be in differenr AZ's and multiple targets.
- **Network Load Balancers**:- This type of load balancer works on tcp protocol. It is used to distribute traffic of the application among different machines to increase throughput and ensure low latency.

**Auto Scaling Groups**:- ASG's help to create a group of EC2 instances which have a minimum number of machines and a maximum number of machines that it can scale up to horizontaly and scaled down to minimum number of instances.
If in case number of EC2 instance get's less than the minimum threshold then ASG automatically spins off a new EC2 machine.

### S3 


### Event Bridge:
Event Driven Architecture helps developers to create a loosely-coupled architecture and also can help in acheiving microservices architure for a revamping a monolithic application or creating an application with microservices acting independently of each other.

Decoupled application can allow for more seamless team collaboration accross applications.

It consist of:
- Event Source: It is the application or service which is producing events. Can be one of the following or all: AWS Service, Custom Events, and SaaS App.
- Event Bus: Events are placed on events bus which then checks event rules that defines which target will be consuming an incoming event. It is of three types: Default, Custom, SaaS. 
- Event Targets: It is what consuming the event being sourced in the bus.
- Rules: Rules define which event to be sent to what kind of consumer as there can be tens,hundreds, and thousands of events consumed by event bridge.

- **Event**:- An event is something that will happen in your application, for eg: orderPlaced, itemPlacedInCart, etc. It contains JSON of what happened in your application.

- **Schemas in Event bridge** :- Schemas help in differentiating where the event came from as it contains{timestamp, structur of event, and where it came from} Schemas help developers develop applications based on the event to be consumed from the event bridge, also it helps schema creators to create schemas for AWS events(services), discovered schema, and custom schema.

### Create a docker in AWS(in this case it is MongoDb/Neo4J GraphDatabase):-

![image](https://user-images.githubusercontent.com/39455725/170764781-4984691d-cc16-4d18-b913-2bb1bdf0689e.png)
What is docker? Docker is a containerisation service on which we can host our apps instead of creating seperate servers. On AWS it is done using ECS(Elastic Containers Service) where a cluster can contain multiple services which are basically tasks that we create, in Leyman terms Cluster consists of a task which contains a container(docker container) that will host the application.

### Create a task under task configuration where create a mongodb container.

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

### Hosting an App on amplify

- Click new app and select host web app.
- Select version source control type you want to use.
- Select repo and branch for which you want to deploy the app.
- Inside build and test add paths to app libraries, app-root path as app root directory path, and build commands to run and build your app.
- In advnaced settings you can add envrionment variables required for the app, add version of tech on which your app will run.
- You can also use a docker image if you want.
- Click next, on review page review your settings and then complete the creation.
- First deployment will be triggered automatically.

# In my case I build an app for next js and therefore the code looks like this:
```
version: 1
applications:
  - frontend:
      phases:
        preBuild:
          commands:
            - npm i --force
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: .next
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
    appRoot: nike/shoe-carousel-3d/
```
