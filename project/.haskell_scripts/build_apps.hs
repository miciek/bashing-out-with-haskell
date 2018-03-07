#!/usr/bin/env stack
-- stack --resolver lts-10.8 --install-ghc runghc --package turtle
{-# LANGUAGE OverloadedStrings #-}

import Prelude hiding (FilePath)
import Turtle
import Data.Time

main :: IO ()
main = void $ do
  version <- generateVersion
  echo $ "Building apps version: " <> repr version
  sh $ buildApps version

generateVersion :: IO Text
generateVersion = do
  now <- getCurrentTime
  return $ fromString $ formatTime defaultTimeLocale "%y%m%d%H%M%S" now

buildApps :: Text -> Shell ()
buildApps version = do
  appDirs <- getAppDirectories "."
  buildApp appDirs (fillVersion version)

fillVersion :: Text -> FilePath -> Shell ()
fillVersion version dir = void $ do
  paths <- lstree dir
  isFile <- testfile paths
  guard isFile
  inplace ("VERSION_PLACEHOLDER" *> return version) paths

getAppDirectories :: FilePath -> Shell FilePath
getAppDirectories root = do
  files <- ls root
  isAppDirectory <- testAppDir files
  guard isAppDirectory
  return files

testAppDir :: FilePath -> Shell Bool
testAppDir dir = do
  isDir <- testdir dir
  hasDockerfile <- testfile $ dir </> "Dockerfile"
  return $ isDir && hasDockerfile

buildApp :: FilePath -> (FilePath -> Shell ()) -> Shell ()
buildApp directory processFiles = void $ do
  echo $ "- building " <> repr directory
  tmpDir <- using (mktempdir "." "build")
  cptree directory tmpDir
  processFiles tmpDir
  shell (format ("tar -cvf "%fp%".tar.gz -C "%fp%" .") (filename directory) tmpDir) empty
