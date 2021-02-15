docker build -t swaiidan202/multi-client:latest -t swaiidan2021/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t swaiidan2021/multi-server:latest -t swaiidan2021/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t swaiidan2021/multi-worker:latest -t swaiidan2021/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push swaiidan2021/multi-client:latest
docker push swaiidan2021/multi-server:latest
docker push swaiidan2021/multi-worker:latest

docker push swaiidan2021/multi-client:$SHA
docker push swaiidan2021/multi-server:$SHA
docker push swaiidan2021/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=swaiidan2021/multi-server:$SHA
kubectl set image deployments/client-deployment client=swaiidan2021/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=swaiidan2021/multi-worker:$SHA