#!/bin/bash

    defaults read $2/GEuropeMobile/Grosvenor.ios/Info CFBundleVersion
       
    buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$2/GEuropeMobile/Grosvenor.ios/Info.plist")
    buildNumber=$(($buildNumber + 1))
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "$2/GEuropeMobile/Grosvenor.ios/Info.plist"
defaults read $2/GEuropeMobile/Grosvenor.ios/Info CFBundleVersion

if [ "$1" = "HA_Dev" ]
        then 
        sed -i.bu 's/geuropeapp/dgeuropeapp/g' "Info.plist"
        rm "Info.plist.bu"
        sed -i.bu 's/>Grosvenor/>GE_Dev/g' "Info.plist"
        rm "Info.plist.bu"      
elif [ "$1" = "HA_Staging" ]
        then 
        sed -i.bu 's/geuropeapp/sgeuropeapp/g' "Info.plist"
        rm "Info.plist.bu"
        sed -i.bu 's/>Grosvenor/>GE_Staging/g' "Info.plist"
        rm "Info.plist.bu"
elif [ "$1" = "HA_Live" ]
        then
        git checkout -b develop
git add -u
git status
git commit "-m" "Build Agent - update iOS version number."
git remote -v
git push -u origin --all
        sed -i.bu 's/geuropeapp/lgeuropeapp/g' "Info.plist"
        rm "Info.plist.bu"
        sed -i.bu 's/>Grosvenor/>GE_Live/g' "Info.plist"
        rm "Info.plist.bu"
    
fi