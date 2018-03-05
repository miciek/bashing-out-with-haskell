# Bashing out with Haskell
This project contains example scripts for CI/CD environments that use Haskell instead of Bash/Python.

## Before you dive in
- Install [Stack](https://docs.haskellstack.org/en/stable/README/)
- See this [Turtle presentation](http://www.scs.stanford.edu/16wi-cs240h/slides/turtles-slides.html)

## Integration with CI tools
This repo doesn't show how to configure your CI tool to use Stack. If you use [Travis CI](https://travis-ci.org/) please have a look at [official Stack documentation](https://docs.haskellstack.org/en/stable/travis_ci/). Other CI solutions, like [Gitlab CI](https://about.gitlab.com/features/gitlab-ci-cd/) use custom Docker images to run jobs. Example image with Stack/Turtle can be found in [ci_runner Dockerfile](ci_runner/Dockerfile). 

## What's inside
- Run `stack repl` and just play around with [Turtle](https://hackage.haskell.org/package/turtle-1.5.3/docs/Turtle-Tutorial.html).
- Run `./hello.hs` and see what happens (+ have a look at other .hs scripts which present different use cases).
- Run `stack ghc -- -O2 hello.hs` to creative native binary and run it using `./hello`.
