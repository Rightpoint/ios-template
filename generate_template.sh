# This is a shell script to transform the PRODUCTNAME directory into a cookie-cutter template

# Delete files that we don't want to include in the template
rm -rf PRODUCTNAME/app/Pods
rm -rf PRODUCTNAME/app/PRODUCTNAME.xcworkspace

#This is the only lookup that is done on filenames
LOOKUP="PRODUCTNAME"
EXPANDED="{{ cookiecutter.project_name | replace(' ', '') }}"

# Make the tree
find ./PRODUCTNAME -type d | while read FILE
do
    NEWFILE=`echo $FILE | sed -e "s/${LOOKUP}/${EXPANDED}/g"`
    echo "mkdir -p \"$NEWFILE\""
done

# Copy the files over
find ./PRODUCTNAME -type f | while read FILE
do
    NEWFILE=`echo $FILE | sed -e "s/${LOOKUP}/${EXPANDED}/g"`
    echo "cp \"$FILE\" \"$NEWFILE\""
done

# Do replacements
function replace {
    grep -rl $1 ./PRODUCTNAME | while read FILE
    do 
    NEWFILE=`echo $FILE | sed -e "s/${LOOKUP}/${EXPANDED}/g"`
        # Copy over incase the sed fails due to encoding
        #echo "echo \"$FILE\""
        echo "sed -e \"s/$1/$2/g\" \"$NEWFILE\" > t1 && mv t1 \"$NEWFILE\""
    done
}

replace "PRODUCTNAME" "{{ cookiecutter.project_name | replace(' ', '') }}"
replace "ORGANIZATION" "{{ cookiecutter.company_name }}"
replace "LEADDEVELOPER" "{{ cookiecutter.lead_dev }}"
replace "LEADEMAIL" "{{ cookiecutter.lead_email }}"
replace "com.raizlabs.PRODUCTNAME" "{{ cookiecutter.bundle_identifier }}"
