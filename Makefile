sync:
	hugo && rsync ~/Projects/relia.xyz/public/ root@149.129.53.3:/root/relia.xyz/ -avz --delete
