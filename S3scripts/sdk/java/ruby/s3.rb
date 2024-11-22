require 'aws-sdk-s3'
require 'pry'
require 'securerandom'


# S3 Configuration
bucket_name =  ENV['Bucket_NAME']  # Replace with your unique S3 bucket name
region = 'us-east-1'                      # Your desired AWS region

# Initialize the AWS S3 Client
client= Aws::S3::Client.new

resp = client.create_bucket({
    bucket: bucket_name,
    create_bucket_configuration: {
        location_constraint: region 
    }
})
binding.pry
number_of_files = 1 + rand(6)
puts "number_of_files: #{number_of_files}"

number_of_files.time.each do |i|
    put "i: #{i}"
    filename = "file_#{i}.txt"
    output_path = "/tmp/#{filename}"

File.open(output_path, "w") do |f|
    f.write(SecureRandom.uuid)
end


File.open(output_path, 'rb') do |f|