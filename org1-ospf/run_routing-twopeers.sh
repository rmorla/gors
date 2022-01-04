ssh gors-B 'rm -rf ~/quagga'
scp -r ~/configs/quagga m-gors-B:~/.
./docker-prune.sh
./runremote.sh gors-B ./routing-twopeers.sh