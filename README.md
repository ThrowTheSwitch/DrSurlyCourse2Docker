# Dr. Surly’s School for Mad Scientists: Interaction Tests, Mocks & Refactoring in Embedded Software Docker Image
Unit testing environment with ARM cross compiler, Unity, CMock, Ceedling, and Qemu emulator

## Contents
* Testing tools
  * Ceedling 0.29.1
  * CMock 2.5.1
  * Unity 2.5.0
* Environment
  * arm-none-eabi-gcc 6.3.1
  * Ruby 2.4.9
  * QEMU 1.1.2 (modified)
* Course project

## Build

The project image is layered atop a base image. The project image contains the potentially changeable content of the testing tools and the project materials. If future content updates are necessary this produces a slim `docker pull` operation for students.

The base docker image contains the heavyweight, unchanging tools — gcc toolchain, Ruby, and our customized Qemu. All these are built from scratch or installed by package manager during image build. To limit the download size for students, this image should be squashed.

If the base image changes, it must be rebuilt first and then the project image must be rebuilt. If only the project image changes, only it must be rebuilt.

### Base Docker Image

Because of the Docker `--squash` option, this image must be built locally, manually tagged, and pushed to Docker Hub. Automated Docker Hub builds do not support the `--squash` option.

1. Update Dockerfile and/or assets.
1. Build locally… `./build/base/run.sh`
1. Tag locally `docker image tag throwtheswitch/drsurly-course2-base throwtheswitch/drsurly-course2-base:[tag]`
1. `docker push throwtheswitch/drsurly-course2-base:[tag]`

### Project Docker Image

1. Update Dockerfile and/or assets. If base image has changed, be sure to update the tagged version of the base image at the top of build/release/Dockerfile before building the project image.
1. For a local build… `./build/release/run.sh`. Local builds are optional or for development work. Ultimately, this build is automated at Docker Hub for tagging and release, triggered by Github commits.

## Usage

`docker run -it --rm -v <local project path>:/lab throwtheswitch/drsurly-course2[:tag]`

