docker run -e AWS_PROFILE=suite-Developer@it-dev-apphosting -v ~/.aws:/root/.aws <your-image-name>


 'arn:aws:iam::349575748144:role/edanalytics-DeveloperRole-1J0AAS8JKFEIG'
The role may be accessed via the AWS profile: 'edanalytics-Developer@it-dev-apphosting'

E.g.

  aws cloudformation --profile=edanalytics-Developer@it-dev-apphosting update-stack ...



  docker-compose up -e AWS_PROFILE=edanalytics-Developer@it-dev-apphosting -v ~/.aws:/root/.aws 