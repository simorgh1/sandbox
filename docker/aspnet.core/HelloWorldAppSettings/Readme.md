#### HelloWorld aspnet.core with ConfigMap

This sample reads the appsettings.json from kubernetes ConfigMap

Step 1: Build the docker image

```
PS C:\HelloWorldAppSettings\src> docker build -t helloworld-appsettings:dev .

```

Step 2: Deploy the appsettings.json to kubernetes ConfigMap:

```
PS C:\HelloWorldAppSettings\.k8s> kubectl create cm appsettings.json --from-file=appsettings.json
PS C:\HelloWorldAppSettings\.k8s> kubectl describe cm appsettings.json

```

Step 3: Apply the deployment:

```
PS C:\HelloWorldAppSettings\.k8s> kubectl create -f .\helloworldappsettings.deployment.yaml --save-config
```

Step 4: port-forward the pod and open the application:

```
PS C:\HelloWorldAppSettings> kubectl get pod
NAME                          READY   STATUS    RESTARTS   AGE
helloworld-7b749c5d74-7knk7   1/1     Running   0          11m

PS C:\HelloWorldAppSettings> kubectl port-forward helloworld-7b749c5d74-7knk7 8080
```

Then goto: http://localhost:8080

#### Cleanup

Remove the deployment the related ConfigMap

```
PS C:\HelloWorldAppSettings\.k8s> kubectl delete -f .\helloworldappsettings.deployment.yaml
PS C:\HelloWorldAppSettings\.k8s> kubectl delete cm appsettings.json

```