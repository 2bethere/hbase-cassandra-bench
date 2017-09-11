sudo yum install -y vim git java java-devel wget


sudo mkfs.ext4 -E nodiscard /dev/nvme0n1
sudo mkdir /mnt/data
sudo mount -o discard /dev/nvme0n1 /mnt/data

sudo blockdev --setra 1024 /dev/xvda
sudo blockdev --setra 1024 /dev/xvda1


sudo useradd cassandra
sudo chown -R cassandra:cassandra /mnt/data
sudo -u cassandra mkdir /mnt/data/commitlog
sudo -u cassandra mkdir /mnt/data/saved_cache
