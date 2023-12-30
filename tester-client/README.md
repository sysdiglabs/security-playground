# Build
docker buildx build --platform linux/amd64 -t manuelbcd/test-client:1.1 .

# Deploy test-client workload
kubectl apply -f deployment.yml

# Execute a job instance manually
kubectl create job --from=cronjob/client-cronjob clientjob -n default
