#! /bin/bash
set +x

if [ -z ${ACCESS_KEY} ]
then
    echo 'Error: $ACCESS_KEY not set'
    exit 1
fi

if [ -z ${SECRET_KEY} ]
then
    echo 'Error: $SECRET_KEY not set'
    exit 2
fi

/opt/bitnami/kubectl/bin/kubectl patch -f job.yml --type=json -p \
    "[{\"op\": \"add\", \"path\": \"/spec/template/spec/containers/0/env\", \"value\": [{\"name\": \"ACCESS_KEY\", \"value\": \"$ACCESS_KEY\"}, {\"name\": \"SECRET_KEY\", \"value\": \"$SECRET_KEY\"}]}]" \
    -o yaml --dry-run=client > patched.yml
