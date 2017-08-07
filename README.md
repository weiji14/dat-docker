# Dat

Docker build of [Dat](https://github.com/datproject/dat) - the distributed data sharing tool.

## Pre-requisites

- [docker](https://www.docker.com/)
- [git](https://git-scm.com/) (only if building manually)

## Running the image

### Automated (recommended)

    TODO

### Manual

    git clone https://github.com/weiji14/dat.git
    cd dat
    docker build -f Dockerfile -t dat .
    
    # On Linux
    docker run --rm -it -v $PWD:/home/dat -u `id -u`:`id -g` -P dat
    
    
    :: On Windows
    docker run --rm -it -v %cd%:/home/dat -P dat

## Troubleshooting

Command to drop into the docker container's bash prompt

    docker run --rm -it -v $PWD:/home/dat -u `id -u`:`id -g` -P dat bash
    
    #Run dat doctor with debugging enabled
    DEBUG=dat* dat doctor
