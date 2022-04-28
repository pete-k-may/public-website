# public-website
Terraform exercise

## Security note
- I have omitted apply certificates to implement TLS to the container for the sake of simplicity

## Architecture
- I have assumed that the VPC, subnets and load balancer have already been created elsewhere
- I would use a private subnet with a route to an internet gateway