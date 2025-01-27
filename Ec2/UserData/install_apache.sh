#!/bin/bash

# Update system package repository
echo "Updating system package repository..."
sudo yum update -y

# Install Apache (httpd)
echo "Installing Apache (httpd)..."
sudo yum install -y httpd

# Start Apache service
echo "Starting Apache service..."
sudo systemctl start httpd

# Enable Apache to start at boot
echo "Enabling Apache to start at boot..."
sudo systemctl enable httpd

# Create a custom HTML file
echo "Creating custom HTML file..."
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to My Website</title>
</head>
<body>
<h1>Hello, World!</h1>
<p>This is a custom HTML page served from my Apache server on EC2.</p>
</body>
</html>
EOF

# Restart Apache to apply changes
echo "Restarting Apache service..."
sudo systemctl restart httpd

# Display the status of Apache
echo "Apache service status:"
sudo systemctl status httpd
