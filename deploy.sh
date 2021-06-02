docker build -t krassuss/multi-client:latest -t krassuss/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t krassuss/multi-server:latest -t krassuss/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t krassuss/multi-worker:latest -t krassuss/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push krassuss/multi-client:latest
docker push krassuss/multi-server:latest
docker push krassuss/multi-worker:latest
docker push krassuss/multi-client:$SHA
docker push krassuss/multi-server:$SHA
docker push krassuss/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=krassuss/multi-server:$SHA
kubectl set image deployments/client-deployment client=krassuss/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=krassuss/multi-worker:$SHA
