## Python

1. go to directory

   `cd ../plutoIngest/docker/python`  

2. build image  

`docker build --tag [<name-your-image>] .`

3. bash into container  

```
docker run \
   --rm -it -v $(pwd):/usr/src/app \
   --entrypoint \
   bash python-gcloud
```

## Jupyter

- same image as python except it runs a jupyter lab instance

1. go to directory

   `cd ../plutoIngest/docker/jupyter` 

2. build image  

`docker build --tag [<name-your-image>] .`

3. run container  

`docker run --publish 9999:8888 [<image-name>]`

4. your terminal will give you an address that look like  
    `http://127.0.0.1:8888/lab?token=<token>`  
   you actually want to go to   
   `http://127.0.0.1:9999/lab?token=<token>`
   
[Aly Sivji's tutorial on youtube is very helpful](https://www.youtube.com/watch?v=oO8n3y23b6M)


```
docker run \
   -p 9999:8888 \
   -v $(pwd):/app \
   tfarley10/jupyter
   ```
   
    