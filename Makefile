sync:
	hugo && rsync ~/Projects/relia.xyz/public/ root@107.173.129.241:/root/relia.xyz/ -avz --delete
