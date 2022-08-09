# Welcome to Myip documentation

## What is myip?
A “myip” is an easy to use app to get your external Internet IP address.  

This documentation provides two options for deploying myip application.

- [Jenkins Deployment](#jenkins-deployment-steps)

- [Manual Deployment](#manual-deployment-steps)

## JENKINS DEPLOYMENT STEPS

## Requirements
1. Make sure you have Jenkins up and running

## Deployment Steps 

1. Clone Fuchicorp myip repo `git@github.com:fuchicorp/myip.git` Open your Jenkins and follow the steps below to deploy.

2. To deploy this application make sure you have followed the steps from the [Jenkins global library](https://github.com/fuchicorp/jenkins-global-library). Please make sure you have a job to build and deploy so it will be auto-triggered. If you will check the structure of the repo you will find two files `JenkinsBuilder.groovy` and `JenkinsDeployer.groovy` for build and deploy  

NOTE: Jenkins is discovering tags and branches in order to deploy to below environments accordingly.

```
master > stage
version tag > prod
dev-feature > dev
qa-feature > qa
```

## MANUAL DEPLOYMENT STEPS
 
## Requirements
1. Make sure you have Docker installed
2. Make sure Terraform is install

## Deployment Steps 

1. First you will need to clone the repo 

```
git@github.com:fuchicorp/myip.git
```

2. After you clone you will need to get into `myip/deployments/docker` 

```
cd myip/deployments/docker
```

3. Next step login to you private repository using `docker login` command. In our case it is a Nexus, but before make sure your Nexus has white list IP of Bastion host. Change DOCKERHOST to you docker repo URL. Replace USERNAME and PASSWORD with your Nexus credentials.

```
docker login DOCKERHOST -u USERNAME -p PASSWORD
```
4. Now we need to build `myip` image and push it to our Nexus repository.

```
docker build -t docker.YOURDOMAIN.com/myip .  
docker push docker.YOURDOMAIN.com/myip:latest 
```
5. After successful build and push navigate to `~/myip/deployments/terraform/configurations` and choose environment from dev/qa/stage where you want to deploy your app and make changes with costume values to deploy app in particular environment

```
cd ~/myip/deployments/terraform/configurations/ENV/

```

6. Now inside this folder we will need to create and configure different enviroment configiration files `myip-ENV.tfvars` (such as: dev, qa, stage) with following configuration

```
deployment_name = “myip”                  # Deployment name
deployment_environment = “”               # Chose deployment environment for myip options:( dev, qa, stage, prod )
deployment_image = “”                     # Please provide name of image you build
credentials = “google-credentials.json”   # GCP service account file
google_domain_name = “”                   # Please provide your domain name
google_bucket_name = “”                   # Please provide your bucket name
google_project_id = “”                    # Please provide your project id

```

7. There is a script `set-env.sh` to create a remote backend that requieres your google account credetials and `GIT_TOKEN` enviroment variable to configure. Please copy your service account `google-credentials.json` file to `~/myip/deployments/terraform` folder and export GIT_TOKEN

```
export GIT_TOKEN='<YOUR GITHUB TOKEN>'
```

8. After you have configured all of the above, please run the following commands below to deploy myip.

```
source set-env.sh configurations/ENV/myip-ENV.tfvars
terraform apply -var-file $DATAFILE
```
NOTE: Make sure every time you changing deployment environment please run `source set-env.sh configurations/ENV/myip-ENV.tfvars` with proper *.tfvars file 

## How can I check myip app?
If you will navigate to your endpoints.

You should have exact same copy of these endpoints which means ENV.your-domain.com and application should respond
1. https://myip.YOURDOMAIN.com/ PROD 
2. https://stage.myip.YOURDOMAIN.com/ STAGE
3. https://qa.myip.YOURDOMAIN.com/ QA 
4. https://dev.myip.YOURDOMAIN.com/ DEV 

Enjoy your myip app!!!

If you are facing any issues please submit the issue here https://github.com/fuchicorp/myip/issues
