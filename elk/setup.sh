source .env

# sudo apt install python3-pip
# pip install jinja2-cli

# elastic
mkdir -p $ELK_MAIN_HOST_FOLDER/elasticdata
mkdir -p $ELK_MAIN_HOST_FOLDER/elasticsearch/config
cp templates/elasticsearch/config/elasticsearch.yml $ELK_MAIN_HOST_FOLDER/elasticsearch/config
# kibana
mkdir -p $ELK_MAIN_HOST_FOLDER/kibana/config
cp templates/kibana/config/kibana.yml $ELK_MAIN_HOST_FOLDER/kibana/config
# nginx
mkdir -p $ELK_MAIN_HOST_FOLDER/nginx
cp templates/nginx/nginx.conf $ELK_MAIN_HOST_FOLDER/nginx/nginx.conf
cp templates/nginx/default.conf $ELK_MAIN_HOST_FOLDER/nginx/default.conf