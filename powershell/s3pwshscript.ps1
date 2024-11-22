# Import-Module AWS.Tools.s3

# $region = "us-east-1"

# $BucketName = Read-Host -Prompt 'Enter the S3 bucket name'

# Write-Host "AWS Region: $region"
# Write-Host "S3 Bucket: $BucketName"

# New-S3Bucket -BucketName $BucketName -Region $region


# function BucketExists {
#   $bucket = Get-S3Bucket -BucketName $BucketName -ErrorAction SilentlyContinue
#   return $null -ne $bucket
# }
# #Create a new file 

# $fileName = 'myfile.txt'
# $fileContent ='Hello World !'
# Set-Content -Path $fileName -Value $fileContent

# Write-S3Object -BucketName $BucketName -Value File $fileName -key $fileName


# Import AWS Tools Module
Import-Module AWS.Tools.S3

# Set AWS region
$region = "us-east-1"

# Prompt for S3 bucket name
$BucketName = Read-Host -Prompt 'Enter the S3 bucket name'

Write-Host "AWS Region: $region"
Write-Host "S3 Bucket: $BucketName"

# Check if bucket already exists
function BucketExists {
    $bucket = Get-S3Bucket -BucketName $BucketName -ErrorAction SilentlyContinue
    return $null -ne $bucket
}

if (BucketExists) {
    Write-Host "Bucket '$BucketName' already exists in region '$region'."
} else {
    # Create a new S3 bucket
    New-S3Bucket -BucketName $BucketName -Region $region
    Write-Host "Bucket '$BucketName' created successfully in region '$region'."
}

# Create a new file locally
$fileName = 'myfile.txt'
$fileContent = 'Hello World!'
Set-Content -Path $fileName -Value $fileContent

# Upload the file to S3
Write-S3Object -BucketName $BucketName -File $fileName -Key $fileName
Write-Host "File '$fileName' uploaded to bucket '$BucketName' successfully."
