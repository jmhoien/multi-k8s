docker build -t jmhoien/multi-client:latest -t jmhoien/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jmhoien/multi-server:latest -t jmhoien/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jmhoien/multi-worker:latest -t jmhoien/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jmhoien/multi-client:latest
docker push jmhoien/multi-server:latest
docker push jmhoien/multi-worker:latest

docker push jmhoien/multi-client:$SHA
docker push jmhoien/multi-server:$SHA
docker push jmhoien/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jmhoien/multi-client:$SHA
kubectl set image deployments/server-deployment server=jmhoien/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jmhoien/multi-worker:$SHA
