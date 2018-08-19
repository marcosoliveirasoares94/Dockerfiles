#!/bin/bash -xe

NAMESPACE=marcosoliveirasoares94

PUBLISH=true

ROOT_DIRECTORY=`pwd`

if [[ -z $ARRAY_PATH_DIRECTORY ]]; then
  ARRAY_PATH_DIRECTORY="debian"
fi

function build_repository {
    
    source $ROOT_DIRECTORY/$PATH_DIRECTORY/buildvars

    for DIRECTORY_IMAGE in $ARRAY_DIRECTORY_IMAGE; do

      source $ROOT_DIRECTORY/$PATH_DIRECTORY/$DIRECTORY_IMAGE/buildvars
    
        echo $'\n\n'"--> Building $NAMESPACE/$DIRECTORY_IMAGE:$TAG"$'\n'
        cd $ROOT_DIRECTORY/$PATH_DIRECTORY/$DIRECTORY_IMAGE
        docker build -t $NAMESPACE/$DIRECTORY_IMAGE:$TAG .

        echo $'\n\n'"--> Aliasing $LATEST as 'latest'"$'\n'
        docker tag $NAMESPACE/$DIRECTORY_IMAGE:$LATEST $NAMESPACE/$DIRECTORY_IMAGE:latest

        if [ $PUBLISH == true ]; then
          
          echo $'\n\n'"--> Publishing $NAMESPACE/$DIRECTORY_IMAGE:$TAG"$'\n'    
          docker push $NAMESPACE/$DIRECTORY_IMAGE:$TAG

          echo $'\n\n'"--> Publishing $NAMESPACE/$DIRECTORY_IMAGE:latest (from $LATEST)"$'\n'
          docker push $NAMESPACE/$DIRECTORY_IMAGE:latest

        fi
    done
}

for PATH_DIRECTORY in $ARRAY_PATH_DIRECTORY; do
  build_repository $PATH_DIRECTORY
done
