# encoding: utf-8
begin
  HEROKU_AWS_S3 = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'aws_s3.yml'))[Rails.env]
rescue
  HEROKU_AWS_S3 = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'aws_s3.yml.example'))[Rails.env]
end
