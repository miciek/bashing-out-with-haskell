#!/usr/bin/env stack
-- stack --resolver lts-10.8 --install-ghc runghc --package turtle
{-# LANGUAGE OverloadedStrings #-}

import Prelude hiding (FilePath)
import Turtle

main :: IO ()
main = sh $ do
  echo "Building images"
  archive <- findAppArchives "."
  buildImage archive
  rm archive

buildImage :: FilePath -> Shell ()
buildImage archivePath = void $ do
  tmpDir <- mktempdir "." "tmp"
  shell (format ("tar zxf "%fp%" -C "%fp) (filename archivePath) tmpDir) empty
  True <- testAppDir tmpDir
  echo $ "- building Docker image for " <> repr archivePath
  shell (format ("docker build -t app-"%fp%" "%fp) (basename archivePath) tmpDir) empty

findAppArchives :: FilePath -> Shell FilePath
findAppArchives = find $ suffix ".tar.gz"

testAppDir :: FilePath -> Shell Bool
testAppDir path = do
  isDir <- testdir path
  hasDockerfile <- testfile $ path </> "Dockerfile"
  return $ isDir && hasDockerfile
