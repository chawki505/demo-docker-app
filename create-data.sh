cd demo-docker-app/

docker rm -vf postgres-srv

mkdir /mnt/btrfs/pg-data
docker run --name postgres-srv \
			-e POSTGRES_PASSWORD=mysecretpassword \
			-v /mnt/btrfs/pg-data:/var/lib/postgresql/data \
			-v `pwd`/scripts/users.sql:/opt/scripts/users.sql \
			-d postgres

echo 'Waiting for PG Up and Running'
CMD="docker exec -it postgres-srv pg_isready"
until $CMD; do
  sleep 2s
done

docker exec -it postgres-srv psql -U postgres -f /opt/scripts/users.sql
