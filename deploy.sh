docker build -t endryha/multi-client:latest -t endryha/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t endryha/multi-server:latest -t endryha/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t endryha/multi-worker:latest -t endryha/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push endryha/multi-client:latest
docker push endryha/multi-server:latest
docker push endryha/multi-worker:latest

docker push endryha/multi-client:$SHA
docker push endryha/multi-server:$SHA
docker push endryha/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=endryha/multi-client:$SHA
kubectl set image deployments/server-deployment server=endryha/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=endryha/multi-worker:$SHA