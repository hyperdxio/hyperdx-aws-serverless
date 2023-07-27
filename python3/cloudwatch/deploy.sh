# bin/bash

VERSION="1.0.1"
ORIGINAL_TEMPLATE_FILE_PATH="./sam-template.yaml"
LOG_SHIPPER_ZIP_FILE_PATH="./dist/hyperdx-cloudwatch-log-shipper.zip"
AWS_REGIONS=(
  "us-east-1"
  "us-east-2"
  "us-west-1"
  "us-west-2"
  "eu-central-1"
  "eu-west-1"
  "eu-west-2"
  "eu-west-3"
  "sa-east-1"
  "ca-central-1"
  "ap-northeast-1"
  "ap-northeast-2"
  "ap-northeast-3"
  "ap-south-1"
  "ap-southeast-1"
  "ap-southeast-2"
)

for region in "${AWS_REGIONS[@]}"
do
  bucket_name="hyperdx-aws-integrations-$region"

  # make bucket public
  echo "Creating bucket $bucket_name in $region"
  aws s3api create-bucket --bucket $bucket_name --region $region --create-bucket-configuration LocationConstraint=$region
  aws s3api put-public-access-block --bucket $bucket_name --public-access-block-configuration BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false
  # add bucket policy to make the file public read
  aws s3api put-bucket-policy --bucket $bucket_name --policy "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"AddPerm\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"s3:GetObject\",\"Resource\":\"arn:aws:s3:::$bucket_name/*\"}]}"
  echo "Bucket $bucket_name created in $region"

  # fill <<VERSION>> and <<REGION>> in the template file and save it to a temp file
  echo "Creating template file for $region"
  sed -e "s/<<VERSION>>/$VERSION/g" -e "s/<<REGION>>/$region/g" $ORIGINAL_TEMPLATE_FILE_PATH > /tmp/sam-template.yaml
  TEMPLATE_FILE_PATH="/tmp/sam-template.yaml"

  # upload files to the bucket
  echo "Uploading files to $bucket_name"
  aws s3 cp $TEMPLATE_FILE_PATH s3://$bucket_name/cloudwatch-auto-deployment/$VERSION/sam-template.yaml
  aws s3 cp $LOG_SHIPPER_ZIP_FILE_PATH s3://$bucket_name/cloudwatch-auto-deployment/$VERSION/hyperdx-cloudwatch-log-shipper.zip
done
