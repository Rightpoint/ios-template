#!/usr/bin/env bash

# This is a shell script to transform the PRODUCTNAME directory into a cookie-cutter template

# Environmental variable options accepted by `generate_template.sh`:

# * `VERBOSE=true`: Prints more verbose output.
# * `SKIP_REGENERATION=true`: Does not alter the generated cookiecutter template.
# * `SKIP_TESTS=true`: Does not perform tests after generating template.
# * `KEEP_COOKIECUTTER_OUTPUT=true`: Do not delete cookiecutter output after running tests (final output is in `ProjectName` directory).
# * `OUTPUT_DIR`: Use a different output directory (default is current directory)


set -e
set -o pipefail

# Run this script in its own directory
SCRIPT_DIR="$(dirname $0)"
cd $SCRIPT_DIR

echo "Regenerating cookiecutter template from PRODUCTNAME directory contents..."

#This is the only lookup that is done on filenames
LOOKUP="PRODUCTNAME"
EXPANDED="{{ cookiecutter.project_name | replace(' ', '') }}"

if [ ! -z "$OUTPUT_DIR" ] ; then
    echo "Using output directory: $OUTPUT_DIR"
    mkdir $OUTPUT_DIR
    cp -rf "$LOOKUP" "$OUTPUT_DIR/$LOOKUP"
    cp cookiecutter.json "$OUTPUT_DIR/"
    if [ "${SKIP_REGENERATION}" == "true" ] ; then
        cp -rf "$EXPANDED" "$OUTPUT_DIR/$EXPANDED" 
    fi
    cd $OUTPUT_DIR
fi

# Clear out any left over artifacts from last regeneration
if [ "${SKIP_REGENERATION}" != "true" ] ; then
    echo "Deleting old template output..."
    rm -rf "${EXPANDED}/"
    echo "Regenerating template..."
else
    echo "Performing dry run on existing template output..."
fi

# Make the tree
find ./PRODUCTNAME -type d | while read FILE
do
    NEWFILE=`echo $FILE | sed -e "s/${LOOKUP}/${EXPANDED}/g"`
    MKDIR_CMD="mkdir -p \"$NEWFILE\""
    if [ "${VERBOSE}" == "true" ] ; then
        echo "${MKDIR_CMD}"
    fi
    if [ "${SKIP_REGENERATION}" != "true" ] ; then
        eval $MKDIR_CMD
    fi
done

# Copy the files over
find ./PRODUCTNAME -type f | while read FILE
do
    NEWFILE=`echo $FILE | sed -e "s/${LOOKUP}/${EXPANDED}/g"`
    COPY_CMD="cp \"$FILE\" \"$NEWFILE\""
    if [ "${VERBOSE}" == "true" ] ; then
        echo "${COPY_CMD}"
    fi
    if [ "${SKIP_REGENERATION}" != "true" ] ; then
        eval $COPY_CMD
    fi
done

# Do replacements
function replace {
    grep -rl $1 ./PRODUCTNAME | while read FILE
    do 
    NEWFILE=`echo $FILE | sed -e "s/${LOOKUP}/${EXPANDED}/g"`
        SED_CMD="LC_ALL=C sed -e \"s/$1/$2/g\" \"$NEWFILE\" > t1 && mv t1 \"$NEWFILE\""
        # Copy over incase the sed fails due to encoding
        #echo "echo \"$FILE\""
        if [ "${VERBOSE}" == "true" ] ; then
            echo "${SED_CMD}"
        fi
        if [ "${SKIP_REGENERATION}" != "true" ] ; then
            eval $SED_CMD
        fi        
    done
}

replace "PRODUCTNAME" "{{ cookiecutter.project_name | replace(' ', '') }}"
replace "ORGANIZATION" "{{ cookiecutter.company_name }}"
replace "LEADDEVELOPER" "{{ cookiecutter.lead_dev }}"
replace "LEADEMAIL" "{{ cookiecutter.lead_email }}"
replace "com.raizlabs.PRODUCTNAME" "{{ cookiecutter.bundle_identifier }}"

if [ "${SKIP_REGENERATION}" == "true" ] ; then
    echo "Dry run complete."
else
    # Delete files that we don't want to include in the template
    rm -rf "${EXPANDED}/app/Podfile.lock"
    rm -rf "${EXPANDED}/app/Pods"
    rm -rf "${EXPANDED}/app/${EXPANDED}.xcworkspace"
    rm -rf "${EXPANDED}/app/build"
    rm -rf "${EXPANDED}/app/fastlane/build"
    rm -rf "${EXPANDED}/app/fastlane/screenshots"
    echo "Template generation complete."
fi

# Run Tests

# cookiecutter default output dir is ProjectName
TEST_OUTPUT_DIR="ProjectName"
cookiecutter --no-input --overwrite-if-exists ./

if [ "${SKIP_TESTS}" == "true" ] ; then
    echo "Skipping tests..."
else    
    echo "Running tests..."

    pushd "$TEST_OUTPUT_DIR/app"
        bundle install
        bundle exec pod install
        bundle exec fastlane test
    popd
fi

if [ "${KEEP_COOKIECUTTER_OUTPUT}" == "true" ] ; then
    echo "cookiecutter output kept in ${TEST_OUTPUT_DIR}"
else
    rm -rf "${TEST_OUTPUT_DIR}"
fi

echo "Tests complete."