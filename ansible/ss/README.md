setup an shadowsocks server (autogen config)

```console
$ ansible-playbook ss.yml -M lib -e "PORT=23423"
```

provided **aws.tf** can be used to create an aws ec2 instance (pass keys
use env or use .aws/credentials)

currently debian.yml and aws.tf are not complete.
