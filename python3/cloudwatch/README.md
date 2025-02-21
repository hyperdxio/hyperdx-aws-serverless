# CloudWatch Logs Shipper - Lambda

This is an AWS Lambda function that collects CloudWatch logs and sends them to HyperDX in bulk over HTTP.

-   Option 1: [Manual Lambda configuration](#manual-lambda-configuration)
-   Option 2: [Automated CloudFormation deployment](#automated-cloudformation-deployment)

## Manual configuration with a Lambda function
  
#### 1. Create a new Lambda function

1. Open the AWS Lambda Console, and click **Create function**.
2. Choose **Author from scratch**.
3. In **Name**, add the log type to the name of the function.
4. In **Runtime**, choose **Python 3.9**.
5. Click **Create Function**.

After a few moments, you'll see configuration options for your Lambda function. You'll need this page later on, so keep it open.

#### 2. Zip the source files

Clone the CloudWatch Logs Shipper - Lambda project from GitHub to your computer,
and zip the Python files in the `src/` folder as follows:

```shell
git clone https://github.com/logzio/logzio_aws_serverless.git \
&& cd logzio_aws_serverless/python3/cloudwatch/ \
&& mkdir -p dist/python3/shipper; cp -r ../shipper/shipper.py dist/python3/shipper \
&& cp src/lambda_function.py dist \
&& cd dist/ \
&& zip logzio-cloudwatch lambda_function.py python3/shipper/*
```

#### 3. Upload the zip file and set environment variables

1. In the **Code source** section, select **Upload from > .zip file**.
2. Click **Upload**, and choose the zip file you created earlier (`logzio-cloudwatch.zip`).
3. Click **Save**.
4. Navigate to **Configuration > Environment variables**.
5. Click **Edit**.
6. Click **Add environment variable**.
7. Fill in the **Key** and **Value** fields for each variable as per the table below:

| Parameter                                  | Description                                                                                                                                                                                                                                                                                                                                    |
|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| TOKEN (Required)                           | The [Ingestion API Key](https://www.hyperdx.io/team) of the account you want to ship to.                                                                  |                                                                                                                                                                                     |
| TYPE                                       | The service name used to identify your service in the HyperDX app, it can be any name you want.                                                           |
| FORMAT (Default: `text`)                   | `json` or `text`. If `json`, the Lambda function will attempt to parse the message field as JSON and populate the event data with the parsed fields.      |
| ENRICH                                     | Enrich CloudWatch events with custom properties, formatted as `key1=value1;key2=value2`.                                                                  |
| REQUEST_TIMEOUT (Default: `15`)            | Timeout in seconds for each http request for sending logs into HyperDX.                                                                                   |

#### 4. Set the CloudWatch Logs event trigger

1. Find the **Add triggers** list (left side of the Designer panel) and choose **CloudWatch Logs** from this list.
2. In the **Log group** field, select the applicable log group.
3. Type a **Filter name** (required) and **Filter pattern** (optional).
4. Click **Add**, and then click **Save** at the top of the page.

#### 6. Check HyperDX for your logs

Give your logs some time to get from your system to ours, and then open [Kibana](https://app.logz.io/#/dashboard/kibana).

If you still don't see your logs, see [log shipping troubleshooting](https://docs.logz.io/user-guide/log-shipping/log-shipping-troubleshooting.html).


## Automated CloudFormation deployment

This is an AWS Lambda function that subscribes to the CloudWatch log groups and sends them to HyperDX in bulk, over HTTP.

#### 1. Start the automated deployment

To deploy this project, click the button that matches the region you wish to deploy your Stack to:

| REGION           | DEPLOYMENT                                                                                                                                                                                                                                                                                                                                                     |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `us-east-1`      | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-us-east-1.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)           |
| `us-east-2`      | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-us-east-2.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)           |
| `us-west-1`      | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-west-1#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-us-west-1.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)           |
| `us-west-2`      | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-us-west-2.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)           |
| `eu-central-1`   | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-central-1#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-eu-central-1.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)     |
| `eu-north-1`     | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-north-1#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-eu-north-1.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)         |
| `eu-west-1`      | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-eu-west-1.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)           |
| `eu-west-2`      | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-2#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-eu-west-2.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)           |
| `eu-west-3`      | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-3#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-eu-west-3.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)           |
| `sa-east-1`      | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=sa-east-1#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-sa-east-1.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)           |
| `ca-central-1`   | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=ca-central-1#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-ca-central-1.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)     |
| `ap-northeast-1` | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-northeast-1#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-ap-northeast-1.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper) |
| `ap-northeast-2` | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-northeast-2#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-ap-northeast-2.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper) |
| `ap-northeast-3` | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-northeast-3#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-ap-northeast-3.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper) |
| `ap-south-1`     | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-south-1#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-ap-south-1.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper)         |
| `ap-southeast-1` | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-southeast-1#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-ap-southeast-1.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper) |
| `ap-southeast-2` | [![Deploy to AWS](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-southeast-2#/stacks/create/review?templateURL=https://hyperdx-aws-integrations-ap-southeast-2.s3.amazonaws.com/cloudwatch-auto-deployment/1.0.0/sam-template.yaml&stackName=hyperdx-cloudwatch-shipper) |


#### 2. Specify stack details

Specify the stack details as per the table below, check the checkboxes and select **Create stack**.

| Parameter                                          | Description                                                                                                                                                                                                                             |
|----------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| hyperdxIngestionKey (Required)                            | The [Ingestion API Key](https://www.hyperdx.io/team) of the account you want to ship to.                                                              |
| logGroup\*                                                | CloudWatch Log Group name from where you want to send logs.                                                                                           |
| hyperdxServiceName                                        | The service name used to identify your service in the HyperDX app, it can be any name you want.                                                       |
| hyperdxFormat (Default: `text`)                           | `json` or `text`. If `json`, the Lambda function will attempt to parse the message field as JSON and populate the event data with the parsed fields.  |
| hyperdxEnrich                                             | Enrich CloudWatch events with custom properties, formatted as `key1=value1;key2=value2`.                                                              |
| requestTimeout  (Default: `15`)                           | Timeout in seconds for each http request for sending logs into HyperDX.                                                                               |

**Note:** You can find \*LogGroup in the title of the CloudWatch page for the log group that you want to export to HyperDX as shown below:

#### 3. Check HyperDX for your logs

Give your logs some time to get from your system to ours, and then open [Kibana](https://app.logz.io/#/dashboard/kibana).

If you still don't see your logs, see [log shipping troubleshooting](https://docs.logz.io/user-guide/log-shipping/log-shipping-troubleshooting.html).

## Changelog:
- **1.1.1.**:
  - Add configurable timeout for http requests.
  - Allow configuring log level for the shipper function.
  - Upgrade to python3.9.
- **1.1.0**:
  - Add support to send Lambda Insights from AWS to logz.io platform. [Resolved issue](https://github.com/logzio/logzio_aws_serverless/issues/73)  

- **1.0.0**:
  - **Breaking changes**:
    - For auto-detection of log level - log level will appear in upper case.
  - Lambda logs - send all logs include platform logs (START, END, REPORT).
  - Add `namespace` field to logs - service name based on the log group name.
  - Renaming of variables in Cloudformation template.
