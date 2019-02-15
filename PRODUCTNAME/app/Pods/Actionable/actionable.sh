#!/bin/bash

SOURCERY_PATH=$PODS_ROOT/Sourcery/bin/sourcery
ACTIONABLE_PATH=$(dirname $0)
ACTIONABLE_SWIFT_FILE=$ACTIONABLE_PATH/Sources/Actionable.swift
ACTIONABLE_TEMPLATES_DIR=$ACTIONABLE_PATH/Resources/
declare -a INPUT_FILES=()
INPUT_STRING=""

while getopts "i:o:" opt; do
  case ${opt} in
    i )
      INPUT_FILES+=("$OPTARG")
    ;;
    o )
      OUTPUT_FILE=$OPTARG
    ;;
    \? )
      echo "Actionable usage: cmd [-i] [-o]"
      exit 1
    ;;
  esac
done

if [ ${#INPUT_FILES[@]} -eq 0 ]; then
  echo "Error: Actionable input file not specified [-i]"
  exit 1
fi

if [ -z $OUTPUT_FILE ]; then
  echo "Error: Actionable output file not specified [-o]"
  exit 1
fi

for INPUT_FILE in "${INPUT_FILES[@]}";
do
  INPUT_STRING="$INPUT_STRING --sources $INPUT_FILE"
done

$SOURCERY_PATH $INPUT_STRING --sources $ACTIONABLE_SWIFT_FILE --templates $ACTIONABLE_TEMPLATES_DIR --output $OUTPUT_FILE
