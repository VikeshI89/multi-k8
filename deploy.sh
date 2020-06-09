docker build -t vinbasek/multi-client:latest -t vinbasek/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vinbasek/multi-server:latest -t vinbasek/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vinbasek/multi-worker:latest -t vinbasek/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vinbasek/multi-client:latest
docker push vinbasek/multi-server:latest
docker push vinbasek/multi-worker:latest

docker push vinbasek/multi-client:$SHA
docker push vinbasek/multi-server:$SHA
docker push vinbasek/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=vinbasek/multi-server:$SHA
kubectl set image deployment/client-deployment client=vinbasek/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=vinbasek/multi-worker:$SHA