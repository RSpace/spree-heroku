# encoding: utf-8
aws_s3_file = File.join(File.dirname(__FILE__), '..', 'aws_s3.yml')

if File.exists?(aws_s3_file)
  HEROKU_AWS_S3 = YAML.load_file(aws_s3_file)[Rails.env]
else
  HEROKU_AWS_S3 = {}
end