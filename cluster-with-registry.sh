k3d registry create myregistry.localhost --port 12345
k3d cluster create --registry-use k3d-myregistry.localhost:12345 -p "8000:80@loadbalancer" -p "8001:80@loadbalancer" -p "8002:80@loadbalancer" -p "8003:80@loadbalancer" --agents 2
