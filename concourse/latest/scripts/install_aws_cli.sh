#!/usr/bin/env bash

curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

echo "export PATH=\""/root/.pyenv/bin:\$PATH\""" >> ~/.profile
echo "eval \"\$(pyenv init -)\"" >> ~/.profile
echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.profile

source ~/.profile

pyenv update

pyenv install 2.7.8

echo "pyenv shell 2.7.8" >> ~/.profile

source ~/.profile

curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# cleanup
rm -rf awscli-* /tmp/*
