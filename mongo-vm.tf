# Spin up MongoDB instance
resource "aws_instance" "mongodb_vm" {
  ami           = "ami-0b0ea68c435eb488d"  # Canonical, Ubuntu, 16.04 LTS, amd64 xenial image build on 2021-09-28
  instance_type = "t2.micro"               # Free tier
  availability_zone = var.dev1_subnet_az
  key_name      = "main-key"         
  subnet_id     = aws_subnet.dev1-subnet.id

  # Installing MongoDB 6.0, released 05072022 - still has LTS for xenial 16.04 - ended up going with 2.6
  # user_data = <<-EOF
  #           #!/bin/bash

  #           #import public key
  #           sudo apt-get install gnupg curl -y
  #           curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
  #             sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg \
  #             --dearmor

  #           #create list file
  #           echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

  #           #reload local package db
  #           sudo apt-get update -y

  #           #install mongodb 6.0.8 packages
  #           sudo apt-get install -y mongodb-org=6.0.8 mongodb-org-database=6.0.8 mongodb-org-server=6.0.8 mongodb-org-mongos=6.0.8 mongodb-org-tools=6.0.8

  #           #hold packages at current version
  #           echo "mongodb-org hold" | sudo dpkg --set-selections
  #           echo "mongodb-org-database hold" | sudo dpkg --set-selections
  #           echo "mongodb-org-server hold" | sudo dpkg --set-selections
  #           echo "mongodb-mongosh hold" | sudo dpkg --set-selections
  #           echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
  #           echo "mongodb-org-tools hold" | sudo dpkg --set-selections

  #           #start and enable mongodb
  #           sudo systemctl start mongod
  #           sudo systemctl enable mongod
  #           EOF

  tags = {
    Name = "mongodb"
  }
}

